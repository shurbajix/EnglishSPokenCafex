import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class Friday extends StatefulWidget {
  const Friday({Key? key}) : super(key: key);

  @override
  State<Friday> createState() => _FridayState();
}

class _FridayState extends State<Friday> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  late WebViewController _webViewController;
  final bool _notificationOpened = false;
  String _selectedWord = ''; // Selected word to show the definition
  bool _isDictionaryOpen = false; // Flag to track dictionary pop-up state
  String _definition = ''; // Definition of the selected word

  @override
  void initState() {
    super.initState();
    _configureOneSignal();
  }

  void _configureOneSignal() {
    // Configure OneSignal here
  }

  void openDictionary(String word) async {
    final url = 'https://sozluk.gov.tr/gts?ara=$word';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void showDictionaryDefinition(String word) {
    setState(() {
      _selectedWord = word;
      _isDictionaryOpen = true;
    });

    // Make web scraping request to retrieve the definition of the word
    fetchDefinition(word).then((definition) {
      setState(() {
        _definition = definition;
      });

      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dictionary Definition',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  _definition,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isDictionaryOpen = false;
                      _selectedWord = '';
                      _definition = '';
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Future<String> fetchDefinition(String word) async {
    final url = 'https://tureng.com/tr/turkce-ingilizce/$word';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parse the HTML response to extract the definition
        final definition = parseDefinitionFromHtml(response.body);
        return definition;
      } else {
        throw 'Failed to fetch definition. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to fetch definition: $e';
    }
  }

  String parseDefinitionFromHtml(String htmlString) {
    final document = parser.parse(htmlString);
    final definitionElement = document.querySelector('.turkish');
    if (definitionElement != null) {
      return definitionElement.text;
    } else {
      return 'No definition found.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (_notificationOpened) {
              SystemNavigator.pop();
            } else {
              Navigator.of(context).pop();
            }
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('Friday'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _notificationOpened
                ? Center(
                    child: Text(
                      'Notification opened inside the Flutter app.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: WebView(
                        initialUrl: 'https://www.englishspokencafe.com/friday/',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          _webViewController = webViewController;
                          _controller.complete(webViewController);
                        },
                        onPageStarted: (String url) {
                          print('Page started loading: $url');
                          _webViewController.runJavascript(
                            "document.getElementsByTagName('header')[0].style.display='none'",
                          );
                          _webViewController.runJavascript(
                            "document.getElementsByTagName('footer')[0].style.display='none'",
                          );
                        },
                        onPageFinished: (String url) {
                          print('Page finished loading: $url');
                          _webViewController.runJavascript(
                            "document.getElementsByTagName('header')[0].style.display='none'",
                          );
                          _webViewController.runJavascript(
                            "document.getElementsByTagName('footer')[0].style.display='none'",
                          );
                        },
                        navigationDelegate: (NavigationRequest request) {
                          if (request.url.contains(
                              'https://www.englishspokencafe.com/friday/')) {
                            return NavigationDecision.navigate;
                          } else {
                            return NavigationDecision.navigate;
                          }
                        },
                        javascriptChannels: <JavascriptChannel>{
                          JavascriptChannel(
                            name: 'DictionaryChannel',
                            onMessageReceived: (JavascriptMessage message) {
                              if (!_isDictionaryOpen) {
                                showDictionaryDefinition(message.message);
                              }
                            },
                          ),
                        },
                        onProgress: (int progress) {
                          print("WebView is loading (progress: $progress%)");
                          _webViewController.runJavascript(
                            "document.addEventListener('click', (event) => {"
                            "  if (event.target.tagName.toLowerCase() == 'span') {"
                            "    var word = event.target.innerText.trim();"
                            "    DictionaryChannel.postMessage(word);"
                            "  }"
                            "});",
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

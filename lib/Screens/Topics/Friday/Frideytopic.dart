import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class Freidytopic extends StatefulWidget {
  const Freidytopic({super.key});

  @override
  State<Freidytopic> createState() => _FreidytopicState();
}

class _FreidytopicState extends State<Freidytopic> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  late WebViewController _webViewController;
  final bool _notificationOpened = false;
  String _selectedWord = ''; // Selected word to show the definition
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

  Future<String> fetchDefinitionFromAPI(String word) async {
    const lang = 'en'; // Language for English
    final url = 'https://api.dictionaryapi.dev/api/v2/entries/$lang/$word';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final firstEntry = jsonResponse.first;
        final List<dynamic> meanings = firstEntry['meanings'];
        final definition = meanings.first['definitions'].first['definition'];
        return definition;
      } else {
        throw 'Failed to fetch definition. Status code: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Failed to fetch definition: $e';
    }
  }

  void showDictionaryDefinition(String word) async {
    setState(() {
      _selectedWord = word;
    });

    try {
      final definition = await fetchDefinitionFromAPI(word);
      setState(() {
        _definition = definition;
      });
    } catch (e) {
      print('Error fetching definition: $e');
    }

    showDefinitionPopupMenu(_definition);
  }

  void showDefinitionPopupMenu(String definition) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromCenter(
        center: overlay.localToGlobal(overlay.size.center(Offset.zero)),
        width: 0,
        height: 0,
      ),
      Offset.zero & overlay.size,
    );

    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final TextStyle defaultStyle = popupMenuTheme.textStyle ?? TextStyle();

    final List<PopupMenuEntry<String>> popupItems = <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        enabled: false,
        child: Text(
          definition,
          style: defaultStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    ];

    showMenu<String>(
      context: context,
      elevation: popupMenuTheme.elevation,
      items: popupItems,
      position: position,
      shape: popupMenuTheme.shape,
    );
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
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  title: Text(
                    _selectedWord,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_definition),
                ),
              ),
            ],
            onSelected: (value) {
              setState(() {
                _selectedWord = '';
                _definition = '';
              });
            },
            icon: Icon(Icons.info_outline),
          ),
        ],
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
                              setState(() {
                                _definition = message.message;
                              });
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

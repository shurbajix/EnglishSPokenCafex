import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class Juniorlink extends StatefulWidget {
  const Juniorlink({Key? key}) : super(key: key);

  @override
  State<Juniorlink> createState() => _Junior1State();
}

class _Junior1State extends State<Juniorlink> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController _webViewController;
  String? _selectedText;
  String? _definition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('JUNIOR3'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: AspectRatio(
                aspectRatio: 1,
                child: WebView(
                  initialUrl: 'https://www.englishspokencafe.com/junior3/',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _webViewController = webViewController;
                    onWebViewCreated:
                    (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    };
                    javascriptChannels:
                    <JavascriptChannel>{
                      _createJavascriptChannel(context),
                    };
                  },
                  onProgress: (int progress) {
                    print("WebView is loading(progress:$progress%)");
                    _webViewController.runJavascript(
                      "document.getElementsByTagName('header')[0].style.display='none'",
                    );
                    _webViewController.runJavascript(
                      "document.getElementsByTagName('footer')[0].style.display='none'",
                    );
                  },
                  onPageStarted: (String url) {
                    print('page started loading :$url');
                    _webViewController.runJavascript(
                      "document.getElementsByTagName('header')[0].style.display='none'",
                    );
                    _webViewController.runJavascript(
                      "document.getElementsByTagName('footer')[0].style.display='none'",
                    );
                  },
                  onPageFinished: (String url) {
                    _webViewController.runJavascript("""
                
                    document.addEventListener('selectionchange', function() {
                      var selectedText = window.getSelection().toString();
                      SelectionChannel.postMessage(selectedText);
                    });
                  """);
                    print('Page finished loading: $url');
                    _webViewController.runJavascript(
                      "document.getElementsByTagName('header')[0].style.display='none'",
                    );
                    _webViewController.runJavascript(
                      "document.getElementsByTagName('footer')[0].style.display='none'",
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _definition != null ? Text(_definition!) : null,
    );
  }

  JavascriptChannel _createJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'lookup',
        onMessageReceived: (JavascriptMessage message) {
          _showDefinition(context, message.message);
        });
  }

  Future<void> _showDefinition(BuildContext context, String word) async {
    const apiKey = 'http://www.uludagsozluk.com/api/?c=getkey';
    const apiUrl = 'http://www.uludagsozluk.com/api/?c=getkey';

    final response = await http.get(apiUrl as Uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      if (data.isNotEmpty && data[0].containsKey('shortdef')) {
        final List<dynamic> definitions = data[0]['shortdef'];
        final String definition = definitions.join('\n');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(word),
              content: Text(definition),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(word),
              content: Text('No definition found for $word'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to get definition for $word'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
}

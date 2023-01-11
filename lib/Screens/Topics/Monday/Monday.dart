import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Mondays extends StatefulWidget {
  const Mondays({
    Key? key,
    required this.title,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String title;
  final String text;
  final String image;

  @override
  State<Mondays> createState() => _MondaysState();
}

class _MondaysState extends State<Mondays> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('Monday'),
      ),
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: WebView(
                initialUrl: 'https://www.englishspokencafe.com/monday/',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (
                  WebViewController webViewController,
                ) {
                  _webViewController = webViewController;
                  _controller.complete(
                    webViewController,
                  );
                },
                onProgress: (int progress) {
                  print(
                    "WebView is loading(progress:$progress%)",
                  );
                  _webViewController.runJavascript(
                      "document.getElementsByTagName('header')[0].style.display='none'");

                  _webViewController.runJavascript(
                    "document.getElementsByTagName('footer')[0].style.display='none'",
                  );
                },
                onPageStarted: (String url) {
                  print(
                    'page started loading :$url',
                  );
                  _webViewController.runJavascript(
                    "document.getElementsByTagName('header')[0].style.display='none'",
                  );
                  _webViewController.runJavascript(
                    "document.getElementsByTagName('footer')[0].style.display='none'",
                  );
                },
                onPageFinished: (String url) {
                  print(
                    'Page finished loading: $url',
                  );
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
        ],
      ),
    );
  }
}

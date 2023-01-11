import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Tuesday extends StatefulWidget {
  const Tuesday({Key? key}) : super(key: key);

  @override
  State<Tuesday> createState() => _TuesdayState();
}

class _TuesdayState extends State<Tuesday> {
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
        title: const Text(
          'Tuesday',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: WebView(
                initialUrl: 'https://www.englishspokencafe.com/tuesday/',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _webViewController = webViewController;
                  _controller.complete(webViewController);
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
        ],
      ),
    );
  }
}

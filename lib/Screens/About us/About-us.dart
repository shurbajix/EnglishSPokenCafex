import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Aboutus extends StatefulWidget {
  Aboutus({Key? key}) : super(key: key);

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
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
          'About us',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: WebView(
                  initialUrl: 'https://www.englishspokencafe.com/',
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
          ),
        ],
      ),
    );
  }
}

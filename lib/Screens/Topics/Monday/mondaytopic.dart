import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_last/classes/Classe.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Mondaytopic extends StatefulWidget {
  const Mondaytopic({super.key, required url, required this.initialUrl});
  final String initialUrl;

  @override
  State<Mondaytopic> createState() => _MondaytopicState();
}

class _MondaytopicState extends State<Mondaytopic> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  late WebViewController _webViewController;

  late String url;
  int indextitle = 0;
  @override
  Widget build(BuildContext context) {
    //String initialUrl = topicsspeak[2];
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
        title: Text(
          speaklevel[indextitle],
        ),
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
                  initialUrl: widget.initialUrl,
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
          ),
        ],
      ),
    );
  }
}

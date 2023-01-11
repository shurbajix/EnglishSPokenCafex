import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_last/Screens/Gather_Junior/Junior1.dart';
import 'package:flutter_application_last/Screens/Gather_Junior/Junior2.dart';
import 'package:flutter_application_last/Screens/Gather_Junior/Junior3.dart';
import 'package:flutter_application_last/classes/Classe.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> izinleriIste() async {
  var camerastatus = await Permission.camera.status;
  var microfonstatus = await Permission.microphone.status;
  if (!camerastatus.isGranted) {
    await Permission.camera.request();
  }

  if (!microfonstatus.isGranted) {
    await Permission.microphone.request();
  }
}

class Gather_Junior extends StatefulWidget {
  Gather_Junior({Key? key}) : super(key: key);

  @override
  State<Gather_Junior> createState() => _Gather_JuniorState();
}

class _Gather_JuniorState extends State<Gather_Junior> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      Platform.isAndroid;
    }
    if (Platform.isIOS) {
      Platform.isIOS;
    }
  }

  late InAppWebViewController webViewController;

  Future<bool> _onBack() async {
    bool goBack;
    var value = await webViewController.canGoBack();
    if (value) {
      webViewController.goBack();
      return false;
    } else {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD9D9D9),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Gather Junior',
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: 74,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      abrirWhatsApp();
                    });
                  },
                  icon: Image.asset(
                    'images/whtsapp.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          Get.to(
                            Junior1(),
                          );
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/Junior-1-gather.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Card(
                    child: TextButton(
                      onPressed: () {
                        setState(
                          () {
                            Get.to(
                              Junior2(),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/Junior-2-gather.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Card(
                    child: TextButton(
                      onPressed: () {
                        Get.to(
                          Junior3(),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/Junior-3-gather.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  abrirWhatsApp() async {
    var whatsappUrl = "https://chat.whatsapp.com/BavPZNIzg429LPFHun5vri";

    if (await canLaunch(whatsappUrl)) {
      await launch(
        whatsappUrl,
      );
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}

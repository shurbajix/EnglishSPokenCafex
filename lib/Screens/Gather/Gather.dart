import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_last/Screens/Gather/Canspeakfuntly.dart';
import 'package:flutter_application_last/Screens/Gather/Commongather.dart';
import 'package:flutter_application_last/Screens/Gather/Spaekcant.dart';
import 'package:flutter_application_last/Screens/Gather/speakcan.dart';
import 'package:flutter_application_last/Screens/Gather_Junior/Junior1.dart';
import 'package:flutter_application_last/Screens/Gather_Junior/Junior3.dart';
import 'package:flutter_application_last/Screens/Topics/JUNIOR2/Junior2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Gathers extends StatefulWidget {
  Gathers({Key? key}) : super(key: key);

  @override
  State<Gathers> createState() => _GathersState();
}

class _GathersState extends State<Gathers> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD9D9D9),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Gather'),
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
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: TextButton(
                      onPressed: () {
                        setState(
                          () {
                            Get.to(
                              speakcan(),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/I-cant-speak-Gather.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: TextButton(
                      onPressed: () {
                        setState(
                          () {
                            Get.to(
                              speakcant(),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/I-can-speak-Gather.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          Get.to(
                            speakcanfluntly(),
                          );
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'images/I-can-speak-fluently-Gather.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          Get.to(
                            Commongsther(),
                          );
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/commongather.png'),
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
    var whatsappUrl = "https://chat.whatsapp.com/KWFRJ4ldKRz8iD4cR2urOZ";

    if (await canLaunch(whatsappUrl)) {
      await launch(
        whatsappUrl,
      );
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}

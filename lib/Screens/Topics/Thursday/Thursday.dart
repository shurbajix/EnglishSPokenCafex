import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../classes/Classe.dart';
import 'thursdaytopic.dart';

class Thursday extends StatefulWidget {
  const Thursday({Key? key}) : super(key: key);

  @override
  State<Thursday> createState() => _ThursdayState();
}

class _ThursdayState extends State<Thursday> {
  List topicsspeak = [
    'https://www.englishspokencafe.com/i-cant-speak-monday/',
    'https://www.englishspokencafe.com/i-can-speak-monday/',
    'https://www.englishspokencafe.com/i-can-speak-f-monday/',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speak level'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 50,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.to(
                        Thursdaytopic(
                          url: topicsspeak[index],
                        ),
                      );
                    },
                    child: Text(
                      speaklevel[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void launchURL(String topicsspeak) async {
    if (await canLaunch(topicsspeak)) {
      await launch(Uri.parse(topicsspeak).toString());
    } else {
      throw 'Could not launch $topicsspeak';
    }
  }
}

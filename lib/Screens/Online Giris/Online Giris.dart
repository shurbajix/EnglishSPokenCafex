import 'package:flutter/material.dart';
import 'package:flutter_application_last/Video/Video_call.dart';
import 'package:get/get.dart';

class OnlineG extends StatefulWidget {
  const OnlineG({super.key});

  @override
  State<OnlineG> createState() => _OnlineGState();
}

class _OnlineGState extends State<OnlineG> {
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
        title: const Text('Online Giris'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Column(
                children: const [
                  Text(
                    " Start'ı tıklayın. Kutuya kodu yazıp enter tuşuna basın",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(
                50,
              ),
              child: Image.asset(
                'images/videocalls.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black,
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Get.to(
                      VideoCalls(),
                    );
                  },
                  child: const Text('Start'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

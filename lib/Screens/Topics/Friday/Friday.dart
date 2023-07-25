import 'package:flutter/material.dart';
import 'package:flutter_application_last/classes/Classe.dart';
import 'package:get/get.dart';

class Friday extends StatefulWidget {
  const Friday({Key? key}) : super(key: key);

  @override
  State<Friday> createState() => _FridayState();
}

class _FridayState extends State<Friday> {
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
                    onPressed: () {},
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
}

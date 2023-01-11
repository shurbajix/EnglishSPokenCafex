import 'package:flutter/material.dart';

import '../../Dialog/Dialog.dart';

class SocalMedia extends StatefulWidget {
  const SocalMedia({super.key});

  @override
  State<SocalMedia> createState() => _SocalMediaState();
}

class _SocalMediaState extends State<SocalMedia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text(
          "Socal Media",
        ),
      ),
      body: Stack(
        children: const [
          Center(
            child: Dialogway(),
          ),
        ],
      ),
    );
  }
}

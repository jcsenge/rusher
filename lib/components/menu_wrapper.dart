import 'dart:ui';
import 'package:flutter/material.dart';

class MenuWrapper extends StatelessWidget {
  late Widget asd;
  MenuWrapper({Key? key, required Widget asd}) : super(key: key) {
    this.asd = asd;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/cloud-0.png',
                  width: 800,
                  fit: BoxFit.cover,
                ),
                asd,
              ],
            )),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';

class MenuWrapper extends StatelessWidget {
  final Widget menuItems;
  const MenuWrapper({Key? key, required this.menuItems}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/grass_bg.png',
                  width: 800,
                  fit: BoxFit.fill,
                ),
                menuItems,
              ],
            )),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundDetail extends StatelessWidget {
  const BackgroundDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: [
          Positioned(
            top: 680,
            child: Container(
              height: 300,
              width: screenWidth,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color.fromRGBO(93, 158, 166, 1).withOpacity(.7),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 100,
                  sigmaY: 100,
                ),
                child: Container(
                  width: screenWidth,
                  height: 400,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

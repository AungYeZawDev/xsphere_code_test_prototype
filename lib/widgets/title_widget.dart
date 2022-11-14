import 'package:flutter/material.dart';
import 'package:xsphere_code_test_prototype/constants/custom_constants.dart';

Widget titleWidget(String title) {
  CustomConstants customConstants = CustomConstants();
  return ShaderMask(
    shaderCallback: (Rect bounds) => const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.white],
    ).createShader(bounds),
    child: Tooltip(
        message: 'Find your dream job',
        child: Text(
          title,
          style: customConstants.textStyle(
              color: Colors.white,
              isDarkMode: false,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )),
  );
}

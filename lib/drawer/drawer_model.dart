import 'package:flutter/material.dart';

enum DrawerIndex {
  home,
  profile,
  note,
  announchment,
  setting,
  about,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    required this.icon,
    required this.index,
    this.imageName = '',
  });

  String labelName;
  Icon icon;
  bool? isAssetsImage;
  String imageName;
  DrawerIndex index;
}

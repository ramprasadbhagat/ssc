
import 'package:flutter/material.dart';

class DeviceSize {
  static double? maxHeight;
  static double? maxWidth;

  static void init(BuildContext context){
    final size = MediaQuery.of(context).size;
    maxHeight = size.height;
    maxWidth = size.width;
  }

  static double height(double i) => (i / 812.0) *  maxHeight!;

  static double width(double i) => (i / 375.0) *  maxWidth!;
}
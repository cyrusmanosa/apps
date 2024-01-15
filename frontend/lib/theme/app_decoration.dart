import 'package:flutter/material.dart';
import 'package:dating_your_date/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillGray => BoxDecoration(color: appTheme.gray500);
  static BoxDecoration get fillPink => BoxDecoration(color: appTheme.pinkA100);
  static BoxDecoration get fillPrimary => BoxDecoration(color: appTheme.white);
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get r30 => BorderRadius.circular(30);
  static BorderRadius get r15 => BorderRadius.circular(15);
  static BorderRadius get r10 => BorderRadius.circular(10);
  static BorderRadius get r5 => BorderRadius.circular(5);
}
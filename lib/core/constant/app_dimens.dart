import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class AppDimens {
  AppDimens._();

  static final AppDimens instance = AppDimens._();

  // Splash Screen Specific
  static double get splashLogoWidth => 150.w;

  static double get splashLogoHeight => 150.h;
  static const int splashDelay = 3; // seconds
  static const int animationDuration = 1500; // milliseconds

  // Height constants
  static double get h1 => 1.h;

  static double get h2 => 2.h;

  static double get h4 => 4.h;

  static double get h8 => 8.h;

  static double get h12 => 12.h;

  static double get h14 => 14.h;

  static double get h16 => 16.h;

  static double get h20 => 20.h;

  static double get h24 => 24.h;

  static double get h32 => 32.h;

  static double get h48 => 48.h;

  static double get h64 => 64.h;

  static double get h96 => 96.h;

  static double get h110 => 110.h;

  static double get h128 => 128.h;

  static double get h150 => 150.h;

  static double get h200 => 200.h;

  static double get h300 => 300.h;

  // Width constants
  static double get w1 => 1.w;

  static double get w2 => 2.w;

  static double get w4 => 4.w;

  static double get w8 => 8.w;

  static double get w12 => 12.w;

  static double get w16 => 16.w;

  static double get w24 => 24.w;

  static double get w32 => 32.w;

  static double get w48 => 48.w;

  static double get w60 => 60.w;

  static double get w64 => 64.w;

  static double get w96 => 96.w;

  static double get w120 => 120.w;

  static double get w128 => 128.w;

  static double get w150 => 150.w;

  // Radius constants
  static double get r4 => 4.r;

  static double get r8 => 8.r;

  static double get r12 => 12.r;

  static double get r16 => 16.r;

  static double get r20 => 20.r;

  static double get r24 => 24.r;

  static double get r32 => 32.r;

  static double get rFull => 1000.r;

  // Font sizes
  static double get sp10 => 10.sp;

  static double get sp12 => 12.sp;

  static double get sp14 => 14.sp;

  static double get sp16 => 16.sp;

  static double get sp18 => 18.sp;

  static double get sp20 => 20.sp;

  static double get sp24 => 24.sp;

  static double get sp32 => 32.sp;

  // Standard padding sets
  static EdgeInsets get paddingSmall => EdgeInsets.all(h8);

  static EdgeInsets get paddingMedium => EdgeInsets.all(h16);

  static EdgeInsets get paddingLarge => EdgeInsets.all(h24);

  // Horizontal padding
  static EdgeInsets get paddingHorizontalSmall =>
      EdgeInsets.symmetric(horizontal: w8);

  static EdgeInsets get paddingHorizontalMedium =>
      EdgeInsets.symmetric(horizontal: w16);

  static EdgeInsets get paddingHorizontalLarge =>
      EdgeInsets.symmetric(horizontal: w24);

  // Vertical padding
  static EdgeInsets get paddingVerticalSmall =>
      EdgeInsets.symmetric(vertical: h8);

  static EdgeInsets get paddingVerticalMedium =>
      EdgeInsets.symmetric(vertical: h16);

  static EdgeInsets get paddingVerticalLarge =>
      EdgeInsets.symmetric(vertical: h24);
}

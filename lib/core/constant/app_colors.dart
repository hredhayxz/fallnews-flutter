import 'package:flutter/material.dart';

final class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color primaryLight = Color(0xFF8AB4F8);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

  // Secondary Colors
  static const Color secondary = Color(0xFF34A853);
  static const Color secondaryDark = Color(0xFF1E8E3E);
  static const Color secondaryLight = Color(0xFF81C995);

  // Status Colors
  static const Color error = Color(0xFFEA4335);
  static const Color errorLight = Color(0xFFF28B82);
  static const Color warning = Color(0xFFFBBC05);
  static const Color success = Color(0xFF34A853);
  static const Color info = Color(0xFF4285F4);

  // Background/Surface Colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color backgroundDark = Color(0xFF121212);

  // On Colors
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF202124);
  static const Color onSurface = Color(0xFF202124);
  static const Color onSurfaceDark = Color(0xFFFFFFFF);

  // Text Colors
  static const Color primaryText = Color(0xFF202124);
  static const Color secondaryText = Color(0xFF5F6368);
  static const Color hintText = Color(0xFF9E9E9E);
  static const Color disabledText = Color(0xFFBDBDBD);

  // Neutral Colors
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Light Color Scheme
  static final ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: onSecondary,
    error: error,
    onError: onError,
    surface: surface,
    onSurface: onSurface,
  );

  // Dark Color Scheme
  static final ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryLight,
    onPrimary: onBackground,
    secondary: secondaryLight,
    onSecondary: onBackground,
    error: errorLight,
    onError: onError,
    surface: surfaceDark,
    onSurface: onSurfaceDark,
  );
}

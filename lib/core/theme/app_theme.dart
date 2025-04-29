import 'package:fallnews/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  AppTheme._();

  // Light Theme
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.surface,
      iconTheme: IconThemeData(color: AppColors.black, size: 24.w),
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      headlineLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      bodyLarge: TextStyle(fontSize: 16.sp, color: AppColors.grey800),
      bodyMedium: TextStyle(fontSize: 14.sp, color: AppColors.grey600),
      bodySmall: TextStyle(fontSize: 12.sp, color: AppColors.grey600),
      labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
    ),
    cardTheme: CardTheme(
      elevation: 2.w,
      margin: EdgeInsets.all(8.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
      color: AppColors.surface,
    ),
    buttonTheme: ButtonThemeData(
      height: 48.h,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
        backgroundColor: AppColors.primary,
        // <<< use primary
        foregroundColor: AppColors.onPrimary,
        // <<< use onPrimary for text color
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.w),
        borderSide: BorderSide(color: AppColors.grey300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.w),
        borderSide: BorderSide(color: AppColors.grey300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.w),
        borderSide: BorderSide(color: AppColors.primary, width: 1.w),
      ),
    ),
    dividerTheme: DividerThemeData(
      thickness: 1.w,
      space: 1.w,
      color: AppColors.grey200,
    ),
  );

  // Dark Theme
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.surfaceDark,
      iconTheme: IconThemeData(color: AppColors.white, size: 24.w),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      headlineLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      bodyLarge: TextStyle(fontSize: 16.sp, color: AppColors.grey300),
      bodyMedium: TextStyle(fontSize: 14.sp, color: AppColors.grey400),
      bodySmall: TextStyle(fontSize: 12.sp, color: AppColors.grey400),
      labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
    ),
    cardTheme: CardTheme(
      elevation: 2.w,
      margin: EdgeInsets.all(8.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
      color: AppColors.surfaceDark,
    ),
    buttonTheme: ButtonThemeData(
      height: 48.h,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.onBackground,
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.w),
        borderSide: BorderSide(color: AppColors.grey700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.w),
        borderSide: BorderSide(color: AppColors.grey700),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.w),
        borderSide: BorderSide(color: AppColors.primaryLight, width: 1.w),
      ),
      fillColor: AppColors.surfaceDark,
      filled: true,
    ),
    dividerTheme: DividerThemeData(
      thickness: 1.w,
      space: 1.w,
      color: AppColors.grey800,
    ),
  );
}

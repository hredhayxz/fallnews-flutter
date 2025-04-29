import 'package:fallnews/core/constant/app_dimens.dart';
import 'package:fallnews/core/constant/app_strings.dart';
import 'package:fallnews/core/routes/app_routes.dart';
import 'package:fallnews/core/utils/wrapper_utils.dart';
import 'package:fallnews/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 3)).then((_) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.newsHome);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            WrapperUtils.svgImage(
              assetPath: Assets.images.newsAppLogo,
              height: AppDimens.splashLogoHeight,
              width: AppDimens.splashLogoWidth,
            ),
            SizedBox(height: AppDimens.h24),
            Text(
              AppStrings.appName,
              style: textTheme.displayLarge?.copyWith(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5.w,
              ),
            ),

            SizedBox(height: AppDimens.h8),
            Text(
              AppStrings.appTagline,
              style: textTheme.titleMedium?.copyWith(
                fontSize: 14.sp,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

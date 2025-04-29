import 'package:fallnews/core/routes/app_routes.dart';
import 'package:fallnews/data/models/news_data_model.dart';
import 'package:fallnews/presentation/features/auth/forgot_password_screen.dart';
import 'package:fallnews/presentation/features/auth/login_screen.dart';
import 'package:fallnews/presentation/features/auth/registration_screen.dart';
import 'package:fallnews/presentation/features/bookmark_news/bookmark_news_screen.dart';
import 'package:fallnews/presentation/features/news_details/news_details_screen.dart';
import 'package:fallnews/presentation/features/news_home/news_home_screen.dart';
import 'package:fallnews/presentation/features/settings/settings_screen.dart';
import 'package:fallnews/presentation/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

final class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        return _fadeRoute(const SplashScreen(), settings);
      case AppRoutes.newsHome:
        return _fadeRoute(const NewsHomeScreen(), settings);
      case AppRoutes.bookmarkNews:
        return _fadeRoute(const BookmarkNewsScreen(), settings);
      case AppRoutes.details:
        final news = args as Articles;
        return _fadeRoute(NewsDetailScreen(news: news), settings);
      case AppRoutes.settings:
        return _fadeRoute(const SettingsScreen(), settings);
      case AppRoutes.login:
        return _slideRoute(LoginScreen(), settings);
      case AppRoutes.register:
        return _slideRoute(const RegistrationScreen(), settings);
      case AppRoutes.forgotPassword:
        return _slideRoute(const ForgotPasswordScreen(), settings);

      default:
        return _errorRoute();
    }
  }

  // Custom route transitions
  static Route<dynamic> _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Route<dynamic> _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _materialRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Route not found')),
          ),
    );
  }
}

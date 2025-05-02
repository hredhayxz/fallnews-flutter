import 'package:fallnews/core/routes/app_routes.dart';
import 'package:fallnews/core/routes/route_generator.dart';
import 'package:fallnews/core/theme/app_theme.dart';
import 'package:fallnews/presentation/features/auth/bloc/auth/auth_bloc.dart';
import 'package:fallnews/presentation/features/auth/bloc/password_visivility/password_visibility_bloc.dart';
import 'package:fallnews/presentation/features/news_home/bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FallNewsApp extends StatelessWidget {
  const FallNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsBloc()),
        BlocProvider(create: (context) => PasswordVisibilityBloc()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fall News',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: RouteGenerator.generateRoute,
            builder: (context, child) {
              ScreenUtil.init(context);
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(1.0)),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:fallnews/app.dart';
import 'package:fallnews/core/di/dependency_injection_service.dart';
import 'package:fallnews/data/local/local_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB.initializeHive();
  await dotenv.load(fileName: ".env");
  await diSetup();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(const FallNewsApp()));
}

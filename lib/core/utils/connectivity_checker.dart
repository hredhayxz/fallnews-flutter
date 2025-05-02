import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityChecker {
  Future<bool> hasInternetConnection() async {
    return await InternetConnection().hasInternetAccess;
  }
}

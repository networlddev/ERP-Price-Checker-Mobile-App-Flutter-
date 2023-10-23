import 'package:flutter/material.dart';
import 'package:netpospricechecker/view/price_checker_screen.dart';
import 'package:netpospricechecker/view/shared_folder_config_screen.dart';
import 'package:netpospricechecker/view/user_validation_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String userValidationScreen = '/user_validation';
  static const String sharedFolderConfigScreen = '/share_folder_config';
  static const String priceCheckerScreen = '/price_checker';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.userValidationScreen:
        return MaterialPageRoute(builder: (_) => UserValidationScreen());
      case Routes.sharedFolderConfigScreen:
        return MaterialPageRoute(
            builder: (_) => const SharedFolderConfigScreen());
            case Routes.priceCheckerScreen:
        return MaterialPageRoute(
            builder: (_) => const PriceCheckerScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No Route Found"),
        ),
        body: const Center(
          child: Text("No Route Found"),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:netpospricechecker/app_constants/images_paths.dart';
import 'package:netpospricechecker/core/utils/navigation_check_utilty.dart';
import 'package:netpospricechecker/view/price_checker_screen.dart';
import 'package:netpospricechecker/view/shared_folder_config_screen.dart';
import 'package:netpospricechecker/view/user_validation_screen.dart';

class NavigationCheck extends StatefulWidget {
  const NavigationCheck({super.key});

  @override
  State<NavigationCheck> createState() => _NavigationCheckState();
}

class _NavigationCheckState extends State<NavigationCheck> {
  Pages page = Pages.userValidationScreen;

  @override
  Widget build(BuildContext context) {
    page = NavigationCheckUtility.getNavigationPage();

    switch (page) {
      case Pages.priceCheckerScreen:
        return const PriceCheckerScreen();
      case Pages.urlScreen:
        return const SharedFolderConfigScreen();
      case Pages.userValidationScreen:
        return UserValidationScreen();
      default:
        return UserValidationScreen();
    }
  }
}

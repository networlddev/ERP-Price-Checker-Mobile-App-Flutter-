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
      // case Routes.splashScreen:
      //   return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.userValidationScreen:
        return MaterialPageRoute(builder: (_) => UserValidationScreen());
      case Routes.sharedFolderConfigScreen:
        return MaterialPageRoute(
            builder: (_) => const SharedFolderConfigScreen());
            case Routes.priceCheckerScreen:
        return MaterialPageRoute(
            builder: (_) => const PriceCheckerScreen());
      // case Routes.mainScreen:
      //   return MaterialPageRoute(builder: (_) => const MainScreen());
      // case Routes.editProfile:
      //   return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      // case Routes.changePassword:
      //   return MaterialPageRoute(builder: (_) => const ChangePassword());
      // case Routes.getHelp:
      //   return MaterialPageRoute(builder: (_) => const GetHelpScreen());
      // case Routes.viewPage:
      //   return FadePageRoute(page: const ItemViewPage());
      // case Routes.viewPageLoading:
      //   return FadePageRoute(page: const ViewPageLoading());
      // case Routes.productPurPage:
      //   return MaterialPageRoute(builder: (_) => const ProductPurchasePage());
      // case Routes.StockUpdate:
      //   return MaterialPageRoute(builder: (_) => const StockUpdateScreen());
      //     case Routes.importMaster:
      //   return MaterialPageRoute(builder: (_) => const ImportMasterScreen());
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

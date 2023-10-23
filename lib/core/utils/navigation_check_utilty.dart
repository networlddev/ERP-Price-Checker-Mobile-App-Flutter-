import 'package:hive/hive.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';
import 'package:netpospricechecker/core/utils/utility.dart';

class NavigationCheckUtility {
  NavigationCheckUtility._();

  static Future<Pages> getNavigationPage() async {
    var authenticationKey = Hive.box(HiveBoxes.authenticationBox)
        .get(HiveBoxes.authenticationBoxKey);
    var url = Hive.box(HiveBoxes.urlBox).get(HiveBoxes.urlBoxKey);

    if (authenticationKey == null || authenticationKey == "") {
      return Pages.userValidationScreen;
    } else if (await Utility.hasExpiryDatePassed()) {
      return Pages.userValidationScreen;
    } else if (authenticationKey != null &&
        authenticationKey != "" &&
        await Utility.hasExpiryDatePassed() != true &&
        url == null) {
      return Pages.urlScreen;
    } else if (authenticationKey == null &&
        authenticationKey == "" &&
        url == null) {
      return Pages.userValidationScreen;
    } else {
      return Pages.priceCheckerScreen;
    }
  }
}

enum Pages { priceCheckerScreen, urlScreen, userValidationScreen }

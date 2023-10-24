import 'package:hive/hive.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';
import 'package:netpospricechecker/core/utils/utility.dart';

class NavigationCheckUtility {
  NavigationCheckUtility._();

  static Pages getNavigationPage()  {
    var authenticationKey = Hive.box(HiveBoxes.authenticationBox)
        .get(HiveBoxes.authenticationBoxKey);
    var url = Hive.box(HiveBoxes.urlBox).get(HiveBoxes.urlBoxKey);
    bool hasPassed =  Utility.hasExpiryDatePassed();

    if (authenticationKey == null || authenticationKey == "") {
      return Pages.userValidationScreen;
    } else if (hasPassed) {
      return Pages.userValidationScreen;
    } else if (authenticationKey != null &&
        authenticationKey != "" &&
         hasPassed != true &&
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

import 'package:hive/hive.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';
import 'package:netpospricechecker/core/network/api_urls.dart';

class ImagesPath {
  static const backgroundImage = 'assets/price_checker.png';
  static const networldLogoImage = 'assets/networld-logo.png';
    static const networldLogoImage1 = 'assets/networld-logo-1.png';

  static const customerLogoImage = 'assets/price_checker_customer_logo.jpeg';

  static String getCustomerImagePath() {
    var url = Hive.box(HiveBoxes.urlBox).get(HiveBoxes.urlBoxKey);
    return "$url${ApiUrls.custLogoPath}";
  }
}

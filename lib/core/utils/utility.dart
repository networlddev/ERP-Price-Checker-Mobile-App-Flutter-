import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';

class Utility {
  static String convertIpAddress(String ipAddress) {
    List<String> parts = ipAddress.split('.');

    String result = '';

    for (String part in parts) {
      result += part;
    }

    if (result.length > 9) {
      result = result.substring(0, 9);
    }

    return result;
  }

  static String getLastFourCharacters(String inputString) {
    int length = inputString.length;

    if (length >= 4) {
      return inputString.substring(length - 4);
    } else {
      return inputString;
    }
  }

  static DateTime? calculateExpiryDate(String activationKey) {
    List<String> keyParts = activationKey.split('-');

    if (keyParts.length >= 4) {
      try {
        int days = int.parse(keyParts[3]);

        DateTime currentDate = DateTime.now();
        DateTime activationDate = currentDate.add(Duration(days: days));

        print(
            'Activation Date: ${DateFormat('yyyy-MM-dd').format(activationDate)}');

        return activationDate;
      } catch (e) {
        print('Error parsing activation key: $e');
      }
    }
    return null;
  }

 static bool hasExpiryDatePassed()  {
  final storedExpiryDate =  getExpiryDate();
  if (storedExpiryDate == null) {
    return true;
  }
  
  final currentDate = DateTime.now();
  return storedExpiryDate.isBefore(currentDate);
}

 static void storeExpiryDate(DateTime activationDate)  {
  final box =  Hive.box<String>(HiveBoxes.expiryDateBox);
  final activationDateString = activationDate.toIso8601String(); 
   box.put(HiveBoxes.expiryDateBoxKey, activationDateString);
}

static DateTime? getExpiryDate()  {
  final box =  Hive.box<String>(HiveBoxes.expiryDateBox);
  final activationDateString = box.get(HiveBoxes.expiryDateBoxKey);
  if (activationDateString != null) {
    return DateTime.parse(activationDateString); 
  } else {
    return null;
  }
}
}

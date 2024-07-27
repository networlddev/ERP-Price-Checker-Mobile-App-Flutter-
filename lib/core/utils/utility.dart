import 'dart:developer';

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

  // static String formatTextToSpeech(
  //   String value, {
  //   String? state,
  // }) {
  //   List<String> parts = value.split('.');

  //   var result = '';

  //   if (state == 'oman') {
  //     result = "${parts[0]} rial, and, ${parts[1]} baisas";
  //   } else {
  //     result = "${parts[0]} dirham, and, ${parts[1]} Fils";
  //   }

  //   return result;
  // }

  static String formatTextToSpeech(
    String value, {
    String? state,
  }) {
    List<String> parts = value.split('.');

    var result = '';
    var part1 = parts[1];

    if (state == '3') {
      if (part1.length == 1) {
        part1 = '${part1}00';
      }
      if (part1 == "000") {
        result = "${parts[0]} rial";
      } else {
        String replacedPart1 = part1.replaceAll("0", "zero");
        result = "${parts[0]} rial, and, $replacedPart1 baisa";
      }
    } else {
      if (part1.length == 1) {
        part1 = '${part1}0';
      }
        if (part1 == "00") {
        result = "${parts[0]} dirham";
      } else {
        String replacedPart1 = part1.replaceAll("0", "zero");
        result = "${parts[0]} dirham, and, $replacedPart1 Fils";
      }
    //  result = "${parts[0]} dirham, and, $part1 Fils";
    }

    return result;
  }

  static String formatPrice(
    String value, {
    String? state,
  }) {
    List<String> parts = value.split('.');

    var result = '';
    var part1 = parts[1];

    if (state == '3') {
      if (part1.length == 1) {
        part1 = '${part1}00';
      }
      result = "${parts[0]}.$part1";
    } else {
      if (part1.length == 1) {
        part1 = '${part1}0';
      }
      result = "${parts[0]}.$part1";
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

        log('Activation Date: ${DateFormat('yyyy-MM-dd').format(activationDate)}');

        return activationDate;
      } catch (e) {
        print('Error parsing activation key: $e');
      }
    }
    return null;
  }

  static bool hasExpiryDatePassed() {
    final storedExpiryDate = getExpiryDate();
    if (storedExpiryDate == null) {
      return true;
    }

    final currentDate = DateTime.now();
    return storedExpiryDate.isBefore(currentDate);
  }

  static void storeExpiryDate(DateTime activationDate) {
    final box = Hive.box<String>(HiveBoxes.expiryDateBox);
    final activationDateString = activationDate.toIso8601String();
    box.put(HiveBoxes.expiryDateBoxKey, activationDateString);
  }

  static DateTime? getExpiryDate() {
    final box = Hive.box<String>(HiveBoxes.expiryDateBox);
    final activationDateString = box.get(HiveBoxes.expiryDateBoxKey);
    if (activationDateString != null) {
      return DateTime.parse(activationDateString);
    } else {
      return null;
    }
  }

  static bool isImage(String url) {
    Uri uri = Uri.parse(url);
    String path = uri.path;
    List<String> parts = path.split('.');
    if (parts.length > 1) {
      return parts.last != "Mp4";
    } else {
      return false;
    }
  }
}

import 'package:reservation_apps/app/common/helper/common_strings.dart';

class CommonUtil {
  static bool falsyChecker(dynamic value) {
    bool isEmpty = false;
    bool isZero = false;
    bool isNull = value == null;
    if (value is int || value is double || value is num) {
      isZero = value == 0 || value == 0.0;
    } else {
      try {
        if (!isNull) isEmpty = value?.isEmpty;
      } catch (e) {
        isEmpty = false;
      }
    }
    return isNull || isEmpty || isZero;
  }

  static String toTitleCase(String text) {
    final sentences = text.split(' ');
    String result = CommonStrings.emptyString;
    if (sentences.isNotEmpty) {
      for (String word in sentences) {
        if (word.isNotEmpty) {
          final firstLetter = word[0].toUpperCase();
          final restOfLetters = word.substring(1, word.length);
          result += firstLetter + restOfLetters.toLowerCase();
          if (word != sentences.last) {
            result += CommonStrings.whiteSpace;
          }
        }
      }
    }
    return result;
  }
}

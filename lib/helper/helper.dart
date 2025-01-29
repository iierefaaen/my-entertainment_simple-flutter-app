import 'package:intl/intl.dart';

class Helper {
  static String truncateText(String text, int wordLimit) {
    final words = text.split(' ');
    if (words.length <= wordLimit) return text;
    return '${words.sublist(0, wordLimit).join(' ')}...';
  }

  static String formatCurrency(int currency) {
    String formattedCurrency =
        NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2)
            .format(currency)
            .toString();
    return formattedCurrency;
  }
  static String joinListToString(List<dynamic> genres, var index) {
    return genres.map((out) => out['$index'] ?? '').join(', ');
  }

  static String mapExtractor(var toBeMap, var mapIndex) {
    String output = toBeMap.map((out) => out['$mapIndex']).join(', ');
    return output;
  }

  static String listExtractor(List<dynamic> arrayTobeMapped) {
    String output = "";
    for (int i = 0; i < arrayTobeMapped.length; i++) {
      output += arrayTobeMapped[i].toString();
    }
    return output;
  }
}

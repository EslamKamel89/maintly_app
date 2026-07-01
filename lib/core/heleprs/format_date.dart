import 'package:maintly_app/core/heleprs/print_helper.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formateDateToArabic(DateTime dateTime) {
  initializeDateFormatting();
  Intl.defaultLocale = 'en';
  // Intl.initializeDateFormatting

  String formattedDate = DateFormat('EEEE d MMMM y', 'ar_SA').format(dateTime);
  return formattedDate;
}

String formatDateForApi(DateTime dateTime) {
  String formattedDate = DateFormat('dd-MM-yyyy', 'en').format(dateTime);
  pr(formattedDate);
  return formattedDate;
}

DateTime? parseDateTime(String? dateTimeStr) {
  try {
    if (dateTimeStr == null) return null;
    return DateTime.parse(dateTimeStr).toLocal();
  } catch (e) {
    return null;
  }
}

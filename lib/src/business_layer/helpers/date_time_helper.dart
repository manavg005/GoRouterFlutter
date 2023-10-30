import 'package:intl/intl.dart';

class DateTimeHelper {
  /// map of month number and month full name
  static Map<int, String> monthFullName = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };

  /// map of month number and month full name
  static Map<int, String> monthShortName = {
    1: "Jan",
    2: "Feb",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "Sept",
    10: "Oct",
    11: "Nov",
    12: "Dec",
  };

  /// map of week number and week short name
  static Map<int, String> weekShortName = {
    1: "Mon",
    2: "Tue",
    3: "Wed",
    4: "Thu",
    5: "Fri",
    6: "Sat",
    7: "Sun",
  };

  /// return month full name and year from date
  static (String, String) getMonthFullNameAndYear(DateTime date) {
    var month = date.month;
    var monthName = monthFullName[month] ?? "";

    return (monthName, date.year.toString());
  }

  /// get date in format Mon, 01 Jan 2021
  static String getDayMonthYear(DateTime date) {
    var month = date.month;
    var monthName = monthFullName[month] ?? "";

    return "${weekShortName[date.weekday]}, ${date.day} $monthName ${date.year}";
  }

  /// get date in format 12:00 PM Mon, 01 Jan 2021
  static String getDayMonthYearTime(DateTime date) {
    var month = date.month;
    var monthName = monthShortName[month] ?? "";
    var formattedTime = DateFormat.jm().format(date); // 12:34 PM format

    return "$formattedTime ${weekShortName[date.weekday]}, ${date.day} $monthName ${date.year}";
  }

  /// get date in format Mon, 01 Jan 2021
  static String getDayDateMonthYear(DateTime date) {
    var month = date.month;
    var monthName = monthShortName[month] ?? "";
    var formattedTime = DateFormat.jm().format(date); // 12:34 PM format

    return "${weekShortName[date.weekday]}, ${date.day} $monthName ${date.year}";
  }

  /// get date in format 01 January 2021
  static String getDayMonth(DateTime date) {
    var month = date.month;
    var monthName = monthFullName[month] ?? "";

    return "${date.day} $monthName ${date.year}";
  }

  /// get date in format 01 Jan 2021
  static String getDayShortMonth(DateTime date) {
    var month = date.month;
    var monthName = monthShortName[month] ?? "";

    return "$monthName ${date.day}, ${date.year}";
  }

  static String getMonthYearTime(DateTime date) {
    var month = date.month;
    var monthName = monthShortName[month] ?? "";
    var formattedTime = DateFormat('hh:mm a').format(date); // 12:34 PM format
    return "$formattedTime, ${date.day} $monthName ${date.year}";
  }
}

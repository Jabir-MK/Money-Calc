// conver datetime object to string

String convertDateTimeToString(DateTime dateTime) {
  // year in YYYY
  String year = dateTime.year.toString();
  // month in MM
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  // day in DD
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // final format > YYYY MM DD

  String convertedDate = year + month + day;

  return convertedDate;
}

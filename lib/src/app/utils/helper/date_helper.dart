class DateHelper {
  String formatDatetime(DateTime dateTime) {
    return '${dateTime.toLocal().day}/${dateTime.toLocal().month}/${dateTime.toLocal().year}';
  }

  DateTime datetimeFromString(String dateTime) {
    return DateTime.parse(dateTime);
  }

  String formatDateFromStringToDate(String dateTime) {
    var date =  DateTime.parse(dateTime);
    return formatDatetime(date);
  }
}

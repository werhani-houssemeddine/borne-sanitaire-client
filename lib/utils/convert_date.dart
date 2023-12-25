String formatDateTime(String date) {
  DateTime originalDateTime = DateTime.parse(date);

  String formattedDate = '${originalDateTime.day.toString().padLeft(2, '0')}-'
      '${originalDateTime.month.toString().padLeft(2, '0')}-'
      '${originalDateTime.year}';

  return formattedDate;
}

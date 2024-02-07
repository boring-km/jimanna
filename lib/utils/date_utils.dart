String getCurrentYearMonthOnly() {
  final now = DateTime.now();
  return now.year.toString() + now.month.toString().padLeft(2, '0');
}

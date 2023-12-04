import 'package:flutter/material.dart';

double getDefaultWidth(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  if (width > 740) width = 740;
  return width;
}

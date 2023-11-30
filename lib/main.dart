import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import './ui/ui.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

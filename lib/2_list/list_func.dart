import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../model/report.dart';
import '../utility/logger.dart';
import '../utility/key_controller.dart';

class ListTableState extends ChangeNotifier {
  int xUp = 0;

  listTableUpdate() {
    xUp += 1;
    notifyListeners();
  }
}

Future<List<Report>> fetchReports() async {
  Logger.events(func: 'fetchReports', event: '');

  final response = await http.get(ConstructorURI.listURI);
  String responseBody = utf8.decode(response.bodyBytes);

  final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
  allReports = parsed.map<Report>((json) => Report.fromJson(json)).toList();

  //print(allReports[0].osnovanieText);
  return allReports;
}

setOneReportID({String id}) {
  oneReport.id = id;
}

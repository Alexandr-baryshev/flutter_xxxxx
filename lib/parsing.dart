import 'dart:async';
import 'dart:convert';
import 'main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class Tessst extends ChangeNotifier {

  String nn = '';

  setN({String n}) {
    nn = n;
    fetchReports();
    print(nn);
    notifyListeners();

  }


  Future<List<Report>> fetchReports() async {
    final response = await http.get('http://localhost:8888/ppoGetF?serialNumber=$nn');
    String responseBody = utf8.decode(response.bodyBytes);
    //print('\n responseBody == $responseBody');

    return compute(parseReports, responseBody);
  }

  List<Report> parseReports(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();

    print('\n parsed == $parsed');

    return parsed.map<Report>((json) => Report.fromJson(json)).toList();
  }

}
class Report {
  final String id;
  final String serialNumber;
  final String reportNumber;
  final String osnovanieText;
  final String opisanieText;
  final String resultatText;

  Report(
      {this.id,
        this.serialNumber,
        this.reportNumber,
        this.osnovanieText,
        this.opisanieText,
        this.resultatText});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as String,
      serialNumber: json['serialNumber'] as String,
      reportNumber: json['reportNumber'] as String,
      osnovanieText: json['osnovanieTex'] as String,
      opisanieText: json['opisanieText'] as String,
      resultatText: json['resultatText'] as String,
    );
  }

}

void jsonPOST() async {
  //checkPasteKey();

  var jsonData = jsonEncode({
    'id': '5f4f4765ee92787e47ad5739',
    'serialNumber': 1,
    'reportNumber': 1,
     'osnovanieText' : 'основание',
    'opisanieText': 'описание',
    'resultatText': 'результат',
  });

  var response = await http.post(
    'http://localhost:8888/ppoGetById?id=',
    headers: {"Content-Type": "application/json"},
    body: jsonData,
  );


  var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
  print(responseDecode);

  // id = responseDecode['id']; для добавления записи


}


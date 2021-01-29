import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../model/report.dart';
import '../utility/logger.dart';
import '../model/key_controller.dart';
import '../z_prototype/buttons.dart';

class ListTableState extends ChangeNotifier {
  int xUp = 0;

  listTableUpdate() {
    xUp += 1;
    notifyListeners();
  }
}

class ListPgNetwork {

  static Future<List<Report>> fetchReports({String call}) async {
    final response = await http.get(ConstructorURI.listURI);
    String responseBody = utf8.decode(response.bodyBytes);

    final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
    allReports = parsed.map<Report>((json) => Report.fromJson(json)).toList();

    Logger.events(
        widget: call, func: 'fetchReports', event: 'length ${allReports.length}');
    //print(allReports[0].osnovanieText);
    await Future.delayed(Duration(seconds: 1));
    return allReports;

  }
}

class ListPgButtons {

  static List<FlatButton> buttonsList(BuildContext context) {
    newReport() {
      print('Новый');
      ReportKEY.deleteReportID();
      Navigator.pushNamed(context, PageRout.VOID);
    }

    updatePg() {
      print('Обновить');
      context.read<ListTableState>().listTableUpdate();
    }

    return [
      bottomBarButton(text: 'Новый', icon: Icons.add_box_outlined, fun: newReport),
      bottomBarButton(text: 'Обновить', icon: Icons.update_outlined, fun: updatePg),
    ];
  }
}
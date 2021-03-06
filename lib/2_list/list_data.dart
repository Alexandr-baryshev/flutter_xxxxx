import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../model/report.dart';
import '../utility/logger.dart';
import '../model/key_controller.dart';
import '../widgets/buttons.dart';

class ListPgState extends ChangeNotifier {
  bool listTableState = false;

  listTableUpdate() {
    listTableState = !listTableState;
    notifyListeners();
  }
}

class ListPgNetwork {

  static Future<List<Report>> fetchReports({String call}) async {
    Uri uri = Uri.parse(ConstructorURI.listURI);
    final response = await http.get(uri);
    String responseBody = utf8.decode(response.bodyBytes);

    final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
    allReports = parsed.map<Report>((json) => Report.fromJson(json)).toList();

    Logger.events(
        class_: call, func: 'fetchReports', data: 'length ${allReports.length}');
    //print(allReports[0].osnovanieText);
    await Future.delayed(Duration(milliseconds: 500));
    return allReports;

  }
}

class ListPgButtons {

  static List<Widget> buttonsList(BuildContext context) {
    newReport() {
      print('Новый');
      oneReport.clear();
      ReportKEY.deleteReportID();
      Navigator.pushNamed(context,  PageRout.INPUT);
    }

    updatePg() {
      print('Обновить');
      context.read<ListPgState>().listTableUpdate();
    }





    switch (ReportKEY.reportKEY) {


      case ReportKEY.ACTIVE_Z_KEY:
        return [
          bottomBarButton(text: 'Обновить', icon: Icons.update_outlined, fun: updatePg),
        ];
        break;

      default:
        return [
          bottomBarButton(text: 'Новый', icon: Icons.add_box_outlined, fun: newReport),
          bottomBarButton(text: 'Обновить', icon: Icons.update_outlined, fun: updatePg),
        ];
        break;
    }

  }
}

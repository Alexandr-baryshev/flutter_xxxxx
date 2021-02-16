import 'package:flutter/material.dart';
import '../model/key_controller.dart';
import '../utility/style.dart';
import '../utility/logger.dart';
import 'list_data.dart';
import 'list_table.dart';
import 'date_filter.dart';
import '../location_dic/location_dic_layout.dart';

import '../widgets/bars.dart';

class ListPgLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Logger.events(class_: '${context.widget}', func: 'build', data: '');

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => null,
        child: Scaffold(
          backgroundColor: mainBgColor,
          body: FutureBuilder(
              future: ReportKEY.getReportKEY(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      TopBar(ReportKEY.reportNAME, PageRout.HOME, ReportKEY.userFIO),
                      DateFilter(),
                      LocationDicLayout(type: 'filter'),
                      ListTable(),
                      BottomBar(ListPgButtons.buttonsList(context)),
                    ],
                  );
                } else {
                  return Center(child: Text('Нет данных'));
                }
              }),
        ),
      ),
    );
  }
}



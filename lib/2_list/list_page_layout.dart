import 'package:flutter/material.dart';
import '../utility/style.dart';
import '../utility/key_controller.dart';
import '../utility/logger.dart';
import 'list_table.dart';
import 'date_filter.dart';

import '../z_prototype/top_bar.dart';

class ListPgLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Logger.events(widget: '${context.widget}', func: 'build', event: '');

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
                      //VoidLocalCLASS(),
                      TopBar(ReportKEY.reportNAME, PageRout.HOME),
                       DateFilter(),
                      // LocationDicLayout(type: 'filter'),
                       ListTable(),
                      // ListBottom(),
                    ],
                  );
                } else {
                  return Center(child: Text('Нет данных'));
                }
              }
              ),
        ),
      ),
    );
  }
}











class VoidLocalCLASS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.green,
    );
  }
}

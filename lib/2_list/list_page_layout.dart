import 'package:flutter/material.dart';
import 'package:reports_flutter/utility/style.dart';
import 'package:reports_flutter/utility/constant.dart';

import 'package:reports_flutter/z_prototype/top_bar.dart';







class ListPaLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //logger.events(widget: '${context.widget}', func: 'Widget build');

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => null,
        child: Scaffold(
          backgroundColor: mainBgColor,
          body: Column(
            children: [
              //VoidLocalCLASS(),
              TopBar(ReportKEY.reportNAME, PageRout.HOME),
              // DateFilter(),
              // LocationDicLayout(type: 'filter'),
              // ListTable(),
              // ListBottom(),
            ],
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


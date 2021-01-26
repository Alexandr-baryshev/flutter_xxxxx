import 'package:flutter/material.dart';
import 'package:reports_flutter/utility/constant.dart';
import 'package:reports_flutter/utility/style.dart';




class QQQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 100,
      width: 100,
    );
  }
}




class HomePgLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String funcName = 'Widget build';
    //logger.events(widget: '${context.widget}', func: funcName, event: '');

    return Scaffold(
      backgroundColor: mainBgColor,
      body: Column(
        children: [
          Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                ' NEXT ',
                style: TextStyle(
                  color: barBgColor,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Expanded(
            child: ListView(

              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              children: [
                buildCard(context, ReportKEY.PPO_NAME, ReportKEY.setReportKEY(rKEY: ReportKEY.PPO_KEY)),
                buildCard(context, ReportKEY.PROFRAB_NAME, ReportKEY.setReportKEY(rKEY: ReportKEY.PROFRAB_KEY)),
                buildCard(context, ReportKEY.INCIDENT_NAME, ReportKEY.setReportKEY(rKEY: ReportKEY.INCIDENT_KEY)),
                buildCard(context, ReportKEY.TEH112_NAME, ReportKEY.setReportKEY(rKEY: ReportKEY.TEH112_KEY)),
                buildCard(context, ReportKEY.ACTIVE_Z_NAME, ReportKEY.setReportKEY(rKEY: ReportKEY.ACTIVE_Z_KEY)),


             ],
            ),
          )
        ],
      ),
    );
  }

  Card buildCard(BuildContext context, String name, Function setCollect) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(name),
        onTap: () {
          setCollect();
        },
      ),
    );
  }
}

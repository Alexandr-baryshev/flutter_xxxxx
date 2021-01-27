import 'package:flutter/material.dart';
import '../utility/constant.dart';
import '../utility/style.dart';
import '../utility/logger.dart';







class HomePgLayout extends StatelessWidget {



  xxx(){
    ReportKEY.setReportKEY(rKEY: ReportKEY.PPO_KEY);
  }

  @override
  Widget build(BuildContext context) {

    Logger.events(widget: '${context.widget}', func: 'build', event: '');



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
                //buildCard(context, ReportKEY.PPO_NAME, xxx),
                 buildCard(context, ReportKEY.PROFRAB_NAME, ReportKEY.setReportKEY(rKEY: ReportKEY.PROFRAB_KEY)),
                // buildCard(context, ReportKEY.INCIDENT_NAME, ReportKEY.setReportKEY(rKEY: ReportKEY.INCIDENT_KEY)),
                // buildCard(context, ReportKEY.TEH112_NAME, ReportKEY.setReportKEY(rKEY: ReportKEY.TEH112_KEY)),
                // buildCard(context, ReportKEY.ACTIVE_Z_NAME, ReportKEY.setReportKEY(rKEY: ReportKEY.ACTIVE_Z_KEY)),


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
          Navigator.pushNamed(context, PageRout.LIST);

        },
      ),
    );
  }
}

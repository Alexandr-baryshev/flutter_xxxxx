import 'package:flutter/material.dart';
import '../utility/constant.dart';
import '../utility/style.dart';
import '../utility/logger.dart';

class HomePgLayout extends StatelessWidget {

  _ppo() {
    ReportKEY.setReportKEY(rKEY: ReportKEY.PPO_KEY);
  }

  _profrab() {
    ReportKEY.setReportKEY(rKEY: ReportKEY.PROFRAB_KEY);
  }

  _incident() {
    ReportKEY.setReportKEY(rKEY: ReportKEY.INCIDENT_KEY);
  }

  _teh112() {
    ReportKEY.setReportKEY(rKEY: ReportKEY.TEH112_KEY);
  }

  _active() {
    ReportKEY.setReportKEY(rKEY: ReportKEY.ACTIVE_Z_KEY);
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
                buildCard(context, ReportKEY.PPO_NAME, _ppo),
                buildCard(context, ReportKEY.PROFRAB_NAME, _profrab),
                buildCard(context, ReportKEY.INCIDENT_NAME, _incident),
                buildCard(context, ReportKEY.TEH112_NAME, _teh112),
                buildCard(context, ReportKEY.ACTIVE_Z_NAME, _active),
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

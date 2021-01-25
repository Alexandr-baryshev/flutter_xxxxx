import 'package:flutter/material.dart';
import 'package:reports_flutter/utility/constant.dart';
import 'package:reports_flutter/utility/style.dart';

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
                buildCard(context, PPO_NAME, setPpo),
                buildCard(context, PROFRAB_NAME, setProfRab),
                buildCard(context, INCIDENT_NAME, setIncident),
                buildCard(context, TEH112_NAME, setTeh112),
                buildCard(context, ACTIVE_Z_NAME, setActivZadachi),
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

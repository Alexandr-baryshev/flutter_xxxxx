import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/report.dart';
import 'input_data.dart';
import '../utility/style.dart';
import '../utility/logger.dart';
import '../utility/time_convert.dart';

Container infoLine() {
  return Container(
    //color: Colors.redAccent,
    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            alignment: Alignment.centerLeft,
            width: 60,
            height: 50,
            child: Text(
              '№ ${oneReport.serialNumber == null ? '' : oneReport.serialNumber}',
              style: TextStyle(
                  color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.w500),
            )),
        // # id
        Container(
            alignment: Alignment.centerRight,
            width: 200,
            height: 50,
            child: Text(
              '${time(oneReport.completedDate, 'd.M.yyyy  H:mm')}',
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.w500),
            )),
        // # date
      ],
    ),
  );
}










class InputFieldsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          infoLine(),
          // TODO добавить if else или visible на "reportKEY", для основной выкладки
          Expanded(
            flex: 5,
            child: Container(
              decoration: widgetContainerDecor(),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
             child: ListView(
              children: InputFieldVisibly.fieldListONE(context),
            ),
        ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: widgetContainerDecor(),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: ListView(
                children: InputFieldVisibly.fieldListTWO(context),
              ),
            ),
          ),


        ],
      ),
    );
  }
}

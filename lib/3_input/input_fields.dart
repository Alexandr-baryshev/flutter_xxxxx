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






Container inputField(Function setText, String ctr, String name, double top) {
  return Container(
    padding: EdgeInsets.fromLTRB(10, top, 10, 10),
    child: TextField(
      controller: TextEditingController(text: ctr),
      decoration: bigInputDecoration(name, 20),
      onChanged: (val) {
        setText(val);
      },
      minLines: 5,
      maxLines: 8,
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
          Expanded(
            child: Container(
              decoration: widgetContainerDecor(),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ListView(
              children: [
                inputField(
                    InputPgData.xxxSET(), 'oneReport.opisanieZadachi', 'Описание задачи', 10),
                inputField(
                    InputPgData.xxxSET(), oneReport.opisanieZadachi, 'Описание задачи2', 10),

              ],
            ),
        ),
          ),],
      ),
    );
  }
}

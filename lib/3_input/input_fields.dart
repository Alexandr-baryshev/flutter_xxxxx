import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';


import '../model/report.dart';
import 'input_data.dart';
import '../utility/style.dart';
import '../utility/logger.dart';
import '../utility/time_convert.dart';

Container infoLine(BuildContext context) {
  bool infoLineSate = context.select((InputState st) => st.infoLineSate);
  return Container(
    //color: Colors.redAccent,
    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Container(
              alignment: Alignment.centerLeft,
              height: 50,
              child: Text(
                '№ ${oneReport.serialNumber == null ? '' : oneReport.serialNumber}',
                style: infoLineStyle()
              )),
        ),
        Flexible(
          flex: 3,
          child: Container( 
              alignment: Alignment.center,

              height: 50,
              child: Text('${oneReport.whoCreated}',
                style: infoLineStyle()
              )),
        ),
        // # id
        Flexible(
          flex: 2,
          child: Container(
              alignment: Alignment.centerRight,
              height: 50,
              child: Text(
                '${time(oneReport.completedDate, 'd.M.yyyy  H:mm')}',
                textAlign: TextAlign.right,
                style: infoLineStyle()
              )),
        ),
        // # date
      ],
    ),
  );
}










class InputFieldsBody extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    bool inputFieldState = context.select((InputState st) => st.inputFieldState);
    InputFieldSelector.setFieldVisible();
    return FutureBuilder(
        future: InputPgData.fetchReportByID(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Expanded(
              child: Column(
                children: [
                  infoLine(context),

                  Visibility(
                    visible: InputFieldSelector.set1Visible,
                    child: Flexible(
                      flex: 4,
                      child: Container(
                        decoration: widgetContainerDecor(),
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Scrollbar(
                          child: ListView(
                            shrinkWrap: true,
                            children: InputFieldSelector.fieldsSET1(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: InputFieldSelector.set2Visible,
                    child: Flexible(
                      flex: 2,
                      child: Container(
                        decoration: widgetContainerDecor(),
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ListView(
                          shrinkWrap: true,
                          children: InputFieldSelector.fieldsSET2(context),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: InputFieldSelector.set3Visible,
                    child: Flexible(
                      flex: 4,
                      child: Container(
                        decoration: widgetContainerDecor(),
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: InputFieldSelector.fieldsSET3(context),

                      ),
                    ),
                  ),


                ],
              ),
            );
          } else {
          return Center(child: Text('Нет данных'));
          }
        });
  }
}

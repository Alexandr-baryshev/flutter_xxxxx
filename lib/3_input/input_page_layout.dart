import 'package:flutter/material.dart';
import '../model/key_controller.dart';
import '../utility/style.dart';
import '../utility/logger.dart';
import 'input_data.dart';
import 'input_fields.dart';

import '../location_dic/location_dic_layout.dart';
import '../z_prototype/bars.dart';

class InputPgLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Logger.events(widget: '${context.widget}', func: 'build', event: '');

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => null,
        child: Scaffold(
          backgroundColor: mainBgColor,
          body: FutureBuilder(
              future: ReportKEY.getReportID(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      TopBar(ReportKEY.reportNAME, PageRout.LIST),
                      LocationDicLayout(type: 'input'),
                      InputFieldsBody(),
                     //BottomBar(InputPgButtons.buttonsList(context)),
                    ],
                  );
                } else {
                  return Center(child: Text('Нет данных'));
                }
              }),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: BottomBar(InputButtonSelector.buttonsList(context)),

          ),
        ),
      ),
    );
  }
}

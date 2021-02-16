import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utility/utility_export.dart';
import '../info_dic/tip-zadachi_dic.dart';

import '../model/key_controller.dart';
import '../model/report.dart';
import '../widgets/buttons.dart';

class InputState with ChangeNotifier {
  bool infoLineSate = false;
  bool inputFieldState = false;

  infoLineUpdate() {
    infoLineSate = !infoLineSate;
    notifyListeners();
  }

  inputFieldUpdate() {
    inputFieldState = !inputFieldState;
    notifyListeners();
  }
}



class InputButtonSelector {
  static List<FlatButton> buttonsList(BuildContext context) {
    saveReport() async {

      await InputPgData.saveReportData(context);
      context.read<InputState>().infoLineUpdate();
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) => SavePopup(InputPgData.saveMessage)));
      print('Отчет сохранен');

    }

    saveToActive() async {
      await InputPgData.saveToActive(context);
      context.read<InputState>().infoLineUpdate();


    }

    closeActive() async {
      await InputPgData.saveToComplete(context);
      context.read<InputState>().infoLineUpdate();
      context.read<InputState>().inputFieldUpdate();

    }

    switch (ReportKEY.reportKEY) {
      case ReportKEY.TEH112_KEY:
        return [
          bottomBarButton(text: 'Сохранить', icon: Icons.save, fun: saveReport),
          bottomBarButton(text: 'В активные', icon: Icons.add_link, fun: saveToActive),
        ];
        break;

      case ReportKEY.ACTIVE_Z_KEY:
        return [
          bottomBarButton(text: 'Сохранить', icon: Icons.save, fun: saveReport),
          bottomBarButton(
              text: 'Завершить', icon: Icons.where_to_vote_rounded, fun: closeActive),
        ];
        break;

      default:
        return [
          bottomBarButton(text: 'Сохранить', icon: Icons.save, fun: saveReport),
        ];
        break;
    }
  }
}



class InputFieldSelector {




  static bool set1Visible = false;
  static bool set2Visible = false;
  static bool set3Visible = false;

  static setFieldVisible() {
    if (ReportKEY.reportKEY == ReportKEY.PPO_KEY ||
        ReportKEY.reportKEY == ReportKEY.PROFRAB_KEY ||
        ReportKEY.reportKEY == ReportKEY.INCIDENT_KEY) {
      set1Visible = true;
      set2Visible = false;
      set3Visible = false;
    } else if (ReportKEY.reportKEY == ReportKEY.TEH112_KEY) {
      set1Visible = true;
      set2Visible = true;
      set3Visible = false;
    } else if (ReportKEY.reportKEY == ReportKEY.ACTIVE_Z_KEY) {
      set1Visible = false;
      set2Visible = true;
      set3Visible = true;
    }
  }

  static Container inputField(Function setText, String ctrl, String name, double top) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, top, 10, 10),
      child: Scrollbar(
        child: TextField(
          controller: TextEditingController(text: ctrl),
          decoration: bigInputDecoration(name, 20),
          onChanged: (val) {
            setText(val);
          },
          minLines: 4,
          maxLines: 6,
        ),
      ),
    );
  }

  static Container outputField(String ctrl, String name, double top) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, top, 10, 10),
      child: Scrollbar(
        child: TextField(
          enabled: false,
          controller: TextEditingController(text: ctrl),
          decoration: outputDecoration(name, 20),
          onChanged: (val) {},
          minLines: 2,
          maxLines: null,
        ),
      ),
    );
  }

  static Container activeSign(BuildContext context) {
    Logger.events(class_: '${context.widget}', func: 'Widget build', data: '');
    bool infoLineSate = context.select((InputState st) => st.infoLineSate);

    String active = '';
    Color colour;

    switch (oneReport.activeSign) {
      case 0:
        active = 'Не активная';
        colour = Colors.blueGrey;
        break;
      case 1:
        active = 'Активная';
        colour = Colors.redAccent;
        break;
      case 2:
        active = 'Завершенная';
        colour = Colors.green;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          child: Text(
        active,
        style: TextStyle(color: colour, fontWeight: FontWeight.w600),
      )),
    );
  }

  static Container activeZ(
      BuildContext context, Function setText, String ctr, String name, double top) {
    return Container(
      decoration: widgetContainerDecor(),
      //margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TipZadachiDic(),
            activeSign(context),
          ],
        ),

        inputField(setText, ctr, name, top),
        //inputField(InputPgData.xxxSET(), 'ACTIVE_Z', 'Описание типа задачи', 10),
      ]),
    );
  }



  static List<Container> fieldsSET1(BuildContext context) {
    switch (ReportKEY.reportKEY) {
      case ReportKEY.TEH112_KEY:

        return [
          inputField(InputPgData.setOpisanieZadachi, oneReport.opisanieZadachi,
              'Описание задачи', 10),
          inputField(InputPgData.setOpisanieRabot, oneReport.opisanieRabot,
              'Описание работ', 10),
          inputField(InputPgData.setResultatRabot, oneReport.resultat, 'Результат', 10),
        ];
        break;

      case ReportKEY.PPO_KEY:

        return [
          inputField(InputPgData.setOsnovanieRabot, oneReport.osnovanieRabot,
              'Основание работ', 10),
          inputField(InputPgData.setOpisanieRabot, oneReport.opisanieRabot,
              'Описание работ', 10),
          inputField(InputPgData.setResultatRabot, oneReport.resultat, 'Результат', 10),
        ];
        break;

      default:

        return [
          inputField(InputPgData.setOpisanieRabot, oneReport.opisanieRabot,'Описание работ', 10),
          inputField(InputPgData.setResultatRabot, oneReport.resultat, 'Результат', 10),
        ];
        break;
    }
  }










  static List<Container> fieldsSET2(BuildContext context) {

        return [
          activeZ(context, InputPgData.setOpisanieTipa, oneReport.activeDescription,
              'Описание типа задачи', 10),
        ];


  }





// TODO  >> TUT <<<<
  static Container fieldsSET3(BuildContext context) {

        return  Container(
          child: Scrollbar(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: activeCompleteList.length,
                itemBuilder: (context, index) {
                  return outputField(
                  '${activeCompleteList[index].activeDescription}',
                  '${activeCompleteList[index].activeTypeID} | '
                  'Завершил ${activeCompleteList[index].whoCompleted} '
                  'в ${time(activeCompleteList[index].completedDate, 'd.M.yyyy  H:mm')}',
                  10);
            }
            ),
          ),
        );

    }

}



class SavePopup extends StatelessWidget {
  final String _text;

  SavePopup(this._text);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_text),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('ок'),
        ),
      ],
    );
  }
}




class InputPgData {

  static String saveMessage = '';
  static String _activeMessage = '';

  static setOsnovanieRabot(String input) {
    oneReport.osnovanieRabot = input;
  }

  static setOpisanieRabot(String input) {
    oneReport.opisanieRabot = input;
  }

  static setResultatRabot(String input) {
    oneReport.resultat = input;
  }

  static setOpisanieZadachi(String input) {
    oneReport.opisanieZadachi = input;
  }

  static setOpisanieTipa(String input) {
    oneReport.activeDescription = input;
  }

  static Future<Report> fetchReportByID({String call}) async {

    await fetchActive();


    final response = await http.get(ConstructorURI.byIdURI);
    oneReport = Report.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    await Future.delayed(Duration(milliseconds: 500));

    return oneReport;
  }



  static _getLastNumber() async {

    if (oneReport.serialNumber == null) {

      var response = await http.get(ConstructorURI.getAllURI);
      List<dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));

      /// СУТЬ:
      // берется "parse.length - 1" и устанавливается индексом
      // в сам массив "parse[...]['serialNumber']"
      // далее "int.parse(...) + 1" и все это .toString()
      if (parse.length == 0) {
        oneReport.serialNumber = '1';
      } else {
        int lastIndex = parse.length - 1;
        oneReport.serialNumber =
            (int.parse(parse[lastIndex]['serialNumber']) + 1).toString();
      }

      oneReport.completedDate = DateTime.now().millisecondsSinceEpoch;
      oneReport.whoCreated = ReportKEY.userFIO;



    }




    Logger.events(
        func: '###WWWWWWWWWWWWWWWWW getLastNumber()', data: '${oneReport.serialNumber}');



  }




  static saveReportData(BuildContext context) async {
    await _getLastNumber();

    var jsonObject = jsonEncode({
      'id': oneReport.id,
      'serialNumber': oneReport.serialNumber,
      'osnovanieRabot': oneReport.osnovanieRabot,
      'opisanieRabot': oneReport.opisanieRabot,
      'opisanieZadachi': oneReport.opisanieZadachi,
      'resultat': oneReport.resultat,

      'activeTypeID': oneReport.activeTypeID,
      'activeDescription': oneReport.activeDescription,

      'whoCreated': oneReport.whoCreated,
      'activeSign': oneReport.activeSign,
      'subyektID': oneReport.subyektID,
      'rayonID': oneReport.rayonID,
      'sluzhbaID': oneReport.sluzhbaID,
      'completedDate': oneReport.completedDate,
    });

    var response = await http.post(
      ConstructorURI.saveURI,
      headers: {"Content-Type": "application/json"},
      body: jsonObject,
    );



    response.statusCode == 200
        ? saveMessage = 'Отчет сохранен$_activeMessage'
        : saveMessage = 'ОШИБКА ${response.statusCode}' ;

    oneReport = Report.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));



    Logger.events(
        class_: '${context.widget}',
        func: 'saveData',
        data: 'oneReport.id ${oneReport.id}');
  }




  static _saveActiveData(BuildContext context) async {


    var jsonObject = jsonEncode({
      'id': activeComplete.id,
      'teh112id': activeComplete.teh112id,
      'activeTypeID': activeComplete.activeTypeID,
      'activeDescription': activeComplete.activeDescription,
      'whoCompleted': activeComplete.whoCompleted,
      'completedDate': DateTime.now().millisecondsSinceEpoch,

    });

    var response = await http.post(
      ConstructorURI.saveActiveURI,
      headers: {"Content-Type": "application/json"},
      body: jsonObject,
    );



    response.statusCode == 200
        ? saveMessage = 'Отчет сохранен$_activeMessage'
        : saveMessage = 'ОШИБКА ${response.statusCode}' ;

    activeComplete = ActiveComplete.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));



    Logger.events(
        class_: '${context.widget}',
        func: 'saveData',
        data: 'activeComplete.id ${activeComplete.id}');
  }




  static saveToActive(BuildContext context) async {
    _activeMessage = '';
    if (oneReport.activeSign == 0) {
      oneReport.activeSign = 1;
      _activeMessage = ',\nзадача отправлена в активные';
      await saveReportData(context);
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) => SavePopup(InputPgData.saveMessage)));
    }


  }




  static saveToComplete(BuildContext context) async {
    _activeMessage = '';
    if (oneReport.activeSign == 1) {

      // Данное присвоение можно было не писать, но это что бы не запутапться
      activeComplete.teh112id = oneReport.id;
      activeComplete.activeTypeID = oneReport.activeTypeID;
      activeComplete.activeDescription = oneReport.activeDescription;
      activeComplete.whoCompleted = ReportKEY.userFIO;

      await _saveActiveData(context);
      oneReport.activeSign = 0;
      oneReport.activeTypeID = null;
      oneReport.activeDescription = null;
      activeComplete.id = null;


      _activeMessage = ',\nзадача завершена';
      await saveReportData(context);
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) => SavePopup(InputPgData.saveMessage)));
    }


  }



// добавить ID
  static Future<List<ActiveComplete>> fetchActive({String call}) async {
    final response = await http.get(ConstructorURI.activeByIdURI);
    String responseBody = utf8.decode(response.bodyBytes);

    final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
    activeCompleteList = parsed.map<ActiveComplete>((json) => ActiveComplete.fromJson(json)).toList();

    Logger.events(
        class_: call, func: '******fetchActive', data: 'length ${activeCompleteList.length}');
    //print(allReports[0].osnovanieText);
    //await Future.delayed(Duration(milliseconds: 500));
    return activeCompleteList;

  }



}

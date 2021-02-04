import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../info_dic/tip-zadachi_dic.dart';

import '../model/key_controller.dart';
import '../model/report.dart';
import '../utility/style.dart';
import '../utility/logger.dart';
import '../z_prototype/buttons.dart';

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

/*







*/

class InputButtonSelector {
  static List<FlatButton> buttonsList(BuildContext context) {
    saveReport() {
      context.read<InputState>().inputFieldUpdate();
      print('Отчет сохранен');
    }

    saveToActive() {
      print('Отчет сохранен, задача отпралена в активные');
    }

    closeActive() {
      print('Активная задача завершена');
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

/*







*/

class InputFieldSelector {
  static bool tehActiveVisible = false;

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
    Logger.events(widget: '${context.widget}', func: 'Widget build', event: '');
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

  static List<Container> fieldsPrimary(BuildContext context) {
    switch (ReportKEY.reportKEY) {
      case ReportKEY.TEH112_KEY:
        tehActiveVisible = true;
        return [
          inputField(InputPgData.setOpisanieZadachi, oneReport.opisanieZadachi, 'Описание задачи', 10),
          inputField(InputPgData.setOpisanieRabot, oneReport.opisanieRabot, 'Описание работ', 10),
          inputField(InputPgData.setResultatRabot, oneReport.resultat, 'Результат', 10),
        ];
        break;

      case ReportKEY.PPO_KEY:
        tehActiveVisible = false;
        return [
          inputField(InputPgData.setOsnovanieRabot, oneReport.osnovanieRabot, 'Основание работ', 10),
          inputField(InputPgData.setOpisanieRabot, oneReport.opisanieRabot, 'Описание работ', 10),
          inputField(InputPgData.setResultatRabot, oneReport.resultat, 'Результат', 10),
        ];
        break;

      case ReportKEY.ACTIVE_Z_KEY:
        tehActiveVisible = true;
        return [
          outputField('текст поля', 'Неисправность ОС, завершено 4.2.2021 12:00', 10),
          outputField('текст поля', 'Неисправность ОС, завершено 4.2.2021 12:00', 10),
          outputField('текст поля', 'Неисправность ОС, завершено 4.2.2021 12:00', 10),
          outputField('текст поля', 'Неисправность ОС, завершено 4.2.2021 12:00', 10),
        ];
        break;

      default:
        tehActiveVisible = false;
        return [
          inputField(InputPgData.setOpisanieRabot, oneReport.opisanieRabot, 'Описание работ', 10),
          inputField(InputPgData.setResultatRabot, oneReport.resultat, 'Результат', 10),
        ];
        break;
    }
  }

  static List<Container> fieldsSecondary(BuildContext context) {
    switch (ReportKEY.reportKEY) {
      case ReportKEY.ACTIVE_Z_KEY:
        return [
          activeZ(context, InputPgData.setOpisanieTipa, oneReport.opisanieTipa,
              'Описание типа задачи', 10),
        ];
        break;

      case ReportKEY.TEH112_KEY:
        return [
          activeZ(context, InputPgData.setOpisanieTipa, oneReport.opisanieTipa,
              'Описание типа задачи', 10),
        ];
        break;

      default:
        return [
          Container(),
        ];
        break;
    }
  }
}




class InputPgData {


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
    oneReport.opisanieTipa = input;
  }

  static Future<Report> fetchReportByID({String call}) async {



    final response = await http.get(ConstructorURI.byIdURI);
    oneReport = Report.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    await Future.delayed(Duration(milliseconds: 500));

    return oneReport;
  }



  static _getLastNumber() async {

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

    Logger.events(func: '###WWWWWWWWWWWWWWWWW getLastNumber()', event: '${oneReport.serialNumber}');
  }


}

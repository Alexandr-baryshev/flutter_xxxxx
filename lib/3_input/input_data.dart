import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/key_controller.dart';
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

class InputPgButtons {
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
          bottomBarButton(text: 'Завершить', icon: Icons.where_to_vote_rounded, fun: closeActive),
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

class InputFieldVisibly {

  static bool teh112 = false;

  static Container inputField(Function setText, String ctr, String name, double top) {
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

// TODO: продолжить тут

  static List<Container> fieldListONE(BuildContext context) {
    switch (ReportKEY.reportKEY) {
      case ReportKEY.TEH112_KEY:
        teh112 = true;
        return [
          inputField(InputPgData.xxxSET(), 'TEH112', 'Описание задачи', 10),
          inputField(InputPgData.xxxSET(), 'TEH112', 'Описание работ', 10),
          inputField(InputPgData.xxxSET(), 'TEH112', 'Результат', 10),
        ];
        break;

      case ReportKEY.PPO_KEY:
        return [
          inputField(InputPgData.xxxSET(), 'PPO', 'Основание работ', 10),
          inputField(InputPgData.xxxSET(), 'PPO', 'Описание работ', 10),
          inputField(InputPgData.xxxSET(), 'PPO', 'Результат', 10),
        ];
        break;

      default:
        return [
          inputField(InputPgData.xxxSET(), 'DEFFF', 'Описание работ', 10),
          inputField(InputPgData.xxxSET(), 'DEFFF', 'Результат', 10),
        ];
        break;
    }
  }

  static List<Container> fieldListTWO(BuildContext context) {
    switch (ReportKEY.reportKEY) {
      case ReportKEY.ACTIVE_Z_KEY:
        return [
          inputField(InputPgData.xxxSET(), 'ACTIVE_Z', 'Описание типа задачи', 10),
          inputField(InputPgData.xxxSET(), 'ACTIVE_Z', 'придумать список', 10),
        ];
        break;

      case ReportKEY.TEH112_KEY:
        return [
          inputField(InputPgData.xxxSET(), 'TEH112', 'Описание типа задачи', 10),
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
  static xxxSET() {
    print('============= InputPgData xxx SET');
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/key_controller.dart';
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
// TODO: продолжить тут
}





class InputPgData  {

  static xxxSET() {
    print('============= InputPgData xxx SET');
  }
}
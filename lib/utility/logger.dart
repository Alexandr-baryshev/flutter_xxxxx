import 'package:intl/intl.dart';

class Logger {

  static bool loggerOnOff = true;

  static String _widget;
  static String _func;

  static String _temp;

  static String timePrint() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('H:mm:ss');
    return formatter.format(now);
  }

  static events({String widget, String func, String event}) {

    if (loggerOnOff == true) {

      if (widget != null) _widget = widget;
      if (func != null) _func = func;
      if (event == null) event = '';

      if (_temp == null) _temp = _widget;
      if (_temp != _widget) print('');
      _temp = _widget;


      print('logger || c: $_widget | f: $_func | e: $event');
    }
  }




  static stop({String cClass, String cFunc, String event}) {

    if (cClass != null) _widget = cClass;
    if (cFunc != null) _func = cFunc;
    if (event == null) event = '##### STOP';


    print('${timePrint()} | c: $_widget | f: $_func | e: $event');
  }


}


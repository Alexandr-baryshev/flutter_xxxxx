import 'package:intl/intl.dart';

class Logger {

  static bool loggerOnOff = true;

  static String _class;
  static String _func;

  static String _temp;

  static String timePrint() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('H:mm:ss');
    return formatter.format(now);
  }

  static events({String class_, String func, String data}) {

    if (loggerOnOff == true) {

      if (class_ != null) _class = class_;
      if (func != null) _func = func;
      if (data == null) data = '';

      if (_temp == null) _temp = _class;
      if (_temp != _class) print('');
      _temp = _class;


      print('logger || c: $_class | f: $_func | d: $data');
    }
  }




  static stop({String class_, String func, String data}) {

    if (class_ != null) _class = class_;
    if (func != null) _func = func;
    if (data == null) data = '##### STOP';


    print('${timePrint()} | c: $_class | f: $_func | d: $data');
  }


}


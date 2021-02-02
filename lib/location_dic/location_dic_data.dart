import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utility/logger.dart';
import '../model/key_controller.dart';
import '../model/report.dart';
import 'location_dic_model.dart';

import '../2_list/list_data.dart';

/*
class SubyektState with ChangeNotifier {
  int xUp = 0;

  subyektUpdate() {
    xUp = null;
    notifyListeners();
  }
}

class RayonState with ChangeNotifier {
  bool xUp = false;


  rayonUpdate() {
    xUp = !xUp;
    notifyListeners();
  }
}

class SluzhbaState with ChangeNotifier {
  int xUp = 0;

  sluzhbaUpdate() {
    xUp = null;
    notifyListeners();
  }
}
 */

class LocationState with ChangeNotifier {
  bool subyektState = false;
  bool rayonState = false;
  bool sluzhbaState = false;

  subyektUpdate() {
    subyektState = !subyektState;
    notifyListeners();
  }

  rayonUpdate() {
    rayonState = !rayonState;
    notifyListeners();
  }

  sluzhbaUpdate() {
    sluzhbaState = !sluzhbaState;
    notifyListeners();
  }

  allLocDicUpdate() {
    subyektState = !subyektState;
    rayonState = !rayonState;
    sluzhbaState = !sluzhbaState;
    notifyListeners();
  }
}

class LocationDicData {
  static final String _host = finalHOST;

  static final String allSubyektsURI = '$_host/SubyektAll';
  static final String allRayonsURI = '$_host/RayonAll';
  static final String allSluzhbaURI = '$_host/SluzhbaAll';

  static String dicType;
  static const String _FILTER = 'filter';
  static const String _INPUT = 'input';

  static funcTypeSelector(Function filter, Function input) {
    if (dicType == _FILTER) {
      filter();
    } else if (dicType == _INPUT) {
      input();
    } else
      print('dicTypeSelector - фильтр не определен');
  }

  /// #######################
  static Subyekt subyektValueF;
  static String subyektIdF;

  static Rayon rayonValueF;
  static String rayonIdF;

  static Sluzhba sluzhbaValueF;
  static String sluzhbaIdF;

  static allLocationCLEAR() {
    subyektCLEAR();
    rayonCLEAR();
    sluzhbaCLEAR();
  }

  static subyektCLEAR() {
    subyektValueF = null;
    subyektIdF = null;
  }

  static rayonCLEAR() {
    rayonValueF = null;
    rayonIdF = null;
  }

  static sluzhbaCLEAR() {
    sluzhbaValueF = null;
    sluzhbaIdF = null;
  }

  static bool dicLoadStatus = false;

  static loadLocationDic() async {
    await loadSubyekt();
    await loadRayons();
    await loadSluzhba();
    await Future.delayed(Duration(milliseconds: 250));

    dicLoadStatus = true;
    Logger.events(func: 'loadDictionary', event: 'ALL LOAD');

    return dicLoadStatus;
  }

  static loadSubyekt() async {
    final response = await http.get(allSubyektsURI);
    String responseBody = utf8.decode(response.bodyBytes);

    final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
    allSubyekt = parsed.map<Subyekt>((json) => Subyekt.fromJson(json)).toList();
  }

  static loadRayons() async {
    final response = await http.get(allRayonsURI);
    String responseBody = utf8.decode(response.bodyBytes);

    final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
    allRayons = parsed.map<Rayon>((json) => Rayon.fromJson(json)).toList();
  }

  static loadSluzhba() async {
    final response = await http.get(allSluzhbaURI);
    String responseBody = utf8.decode(response.bodyBytes);

    final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
    allSluzhba = parsed.map<Sluzhba>((json) => Sluzhba.fromJson(json)).toList();
  }
}

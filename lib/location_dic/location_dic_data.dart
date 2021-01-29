import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utility/logger.dart';
import '../model/key_controller.dart';
import '../model/report.dart';
import 'location_dic_model.dart';

import '../2_list/list_data.dart';

class SubyektState with ChangeNotifier {
  int xUp = 0;

  subyektUpdate() {
    xUp = null;
    notifyListeners();
  }
}

class LocationData {
  static const String _HOST = 'http://localhost:9999';

  static const String ALL_Subyekts_URI = '$_HOST/SubyektAll';
  static const String ALL_Rayons_URI = '$_HOST/RayonAll';
  static const String ALL_Sluzhba_URI = '$_HOST/SluzhbaAll';

  static String dicType;
  static const String _FILTER = 'filter';
  static const String _INPUT = 'input';

  static dicTypeSelector(Function filter, Function input) {
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

  allLocationCLEAR() {
    subyektCLEAR();
    rayonCLEAR();
    sluzhbaCLEAR();
  }

  subyektCLEAR() {
    subyektValueF = null;
    subyektIdF = null;
  }

  rayonCLEAR() {
    rayonValueF = null;
    rayonIdF = null;
  }

  sluzhbaCLEAR() {
    sluzhbaValueF = null;
    sluzhbaIdF = null;
  }

  static bool dicLoadStatus = false;

  static loadLocationDic() async {
    Logger.events(func: 'loadDictionary', event: 'dicLoadStatus - $dicLoadStatus');
    if (dicLoadStatus == false) {
      await loadSubyekt();
      // await loadRayons();
      // await loadSluzhba();
      await Future.delayed(Duration(milliseconds: 300));
      Logger.events(func: 'loadDictionary', event: 'ALL LOAD');
      dicLoadStatus = true;
    }


    return dicLoadStatus;
  }

  static loadSubyekt() async {

    final response = await http.get(allSubyektsURI);
    String responseBody = utf8.decode(response.bodyBytes);

    final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
    allSubyekt = parsed.map<Subyekt>((json) => Subyekt.fromJson(json)).toList();
  }
}

String dicType;
String filterType = 'filter';
String inputType = 'input';

String host = 'http://localhost:9999';

String allSubyektsURI = '$host/SubyektAll';
String allRayonsURI = '$host/RayonAll';
String allSluzhbaURI = '$host/SluzhbaAll';

/// #######################
Subyekt subyektValueF;
String subyektIdF;

Rayon rayonValueF;
String rayonIdF;

Sluzhba sluzhbaValueF;
String sluzhbaIdF;

allLocationCLEAR() {
  subyektCLEAR();
  rayonCLEAR();
  sluzhbaCLEAR();
}

subyektCLEAR() {
  subyektValueF = null;
  subyektIdF = null;
}

rayonCLEAR() {
  rayonValueF = null;
  rayonIdF = null;
}

sluzhbaCLEAR() {
  sluzhbaValueF = null;
  sluzhbaIdF = null;
}

bool dicLoadStatus = false;

loadLocationDic() async {
  await loadSubyekt();
  // await loadRayons();
  // await loadSluzhba();
  Logger.events(func: 'loadDictionary()', event: '');
  dicLoadStatus = true;
  return dicLoadStatus;
}

loadSubyekt() async {
  //await Future.delayed(Duration(seconds: 1));
  final response = await http.get(allSubyektsURI);
  String responseBody = utf8.decode(response.bodyBytes);

  final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
  allSubyekt = parsed.map<Subyekt>((json) => Subyekt.fromJson(json)).toList();
}

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

    await loadSubyekt(id: '4ff758f5-eaff-4dd2-bef1-324c5d617609');
    //await loadRayons();
    //await loadSluzhba();
    await Future.delayed(Duration(milliseconds: 250));

    dicLoadStatus = true;
    Logger.events(func: 'loadDictionary', data: 'ALL LOAD');

    return dicLoadStatus;
  }









  static loadSubyekt({String id}) async {
    if (dicLoadStatus == false) {
      Uri uri = Uri.parse(allSubyektsURI);
      final response = await http.get(uri);
      String responseBody = utf8.decode(response.bodyBytes);

      final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
      subyektALL = parsed.map<Subyekt>((json) => Subyekt.fromJson(json)).toList();
      print('@@@@@@@@@@@@@@@@@@@@@ subyektALL.length  ${subyektALL.length}');
    }

    if (id != null) {
      subyektFILTER.clear();
      for (var subyekt in subyektALL) {
        if (id == subyekt.subyektId) {
          print('>>> $id');
          print('>>> ${subyekt.subyektId}');
          subyektFILTER.add(subyekt);
        }
      }
      print('@@@@@@@@@@@@@@@@@@ subyektFILTER.length  ${subyektFILTER.length}');
    }
  }


















  /// Район фильтруется по [rayon.subyektId]
  ///
  static loadRayons({String id}) async {
    if (dicLoadStatus == false) {
      Uri uri = Uri.parse(allRayonsURI);
      final response = await http.get(uri);
      String responseBody = utf8.decode(response.bodyBytes);

      final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
      rayonsALL = parsed.map<Rayon>((json) => Rayon.fromJson(json)).toList();
      print('@@@@@@@@@@@@@@@@@@@@@ rayonsALL.length  ${rayonsALL.length}');
    }

    if (id != null) {
      rayonsFILTER.clear();
      for (var rayon in rayonsALL) {
        if (id == rayon.subyektId) {
          print('>>> $id');
          print('>>> ${rayon.subyektId}');
          rayonsFILTER.add(rayon);
        }
      }
      print('@@@@@@@@@@@@@@@@@@ rayonsFILTER.length  ${rayonsFILTER.length}');
    }

  }















  static loadSluzhba() async {
    Uri uri = Uri.parse(allSluzhbaURI);
    final response = await http.get(uri);
    String responseBody = utf8.decode(response.bodyBytes);

    final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
    sluzhbaALL = parsed.map<Sluzhba>((json) => Sluzhba.fromJson(json)).toList();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utility/local_storage.dart';
import '../utility/logger.dart';
import '../utility/all_page.dart';

/// +++ GLOBAL CONSTANT +++++++++++++++++++++++++++

const String HOST1 = 'http://localhost:9999';
const String HOST2 = '';

final String finalHOST = HOST1;

/// +++++++++++++++++++++++++++++++++++++++++++++++
/// HOST2 и HOME = ''
/// http.cors().disable(); и  http.csrf().disable();
///
/// в этом случае работает, но переход на service worker
///
class PageRout {
  static const String HOME = '';
  static const String LIST = 'list';
  static const String INPUT = 'input';
  static const String VOID = 'void';
  static const String TEST = 'test';
  static String currentRout;
  static String _currentLocalRout;

  static _setCurrentRout({String cRout}) async {
    if (cRout != null) {
      currentRout = cRout;
      await localStorage.save(key: 'currentRout', value: currentRout);
    }
    Logger.events(func: 'setCurrentRout', data: currentRout);
  }

  static goToPage(BuildContext context, rout) {
    _setCurrentRout(cRout: rout);
    Navigator.of(context).push(MaterialPageRoute<Null>(
      maintainState: false,
      builder: (BuildContext context) {
        return _pageSelector(rout);
      },
    ));
  }

  static _pageSelector(String rout) {
    switch (rout) {
      case HOME:
        return HomePgLayout();
        break;
      case LIST:
        return ListPgLayout();
        break;
    }
  }

  static getCurrentRout() async {
    if (currentRout == null) {
      await localStorage.load(key: 'currentRout', setFromLocal: _getRoutFromLocal);
      currentRout = _currentLocalRout;
    }

    Logger.events(func: 'currentRout', data: currentRout);

    return currentRout;
  }

  static _getRoutFromLocal(String cRout) {
    _currentLocalRout = cRout;
  }
}

class ReportKEY {
  static const String PPO_KEY = 'ppo_key';
  static const String PPO_COLL = 'ppo_coll';
  static const String PPO_NAME = 'Отчет об обновлении ППО Системы';

  static const String PROFRAB_KEY = 'profRab_key';
  static const String PROFRAB_COLL = 'profRab_coll';
  static const String PROFRAB_NAME = 'Отчет о выполненных профилактических работах';

  static const String INCIDENT_KEY = 'incident_key';
  static const String INCIDENT_COLL = 'incident_coll';
  static const String INCIDENT_NAME = 'Отчет о предупреждении инцидентов';

  static const String TEH112_KEY = 'teh112_key';
  static const String TEH112_COLL = 'teh112_coll';
  static const String TEH112_NAME = 'Техобслуживание 112 и пожарный мониторинг';

  static const String ACTIVE_Z_KEY = 'activZadachi_key';
  static const String ACTIVE_Z_COLL = 'activZadachi_coll';
  static const String ACTIVE_Z_NAME = 'Задачи';

  static String reportKEY;
  static String _reportLocalKEY;
  static String reportCOLL;
  static String reportNAME = 'нет данных';

  static String reportID;
  static String _reportLocalID;

  static String userROLE;
  static String userFIO = '-';

  static const String ADMIN = "ADMIN";
  static const String PROG = "PROG";
  static const String userPRIM = "userPRIM";
  static const String userHAB = "userHAB";
  static const String testROLE = "testROLE";

  static setReportKEY({String rKEY}) async {
    reportKEY = rKEY;
    _setBaseParameters(rKEY: reportKEY);
    if (reportKEY != null) {
      await localStorage.save(key: 'reportKEY', value: reportKEY);
    }
    Logger.events(func: 'setReportKEY', data: reportKEY);
  }

  static getReportKEY() async {
    if (reportKEY == null && _reportLocalKEY == null) {
      await localStorage.load(key: 'reportKEY', setFromLocal: _getKEYFromLocal);
      reportKEY = _reportLocalKEY;
      _setBaseParameters(rKEY: reportKEY);
    }

    Logger.events(func: 'getReportKEY', data: reportKEY);

    //logger.events(func: 'getCollection()', event: '$collection');
    await _getUserDetail();
  }

  static _getKEYFromLocal(String rKEY) {
    _reportLocalKEY = rKEY;
  }

  static setReportID({String rID}) async {
    reportID = rID;

    if (reportID != null) {
      await localStorage.save(key: 'reportID', value: reportID);
    }

    Logger.events(func: 'setReportID', data: reportID);
  }

  static getReportID() async {
    if (reportID == null) {
      await getReportKEY();
      await localStorage.load(key: 'reportID', setFromLocal: _getIDFromLocal);
      reportID = _reportLocalID;

    }
    ConstructorURI.setReportIdURI(rID: reportID);
    Logger.events(func: 'getReportID', data: reportID);

    print('byIdURI ${ConstructorURI.byIdURI}');
    print('activeByIdURI ${ConstructorURI.activeByIdURI}');
  }

  static _getIDFromLocal(String rID) {
    _reportLocalID = rID;
  }

  static deleteReportID() {
    reportID = null;
    _reportLocalID = '-';
    ConstructorURI.setReportIdURI(rID: reportID);

    localStorage.remove(key: 'reportID');

    Logger.events(func: 'deleteReportID', data: reportID);

    print('byIdURI ${ConstructorURI.byIdURI}');
  }

  static _setBaseParameters({@required String rKEY}) {
    switch (reportKEY) {
      case PPO_KEY:
        reportCOLL = PPO_COLL;
        reportNAME = PPO_NAME;
        break;

      case PROFRAB_KEY:
        reportCOLL = PROFRAB_COLL;
        reportNAME = PROFRAB_NAME;
        break;

      case INCIDENT_KEY:
        reportCOLL = INCIDENT_COLL;
        reportNAME = INCIDENT_NAME;
        break;

      case TEH112_KEY:
        reportCOLL = TEH112_COLL;
        reportNAME = TEH112_NAME;
        break;

      case ACTIVE_Z_KEY:
        reportCOLL = TEH112_COLL;
        reportNAME = ACTIVE_Z_NAME;
        break;
    }

    ConstructorURI.setBaseURI(collection: reportCOLL);
  }


  static _getUserDetail() async {
    Uri uri = Uri.parse('http://localhost:9999/GetName');
    final response = await http.get( uri);
    String responseBody = utf8.decode(response.bodyBytes);

    var parsed = jsonDecode(responseBody);

    userROLE = parsed[0];
    userFIO = parsed[1];

  }
}

class ConstructorURI {

  static final String _host = finalHOST;

  static String listURI;
  static String _listURIBase;
  static String byIdURI;
  static String _byIdURIBase;
  static String saveURI;
  static String saveActiveURI;
  static String activeByIdURI;
  static String _activeByIdURIBase;
  static String getAllURI;

  static int _start = 0;
  static int _end = 9999999999999;
  static String _subyektId = '';
  static String _rayonId = '';
  static String _sluzhbaId = '';
  static int _activeSign = 0;

  static setBaseURI({String collection}) {
    _byIdURIBase = '$_host/ByID?collectionX=$collection&idX=';
    saveURI = '$_host/SAVE?collectionX=$collection';
    saveActiveURI = '$_host/SAVE_active';
    _activeByIdURIBase = '$_host/Replace_active?teh112id=';
    getAllURI = '$_host/ALL?collectionX=$collection';
    _listURIBase = '$_host/Replace?collectionX=$collection';
    setRequestFilter();
  }

  static setReportIdURI({String rID}) {
    if (rID != null) {
      byIdURI = _byIdURIBase + rID;
      activeByIdURI = _activeByIdURIBase + rID;
    } else {
      byIdURI = _byIdURIBase;
      activeByIdURI = _activeByIdURIBase;
    }


  }




  static setRequestFilter({
    String subyekt,
    String rayon,
    String sluzhba,
    int start,
    int end,
    int activeSign,
  }) {
    if (subyekt != null) {
      _subyektId = subyekt;
    }

    if (rayon != null) {
      _rayonId = rayon;
    }

    if (sluzhba != null) {
      _sluzhbaId = sluzhba;
    }

    if (start != null) {
      _start = start;
    }

    if (end != null) {
      _end = end;
    }

    if (activeSign != null) {
      _activeSign = activeSign;
    }

    listURI = _listURIBase +
        '&activeSign=$_activeSign&start=$_start&end=$_end&subyektId=$_subyektId&rayonId=$_rayonId&sluzhbaId=$_sluzhbaId';

    print('listURI $listURI');
  }
}

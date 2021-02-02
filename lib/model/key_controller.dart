import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utility/local_storage.dart';
import '../utility/logger.dart';
import '../utility/all_page.dart';

/// +++ GLOBAL CONSTANT +++++++++++++++++++++++++++

const String HOST1 = 'http://localhost:9999';
const String HOST2 = '';

final String finalHOST = HOST1;

/// +++++++++++++++++++++++++++++++++++++++++++++++

class PageRout {
  static const String HOME = 'home';
  static const String LIST = 'list';
  static const String INPUT = 'input';
  static const String VOID = 'void';
  static String currentRout;
  static String _currentLocalRout;

  static _setCurrentRout({String cRout}) async {
    if (cRout != null) {
      currentRout = cRout;
      await localStorage.save(key: 'currentRout', value: currentRout);
    }
    Logger.events(func: 'setCurrentRout', event: currentRout);
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

    Logger.events(func: 'currentRout', event: currentRout);

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

  static setReportKEY({String rKEY}) async {
    reportKEY = rKEY;
    _setBaseParameters(rKEY: reportKEY);
    if (reportKEY != null) {
      await localStorage.save(key: 'reportKEY', value: reportKEY);
    }
    Logger.events(func: 'setReportKEY', event: reportKEY);
  }

  static getReportKEY() async {
    if (reportKEY == null && _reportLocalKEY == null) {
      await localStorage.load(key: 'reportKEY', setFromLocal: _getKEYFromLocal);
      reportKEY = _reportLocalKEY;
      _setBaseParameters(rKEY: reportKEY);
    }

    Logger.events(func: 'getReportKEY', event: reportKEY);

    //logger.events(func: 'getCollection()', event: '$collection');
  }

  static _getKEYFromLocal(String rKEY) {
    _reportLocalKEY = rKEY;
  }

  static setReportID({String rID}) async {
    reportID = rID;

    if (reportID != null) {
      await localStorage.save(key: 'reportID', value: reportID);
    }

    Logger.events(func: 'setReportID', event: reportID);
  }

  static getReportID() async {
    if (reportID == null) {
      await getReportKEY();
      await localStorage.load(key: 'reportID', setFromLocal: _getIDFromLocal);
      reportID = _reportLocalID;
    }
    ConstructorURI.setReportIdURI(rID: reportID);
    Logger.events(func: 'getReportID', event: reportID);

    print('byIdURI ${ConstructorURI.byIdURI}');
  }

  static _getIDFromLocal(String rID) {
    _reportLocalID = rID;
  }

  static deleteReportID() {
    reportID = null;
    _reportLocalID = '-';
    ConstructorURI.setReportIdURI(rID: reportID);

    localStorage.remove(key: 'reportID');

    Logger.events(func: 'deleteReportID', event: reportID);

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
}

class ConstructorURI {

  static final String _host = finalHOST;

  static String listURI;
  static String _listURIBase;
  static String byIdURI;
  static String _byIdURIBase;
  static String saveURI;
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
    getAllURI = '$_host/ALL?collectionX=$collection';
    _listURIBase = '$_host/Replace?collectionX=$collection';
    setRequestFilter();
  }

  static setReportIdURI({String rID}) {
    if (rID != null) {
      byIdURI = _byIdURIBase + rID;
    } else
      byIdURI = _byIdURIBase;
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

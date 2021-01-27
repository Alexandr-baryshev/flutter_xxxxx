import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'local_storage.dart';
import '../utility/logger.dart';

class PageRout {
  static const String HOME = 'home';
  static const String LIST = 'list';
  static const String INPUT = 'input';
  static const String VOID = 'void';

  static goTo(BuildContext context, rout) {
    Navigator.pushNamed(context, rout);
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

  static setReportKEY({String rKEY}) async {
    reportKEY = rKEY;
    _setBaseParameters(rKEY: reportKEY);
    if (reportKEY != null) {
      await locStor.save(key: 'reportKEY', value: reportKEY);
    }
    Logger.events(func: 'setReportKEY', event: reportKEY);
  }

  static _getKEYFromLocal(String rKEY) {
    _reportLocalKEY = rKEY;
  }

  static getReportKEY() async {
    if (reportKEY == null) {
      await locStor.load(key: 'reportKEY', setFromLocal: _getKEYFromLocal);
      reportKEY = _reportLocalKEY;
      _setBaseParameters(rKEY: reportKEY);
    }

    Logger.events(func: 'getReportKEY', event: reportKEY);

    //logger.events(func: 'getCollection()', event: '$collection');
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
        reportCOLL = ACTIVE_Z_COLL;
        reportNAME = ACTIVE_Z_NAME;
        break;
    }

    ConstructorURI.setBaseURI(collection: reportCOLL);
  }
}

class ConstructorURI {
  static const String _host2 = '/';
  static const String _host = 'http://localhost:9999';

  static String listURI;
  static String byIdURI;
  static String saveURI;
  static String getAllURI;

  static int _start = 0;
  static int _end = 9999999999999;
  static String _subyektId = '';
  static String _rayonId = '';
  static String _sluzhbaId = '';
  static int _activeSign = 0;

  static setBaseURI({@required String collection}) {
    byIdURI = '$_host/ByID?collectionX=$collection&idX=';
    saveURI = '$_host/SAVE?collectionX=$collection';
    getAllURI = '$_host/ALL?collectionX=$collection';
    listURI = '$_host/Replace?collectionX=$collection';
    setRequestFilter();
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

    listURI =
        '$listURI&activeSign=$_activeSign&start=$_start&end=$_end&subyektId=$_subyektId&rayonId=$_rayonId&sluzhbaId=$_sluzhbaId';
    print('listURI $listURI');
  }
}

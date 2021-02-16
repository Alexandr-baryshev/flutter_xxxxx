import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/key_controller.dart';
import '../utility//logger.dart';
import 'info_dic_model.dart';



class InfoDicData {

  static final String allTipZadachiURI = '$finalHOST/TipZadachi';

  static bool _dicLoadStatus = false;

  static loadInfoDic() async {
    if (_dicLoadStatus == false) {
      await loadTipZadachi();

      Logger.events(func: 'loadInfoDic()', data: '');
      _dicLoadStatus = true;
    }

    return _dicLoadStatus;
  }

  static loadTipZadachi() async {
    Uri uri = Uri.parse(allTipZadachiURI);
    final response = await http.get(uri);
    String responseBody = utf8.decode(response.bodyBytes);

    final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
    tipZadachiList = parsed.map<TipZadachi>((json) => TipZadachi.fromJson(json)).toList();
  }

}



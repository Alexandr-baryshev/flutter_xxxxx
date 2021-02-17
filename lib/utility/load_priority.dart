import '../3_input/input_data.dart';

import '../location_dic/location_dic_data.dart';

inputLoadPriority () async {

  if (LocationDicData.dicType == 'input') {
    await InputPgData.fetchReportByID();
    await LocationDicData.loadLocationDic();
  } else {
    await LocationDicData.loadLocationDic();
  }

return true;

}
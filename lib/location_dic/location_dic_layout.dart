import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utility/logger.dart';
import '../model/key_controller.dart';
import '../utility/style.dart';

import '../2_list/list_data.dart';
import 'location_dic_data.dart';
import 'subyekt_dic.dart';
// import 'rayon_dic.dart';
// import 'sluzhba_dic.dart';


class LocationDicLayout extends StatelessWidget {
  final String type;

  LocationDicLayout({this.type});

  @override
  Widget build(BuildContext context) {
    Logger.events(widget: '${context.widget}', func: 'Widget build', event: type);

    LocationData.dicType = type;

    // Данный if else определяет, загружен ли справочник.
    if (LocationData.dicLoadStatus == false) {
      return FutureBuilder(
          future: LocationData.loadLocationDic(),
          builder: (context, snapshot) {
            if (snapshot.hasData == true) {
              return dictionaryContainer(context);
            } else
              return Center(child: CircularProgressIndicator());
          });
    } else
      return dictionaryContainer(context);
  }

  Container dictionaryContainer(BuildContext context) {
    clearLocationFilter() {
      if (LocationData.dicType == filterType) {
        ConstructorURI.setRequestFilter(subyekt: '', rayon: '', sluzhba: '');
        allLocationCLEAR();
        context.read<ListTableState>().listTableUpdate();
        context.read<SubyektState>().subyektUpdate();
        //context.read<RayonState>().rayonUpdate();
        //context.read<SluzhbaState>().sluzhbaUpdate();
      }
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 70,
      //color: Colors.amberAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SubyektDic(),
          ),
          SizedBox(width: 5),
/*          Expanded(
            child: RayonDic(),
          ),
          SizedBox(width: 5),
          Expanded(
            //child: CityDic(),
            child: SluzhbaDic(),
          ),*/
          Visibility(
            visible: LocationData.dicType == filterType,
            child: IconButton(
              iconSize: 40,
              icon: Icon(
                Icons.clear,
                color: barBgColor,
              ),
              onPressed: clearLocationFilter,
            ),
          ),
        ],
      ),
    );
  }
}

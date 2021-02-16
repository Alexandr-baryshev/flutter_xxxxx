import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utility/logger.dart';
import '../model/key_controller.dart';
import '../utility/style.dart';

import '../2_list/list_data.dart';

import 'location_dic_data.dart';
import 'subyekt_dic.dart';
import 'rayon_dic.dart';
import 'sluzhba_dic.dart';

class LocationDicLayout extends StatelessWidget {
  final String type;

  LocationDicLayout({this.type});

  @override
  Widget build(BuildContext context) {
    Logger.events(
        class_: '${context.widget}',
        func: 'Widget build',
        data: 'type $type | dicLoadStatus - ${LocationDicData.dicLoadStatus}');

    LocationDicData.dicType = type;

    // Данный if else определяет, загружен ли справочник.
    if (LocationDicData.dicLoadStatus == false) {
      return FutureBuilder(
          future: LocationDicData.loadLocationDic(),
          builder: (context, snapshot) {
            if (snapshot.hasData == true) {
              return getScreenSizeLB(context, vertical(context), horizontal(context));
            } else
              return Center(child: LinearProgressIndicator());
          });
    } else
      return getScreenSizeLB(context, vertical(context), horizontal(context));
  }

  Container horizontal(BuildContext context) {
    clearLocationFilter() {
      if (LocationDicData.dicType == 'filter') {
        ConstructorURI.setRequestFilter(subyekt: '', rayon: '', sluzhba: '');
        LocationDicData.allLocationCLEAR();
        context.read<ListPgState>().listTableUpdate();
        context.read<LocationState>().allLocDicUpdate();
      }
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 70,
      //color: Colors.amberAccent,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SubyektDic(),
          ),
/*          SizedBox(width: 5),
          Expanded(
            child: RayonDic(),
          ),
          SizedBox(width: 5),
          Expanded(
            //child: CityDic(),
            child: SluzhbaDic(),
          ),*/
          Visibility(
            visible: LocationDicData.dicType == 'filter',
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

  Container vertical(BuildContext context) {
    clearLocationFilter() {
      if (LocationDicData.dicType == 'filter') {
        ConstructorURI.setRequestFilter(subyekt: '', rayon: '', sluzhba: '');
        LocationDicData.allLocationCLEAR();
        context.read<ListPgState>().listTableUpdate();
        context.read<LocationState>().allLocDicUpdate();
      }
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),

      //color: Colors.amberAccent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SubyektDic(),
                SizedBox(height: 5),
                RayonDic(),
                SizedBox(height: 5),
                SluzhbaDic(),
              ],
            ),
          ),
          Visibility(
            visible: LocationDicData.dicType == 'filter',
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/key_controller.dart';
import '../model/report.dart';
import '../utility/style.dart';
import '../utility/logger.dart';
import 'location_dic_model.dart';
import 'location_dic_data.dart';
import '../2_list/list_data.dart';

class RayonDic extends StatefulWidget {
  @override
  _RayonDicState createState() => _RayonDicState();
}

class _RayonDicState extends State<RayonDic> {
  String currentItemID;
  Rayon currentValue;








  _loadAsFilter() {
    currentItemID = LocationDicData.rayonIdF;
    currentValue = LocationDicData.rayonValueF;
    print('RayonDic - loadAsFilter');
  }


// TODO ДЛЯ ACTIVE > загрузить из коллекции с параметром teh11id
  _loadAsInput() {
    currentItemID = oneReport.rayonID;

    int x = 0;
    rayonsFILTER.clear();
    for (var oneData in rayonsALL) {
      if (oneData.subyektId == oneReport.subyektID) {
        rayonsFILTER.add(oneData);

        x++;
      }
    }

    for (var oneData in rayonsFILTER) {
      if (oneData.rayonId == currentItemID) {
        currentValue = oneData;
        break;
      } else {
        currentValue = null;
      }
    }
    print('RayonDic - loadAsInput');
  }



  _setChangeAsFilter() {
    LocationDicData.rayonValueF = currentValue;
    LocationDicData.rayonIdF = currentValue.rayonId;
    ConstructorURI.setRequestFilter(rayon: LocationDicData.rayonIdF);
    context.read<ListPgState>().listTableUpdate();
  }

  _setChangeAsInput() {
    oneReport.rayonID = currentValue.rayonId;
  }

  _setChange(Rayon newValue) {
    setState(() {
      currentValue = newValue;
    });

    LocationDicData.funcTypeSelector(_setChangeAsFilter, _setChangeAsInput);

    //LocationData.sluzhbaCLEAR();
  }


  _filterLocation() async {

    rayonsFILTER.clear();


    for (var oneData in rayonsALL) {
      if (oneData.subyektId == LocationDicData.subyektIdF) {
        rayonsFILTER.add(oneData);


      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    Logger.events(class_: '${context.widget}', func: 'Widget build', data: '');


    bool rayonState = context.select((LocationState ls) => ls.rayonState);

    return FutureBuilder(
        future: _filterLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            LocationDicData.funcTypeSelector(_loadAsFilter, _loadAsInput);

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: dicBoxDecor(),
              child: DropdownButton(
                isExpanded: true,
                hint: Text('Район'),
                underline: Container(),
                value: currentValue,
                style: dropDownStyle(),
                onChanged: (Rayon newValue) {
                  _setChange(newValue);
                },
                items: rayonsFILTER.map((Rayon rayon) {
                  return DropdownMenuItem<Rayon>(
                    value: rayon,
                    child: Text(rayon.rayonName),
                  );
                }).toList(),
              ),
            );
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}

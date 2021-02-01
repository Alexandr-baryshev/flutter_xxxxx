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
    currentItemID = LocationData.rayonIdF;
    currentValue = LocationData.rayonValueF;
    print('RayonDic - loadAsFilter');
  }

  _loadAsInput() {
    currentItemID = oneReport.rayonID;

    int x = 0;
    filterRayons.clear();
    for (var oneData in allRayons) {
      if (oneData.subyektId == oneReport.subyektID) {
        filterRayons.add(oneData);

        x++;
      }
    }

    for (var oneData in filterRayons) {
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
    LocationData.rayonValueF = currentValue;
    LocationData.rayonIdF = currentValue.rayonId;
    ConstructorURI.setRequestFilter(rayon: LocationData.rayonIdF);
    context.read<ListPgState>().listTableUpdate();
  }

  _setChangeAsInput() {
    oneReport.rayonID = currentValue.rayonId;
  }

  _setChange(Rayon newValue) {
    setState(() {
      currentValue = newValue;
    });

    LocationData.funcTypeSelector(_setChangeAsFilter, _setChangeAsInput);

    //LocationData.sluzhbaCLEAR();
  }


  _filterLocation() async {
    int x = 0;
    filterRayons.clear();
    //String id;

    for (var oneData in allRayons) {
      if (oneData.subyektId == LocationData.subyektIdF) {
        filterRayons.add(oneData);

        x++;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    Logger.events(widget: '${context.widget}', func: 'Widget build', event: '');


    bool rayonState = context.select((LocationState ls) => ls.rayonState);

    return FutureBuilder(
        future: _filterLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            LocationData.funcTypeSelector(_loadAsFilter, _loadAsInput);

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
                items: filterRayons.map((Rayon rayon) {
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

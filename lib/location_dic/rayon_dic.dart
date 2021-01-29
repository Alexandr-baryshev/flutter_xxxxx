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

  loadAsFilter() {
    currentItemID = LocationData.rayonIdF;
    currentValue = LocationData.rayonValueF;
    print('RayonDic - loadAsFilter');
  }

  loadAsInput() {
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

  setChangeAsFilter() {
    LocationData.rayonValueF = currentValue;
    LocationData.rayonIdF = currentValue.rayonId;
    ConstructorURI.setRequestFilter(rayon: LocationData.rayonIdF);
    context.read<ListTableState>().listTableUpdate();
  }

  setChangeAsInput() {
    oneReport.rayonID = currentValue.rayonId;
  }

  setChange(Rayon newValue) {
    setState(() {
      currentValue = newValue;
    });

    LocationData.funcTypeSelector(setChangeAsFilter, setChangeAsInput);

    LocationData.sluzhbaCLEAR();
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
    int xUp = context.watch<RayonState>().xUp;

    return FutureBuilder(
        future: _filterLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            LocationData.funcTypeSelector(loadAsFilter, loadAsInput);

            return Container(
              decoration: dicBoxDecor(),
              child: Center(
                child: DropdownButton(
                  hint: Text('Район'),
                  underline: Container(),
                  value: currentValue,
                  style: dropDownStyle(),
                  onChanged: (Rayon newValue) {
                    setChange(newValue);
                  },
                  items: filterRayons.map((Rayon rayon) {
                    return DropdownMenuItem<Rayon>(
                      value: rayon,
                      child: Text(rayon.rayonName),
                    );
                  }).toList(),
                ),
              ),
            );
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}

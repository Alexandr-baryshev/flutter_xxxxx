import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/key_controller.dart';
import '../model/report.dart';
import '../utility/style.dart';
import '../utility/logger.dart';
import 'location_dic_model.dart';
import 'location_dic_data.dart';
import '../2_list/list_data.dart';

class SubyektDic extends StatefulWidget {
  @override
  _SubyektDicState createState() => _SubyektDicState();
}

class _SubyektDicState extends State<SubyektDic> {
  String currentItemID;
  Subyekt currentValue;

  filterFunc() {
    currentItemID = LocationData.subyektIdF;
    currentValue = LocationData.subyektValueF;
    print('dicTypeSelector - filterFunc');
  }

  inputFunc() {
    currentItemID = oneReport.subyektID;
    print('dicTypeSelector - inputFunc');
    for (var oneData in allSubyekt) {
      if (oneData.subyektId == currentItemID) {
        currentValue = oneData;
        break;
      }
    }
  }

  setChange(Subyekt newValue) {
    setState(() {
      currentValue = newValue;
    });

    if (LocationData.dicType == filterType) {
      LocationData.subyektValueF = newValue;
      LocationData.subyektIdF = newValue.subyektId;

      ConstructorURI.setRequestFilter(subyekt: LocationData.subyektIdF, rayon: '', sluzhba: '');
      context.read<ListTableState>().listTableUpdate();
    }
    else if (LocationData.dicType == inputType) {
      oneReport.subyektID = currentValue.subyektId;
      oneReport.rayonID = null;
    }
    rayonCLEAR();
    //context.read<RayonState>().rayonUpdate();
  }

  @override
  Widget build(BuildContext context) {
    Logger.events(widget: '${context.widget}', func: 'Widget build', event: '');
    LocationData.dicTypeSelector(filterFunc, inputFunc);

    int xUp = context.watch<SubyektState>().xUp;

    return Container(
      decoration: dicBoxDecor(),
      child: Center(
        child: DropdownButton(
          hint: Text('Субъект'),
          underline: Container(),
          value: currentValue,
          style: dropDownStyle(),
          onChanged: (Subyekt newValue) {
            setChange(newValue);
          },
          items: allSubyekt.map((Subyekt subyekt) {
            return DropdownMenuItem<Subyekt>(
              value: subyekt,
              child: Text(subyekt.subyektName),
            );
          }).toList(),
        ),
      ),
    );
  }
}

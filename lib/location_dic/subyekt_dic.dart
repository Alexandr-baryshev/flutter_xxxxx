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

  loadAsFilter() {
    currentItemID = LocationDicData.subyektIdF;
    currentValue = LocationDicData.subyektValueF;
    print('SubyektDic - loadAsFilter');
  }

  loadAsInput() {
    currentItemID = oneReport.subyektID;

    for (var oneData in allSubyekt) {
      if (oneData.subyektId == currentItemID) {
        currentValue = oneData;
        break;
      }
    }
    print('SubyektDic - loadAsInput');
  }

  setChangeAsFilter() {
    LocationDicData.subyektValueF = currentValue;
    LocationDicData.subyektIdF = currentValue.subyektId;

    ConstructorURI.setRequestFilter(
        subyekt: LocationDicData.subyektIdF, rayon: '', sluzhba: '');
    context.read<ListPgState>().listTableUpdate();
  }

  setChangeAsInput() {
    oneReport.subyektID = currentValue.subyektId;
    oneReport.rayonID = null;
  }

  setChange(Subyekt newValue) {
    setState(() {
      currentValue = newValue;
    });

    LocationDicData.funcTypeSelector(setChangeAsFilter, setChangeAsInput);

    LocationDicData.rayonCLEAR();
    context.read<LocationState>().rayonUpdate();

  }

  @override
  Widget build(BuildContext context) {
    Logger.events(class_: '${context.widget}', func: 'Widget build', data: '');
    LocationDicData.funcTypeSelector(loadAsFilter, loadAsInput);

    bool subyektState = context.select((LocationState ls) => ls.subyektState);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: dicBoxDecor(),
      child: DropdownButton(
        isExpanded: true,
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
    );
  }
}

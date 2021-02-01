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
    currentItemID = LocationData.subyektIdF;
    currentValue = LocationData.subyektValueF;
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
    LocationData.subyektValueF = currentValue;
    LocationData.subyektIdF = currentValue.subyektId;

    ConstructorURI.setRequestFilter(
        subyekt: LocationData.subyektIdF, rayon: '', sluzhba: '');
    context.read<ListTableState>().listTableUpdate();
  }

  setChangeAsInput() {
    oneReport.subyektID = currentValue.subyektId;
    oneReport.rayonID = null;
  }

  setChange(Subyekt newValue) {
    setState(() {
      currentValue = newValue;
    });

    LocationData.funcTypeSelector(setChangeAsFilter, setChangeAsInput);

    LocationData.rayonCLEAR();
    context.read<LocationState>().rayonUpdate();

  }

  @override
  Widget build(BuildContext context) {
    Logger.events(widget: '${context.widget}', func: 'Widget build', event: '');
    LocationData.funcTypeSelector(loadAsFilter, loadAsInput);

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

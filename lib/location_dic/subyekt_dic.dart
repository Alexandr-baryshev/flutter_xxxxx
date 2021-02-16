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
  String currentName = "Субъект";
  Subyekt currentValue;




  _loadAsFilter() {
    currentItemID = LocationDicData.subyektIdF;
    currentValue = LocationDicData.subyektValueF;
    print('SubyektDic - loadAsFilter');
  }

  _loadAsInput() {
    currentItemID = oneReport.subyektID;

    for (var oneData in subyektALL) {
      if (oneData.subyektId == currentItemID) {
        currentValue = oneData;
        break;
      }
    }
    print('SubyektDic - loadAsInput');
  }

  _setChangeAsFilter() {
    LocationDicData.subyektValueF = currentValue;
    LocationDicData.subyektIdF = currentValue.subyektId;

    ConstructorURI.setRequestFilter(
        subyekt: LocationDicData.subyektIdF, rayon: '', sluzhba: '');
    context.read<ListPgState>().listTableUpdate();
  }

  _setChangeAsInput() {
    oneReport.subyektID = currentValue.subyektId;
    oneReport.rayonID = null;
  }

  _setChange(Subyekt newValue) {
    setState(() {
      currentValue = newValue;
    });

    LocationDicData.funcTypeSelector(_setChangeAsFilter, _setChangeAsInput);

    LocationDicData.rayonCLEAR();
    context.read<LocationState>().rayonUpdate();

  }

  @override
  Widget build(BuildContext context) {
    Logger.events(class_: '${context.widget}', func: 'Widget build', data: '');
    LocationDicData.funcTypeSelector(_loadAsFilter, _loadAsInput);

    bool subyektState = context.select((LocationState ls) => ls.subyektState);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: dicBoxDecor(),
      child: DropdownButton(
        isExpanded: true,

        hint: Text(currentName),
        disabledHint: Text(currentName),
        underline: Container(),
        value: currentValue,
        style: dropDownStyle(),
        onChanged: (Subyekt newValue) {
          _setChange(newValue);
        },
        items: subyektALL.map((Subyekt subyekt) {
          return DropdownMenuItem<Subyekt>(
            value: subyekt,
            child: Text(subyekt.subyektName),
          );
        }).toList(),
      ),
    );
  }
}

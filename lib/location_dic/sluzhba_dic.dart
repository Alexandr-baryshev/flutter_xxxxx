import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/key_controller.dart';
import '../model/report.dart';
import '../utility/style.dart';
import '../utility/logger.dart';
import 'location_dic_model.dart';
import 'location_dic_data.dart';
import '../2_list/list_data.dart';

/// Что должен делать данный справочник
/// 1. определять, где его используют:
///    * если это фильтр, добавлять id в link-setter и обновлять listTable
///    * если это ввод, добавлять id в поле
/// 2. отображать выбранную информацию

class SluzhbaDic extends StatefulWidget {
  @override
  _SluzhbaDicState createState() => _SluzhbaDicState();
}

class _SluzhbaDicState extends State<SluzhbaDic> {
  String currentItemID;
  Sluzhba currentValue;

  _loadAsFilter() {
    currentItemID = LocationDicData.sluzhbaIdF;
    currentValue = LocationDicData.sluzhbaValueF;
    print('SluzhbaDic - loadAsFilter');
  }

  _loadAsInput() {
    currentItemID = oneReport.sluzhbaID;
    for (var oneData in allSluzhba) {
      if (oneData.sluzhbaId == currentItemID) {
        currentValue = oneData;
        break;
      }
    }
    print('SluzhbaDic - loadAsInput');
  }

  _setChangeAsFilter() {
    LocationDicData.sluzhbaValueF = currentValue;
    LocationDicData.sluzhbaIdF = currentValue.sluzhbaId;
    ConstructorURI.setRequestFilter(sluzhba: LocationDicData.sluzhbaIdF);
    context.read<ListPgState>().listTableUpdate();
  }

  _setChangeAsInput() {
    oneReport.sluzhbaID = currentValue.sluzhbaId;
  }

  _setChange(Sluzhba newValue) {
    setState(() {
      currentValue = newValue;
    });

    LocationDicData.funcTypeSelector(_setChangeAsFilter, _setChangeAsInput);
  }

  @override
  Widget build(BuildContext context) {
    Logger.events(class_: '${context.widget}', func: 'Widget build', data: '');

    bool sluzhbaState = context.select((LocationState ls) => ls.sluzhbaState);

    LocationDicData.funcTypeSelector(_loadAsFilter, _loadAsInput);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: dicBoxDecor(),
      child: DropdownButton(
        isExpanded: true,
        hint: Text('Служба'),
        underline: Container(),
        value: currentValue,
        style: dropDownStyle(),
        onChanged: (Sluzhba newValue) {
          _setChange(newValue);
        },
        items: allSluzhba.map((Sluzhba sluzhba) {
          return DropdownMenuItem<Sluzhba>(
            value: sluzhba,
            child: Text(sluzhba.sluzhbaName),
          );
        }).toList(),
      ),
    );
  }
}

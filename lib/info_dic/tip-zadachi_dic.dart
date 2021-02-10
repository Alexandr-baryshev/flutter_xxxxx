import 'package:flutter/material.dart';

import '../model/report.dart';
import '../utility/utility_export.dart';

import 'info_dic_data.dart';
import 'info_dic_model.dart';

/// Что должен делать данный справочник
/// 1. определять, где его используют:
///    * если это фильтр, добавлять id в link-setter и обновлять listTable
///    * если это ввод, добавлять id в поле
/// 2. отображать выбранную информацию

class TipZadachiDic extends StatefulWidget {
  @override
  _TipZadachiDicState createState() => _TipZadachiDicState();
}

class _TipZadachiDicState extends State<TipZadachiDic> {
  String currentItemID;
  TipZadachi currentValue;

  _loadItem() {
    currentItemID = oneReport.activeTypeID;

    for (var oneData in tipZadachiList) {
      if (oneData.tipZadachiId == currentItemID) {
        currentValue = oneData;
        break;
      }
    }
  }

  _setChange(TipZadachi newValue) {
    setState(() {
      currentValue = newValue;
    });

    oneReport.activeTypeID = currentValue.tipZadachiId;
  }

  @override
  Widget build(BuildContext context) {
    Logger.events(class_: '${context.widget}', func: 'Widget build', data: '');

    return FutureBuilder(
        future: InfoDicData.loadInfoDic(),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            _loadItem();

            return Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: dicBoxDecor(),
              child: Center(
                child: DropdownButton(
                  //isExpanded: true,
                  hint: Text('Тип задачи'),
                  underline: Container(),
                  value: currentValue,
                  style: dropDownStyle(),
                  onChanged: (TipZadachi newValue) {
                    _setChange(newValue);
                  },
                  items: tipZadachiList.map((TipZadachi tipZadachi) {
                    return DropdownMenuItem<TipZadachi>(
                      value: tipZadachi,
                      child: Text(tipZadachi.tipZadachiCaption),
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

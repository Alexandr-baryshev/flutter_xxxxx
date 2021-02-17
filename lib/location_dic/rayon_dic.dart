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




  _setChange(Rayon newValue) {
    setState(() {
      currentValue = newValue;
    });

    //LocationDicData.funcTypeSelector(_setChangeAsFilter, _setChangeAsInput);

  }



  @override
  Widget build(BuildContext context) {
    Logger.events(class_: '${context.widget}', func: 'Widget build', data: '');


    String bySubyektID = context.select((LocationState ls) => ls.bySubyektID);

    return FutureBuilder(
        future: LocationDicData.filterRayons(id: bySubyektID),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {

            //LocationDicData.funcTypeSelector(_loadAsFilter, _loadAsInput);

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

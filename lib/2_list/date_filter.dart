import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utility/logger.dart';
import '../utility/constant.dart';
import '../utility/time_convert.dart';
import 'list_func.dart';

import '../utility//style.dart';




class DateFilter extends StatefulWidget {
  @override
  _DateFilterState createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {

  int start = 0;
  int end = 9999999999999;

  DateTime initStart = DateTime.now();
  DateTime initEnd = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Logger.events(widget: '${context.widget}', func: 'Widget build', event: '');

    clearDateFilter() {
      setState(() {
        start = 0;
        end = 9999999999999;
        ConstructorURI.setRequestFilter(start: start, end: end);
        context.read<ListTableState>().listTableUpdate();
      });
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 50,
      //color: Colors.amberAccent,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(

              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                decoration: dicBoxDecor(),
                alignment: Alignment.center,
                child: FlatButton(
                  height: 70,
                  padding: EdgeInsets.zero,
                  child: Text(start == 0 ? 'Дата начала' : time(start, 'd.M.yyyy'),
                      style: TextStyle(color: Colors.brown, fontSize: 16)),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: initStart,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2040))
                        .then((date) {
                      setState(() {
                        if (date != null) {
                          initStart = date;
                          start = date.millisecondsSinceEpoch;
                          ConstructorURI.setRequestFilter(start: start);
                          context.read<ListTableState>().listTableUpdate();
                        }
                      });
                    });
                  },
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                decoration: dicBoxDecor(),
                alignment: Alignment.center,
                child: FlatButton(
                  height: 70,
                  padding: EdgeInsets.zero,
                  child: Text(end == 9999999999999 ? 'Дата окончания' : time(end, 'd.M.yyyy'),
                      style: TextStyle(color: Colors.brown, fontSize: 16)),
                  onPressed: () {
                    showDatePicker(
                        context: context,
                        initialDate: initEnd,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2040))
                        .then((date) {
                      setState(() {
                        if (date != null) {
                          initEnd = date;
                          end = date.millisecondsSinceEpoch;
                          ConstructorURI.setRequestFilter(end: end);
                          context.read<ListTableState>().listTableUpdate();
                        }
                      });
                    });
                  },
                ),
              ),
            ),


            IconButton(
              iconSize: 40,
              icon: Icon(
                Icons.clear,
                color: Colors.brown,
              ),
              onPressed: clearDateFilter,
            ),

          ]),
    );
  }
}

import 'package:flutter/material.dart';


import '../model/key_controller.dart';
import '../utility/style.dart';
import '../utility/logger.dart';

class TopBar extends StatelessWidget {
  final String _reportNAME;
  final String _rout;
  final String _userFIO;

  TopBar(this._reportNAME, this._rout, this._userFIO);

  @override
  Widget build(BuildContext context) {
    Logger.events(class_: '${context.widget}', func: 'build', data: _reportNAME);

    return Container(
        padding: EdgeInsets.only(left: 10, right: 20),
        height: 80,
        color: barBgColor,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () => Navigator.pushNamed(context, _rout),
                //onPressed: () => PageRout.goToPage(context, _rout),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.keyboard_return,
                      color: barIconColor,
                      size: 35,
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  //color: Colors.green,
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _reportNAME,
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ), // NAME
              ),
              Flexible(
                flex: 1,
                child: Container(
                  //color: Colors.redAccent,
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  alignment: Alignment.centerRight,
                  child: Text(
                    _userFIO,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ), // NAME
              ),
            ]));
  }
}



class BottomBar extends StatelessWidget {
  final List<FlatButton> _buttonsList;

  BottomBar(this._buttonsList);

  @override
  Widget build(BuildContext context) {
    Logger.events(class_: '${context.widget}', func: 'build', data: '');

    return Container(
        padding: EdgeInsets.only(left: 10, right: 20),
        height: 80,
        color: barBgColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buttonsList
        ));
  }
}

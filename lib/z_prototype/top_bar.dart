import 'package:flutter/material.dart';
import 'package:reports_flutter/utility/key_controller.dart';
import 'package:reports_flutter/utility/style.dart';
import '../utility/logger.dart';
import 'buttons.dart';


class TopBar extends StatelessWidget {
  final String _reportNAME;
  final String _rout;


  TopBar(this._reportNAME, this._rout);

  @override
  Widget build(BuildContext context) {
    Logger.events(widget: '${context.widget}', func: 'build', event: _reportNAME);

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
                child: Container(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _reportNAME,
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ), // NAME
              ),
            ]));
  }
}

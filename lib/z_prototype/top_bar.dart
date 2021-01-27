import 'package:flutter/material.dart';
import 'package:reports_flutter/utility/constant.dart';
import 'package:reports_flutter/utility/style.dart';
import 'buttons.dart';

class TopBar extends StatelessWidget {
  final String _reportNAME;
  final String _rout;

  TopBar(this._reportNAME, this._rout);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 20),
        height: 80,
        color: barBgColor,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              barsIconFlatBtn(context: context, icon: Icons.keyboard_return, rout: _rout),
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

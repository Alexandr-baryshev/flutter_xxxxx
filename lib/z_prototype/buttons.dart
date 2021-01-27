import 'package:reports_flutter/utility/style.dart';
import 'package:flutter/material.dart';



FlatButton barsIconFlatBtn({BuildContext context, IconData icon, String rout }) {
  return FlatButton(
    onPressed: () =>  Navigator.pushNamed(context, rout),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: barIconColor,
          size: 35,
        )
      ],
    ),
  );
}





FlatButton barsIconTxtFlatBtn({String text, IconData icon, Function fun}) {
  return FlatButton(
    onPressed: fun,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: barIconColor,
          size: 35,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}
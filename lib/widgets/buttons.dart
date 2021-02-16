import 'package:flutter/material.dart';
import '../utility/style.dart';

TextButton barsIconFlatBtn({BuildContext context, IconData icon, String rout}) {
  return TextButton(
    onPressed: () => Navigator.pushNamed(context, rout),
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

TextButton bottomBarButton({ String text, IconData icon, Function fun}) {
  return TextButton(
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
          style:
              TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

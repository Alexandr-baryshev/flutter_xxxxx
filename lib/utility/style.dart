import 'package:flutter/material.dart';

InputDecoration bigInputDecoration(text, size) {
  return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      labelText: text,
      alignLabelWithHint: true,
      labelStyle: TextStyle(color: Colors.blueGrey, fontSize: size),
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))));
}

BoxDecoration dicBoxDecor() {
  return BoxDecoration(
      color: Color.fromARGB(255, 250, 250, 250), borderRadius: BorderRadius.circular(5));
}

BoxDecoration widgetContainerDecor() {
  return BoxDecoration(
      color: Color.fromARGB(255, 250, 250, 250), borderRadius: BorderRadius.circular(10), );
}



TextStyle dropDownStyle() {
  return TextStyle(
      color: Color.fromARGB(255, 51, 100, 135), fontSize: 14, fontWeight: FontWeight.w500);
}

TextStyle dataColumnStyle() {
  return TextStyle(
      color: Color.fromARGB(255, 30, 70, 100),
      fontSize: 14,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500);
}

const Color barBgColor = Color.fromARGB(255, 65, 80, 105);
const Color barIconColor = Color.fromARGB(255, 255, 255, 255);

const Color mainBgColor = Color.fromARGB(255, 230, 230, 230);
const Color mainTextColor = Color(0xFFF7F7F7);



Widget getScreenSize (BuildContext context, Widget vertical, Widget horizontal) {
  var screenWidth = MediaQuery.of(context).size.width;
  int smallWidth = 600;
  //int bigWidth = 1000;

  return screenWidth < smallWidth ?   vertical : horizontal;

}
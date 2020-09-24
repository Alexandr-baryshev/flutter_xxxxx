import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'web.dart';


import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';



void main() => runApp(MyApp());


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        body: Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {


  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  String dropdownValue = 'One';

  var countries= [
    {"countryId":"9b259d48-3eb6-46c5-83fa-cd1516da294c","countryName":"Россия"},
    {"countryId":"bedcda67-712f-442a-8b85-8d488973361f","countryName":"США"}
    ];


  Future<List> fetchCountry() async {
    final response = await http.get('http://localhost:8888/Country');
    countries = jsonDecode(utf8.decode(response.bodyBytes));
    print(countries);
    return countries;
  }

  @override
  Widget build(BuildContext context) {



    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}







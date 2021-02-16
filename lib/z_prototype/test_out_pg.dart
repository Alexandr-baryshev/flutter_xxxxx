import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../utility/style.dart';

class TestOutPg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      body: Column(
        children: [
          Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                ' TEST PAGE ',
                style: TextStyle(
                  color: barBgColor,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              )),
          FutureBuilder(
        future: getUserDetail(),
          builder: (context, snapshot) {
            return
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                children: [
                  Text('='),
                ],
              ),
            );

          }),
          FlatButton(onPressed: getUserDetail, child: Text('Запрос'))
        ],
      ),
    );
  }
}



getUserDetail() async {

  final response = await http.get('http://localhost:9999/GetName' as Uri);
  String responseBody = utf8.decode(response.bodyBytes);

  var parsed = jsonDecode(responseBody);

  print(parsed[1]);
}
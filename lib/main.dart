import 'package:flutter/material.dart';
import 'web.dart';
import 'parsing.dart';

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
    return ChangeNotifierProvider<Tessst>(
    create: (context) => Tessst(),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          Expanded(child: TextField(
            onChanged: (val) {

              context.read<Tessst>().setN(x: val);

            },
          )),
          Expanded(
            child: FutureBuilder<List<Report>>(
              future:context.watch<Tessst>().fetchReports(/*http.Client()*/),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? ReportsList(reports: snapshot.data)
                    : Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}










class ReportsList extends StatelessWidget {
  final List<Report> reports;


  ReportsList({this.reports});

  @override
  Widget build(BuildContext context) {



    return ListView.builder(

      itemCount: reports.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(reports[index].serialNumber),
          title: Text(reports[index].opisanieText),
          subtitle:  Text(reports[index].id),
          dense: true,
          onTap: () {
              print(reports[index].id);
              // на страницу ввода, передается id и данный грузятся по ...GetById
              // osnovanieText - сделать проверку на null
          },
        );
      },
    );
  }
}

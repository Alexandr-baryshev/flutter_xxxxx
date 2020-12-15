import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list.dart';

class HomePageTest extends StatelessWidget {
  static String rout = 'HomePageTest';


  @override
  Widget build(BuildContext context) {



    return Scaffold(

      body: Column(
        children: [
          Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                ' NEXT ',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text('Перейти'),
                  onTap: () {
                     Navigator.pushNamed(context, ListPageLayout.rout);
                  },
                ),



              ],
            ),
          )
        ],
      ),
    );
  }


}

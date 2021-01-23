import 'package:flutter/material.dart';



class HomePageLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String funcName = 'Widget build';
    //logger.events(widget: '${context.widget}', func: funcName, event: '');





    return Scaffold(
      //backgroundColor: mainBgColor,
      body: Column(
        children: [
          Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                ' NEXT ',
                style: TextStyle(
                  //color: barBgColor,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              children: [
/*                buildCard(context,ppoName,  setPpo),
                buildCard(context,profRabName, setProfRab),
                buildCard(context,incidentName, setIncident),
                buildCard(context,teh112Name, setTeh112),
                buildCard(context,activZadachiName, setActivZadachi),*/


              ],
            ),
          )
        ],
      ),
    );
  }

  Card buildCard(BuildContext context, String name, Function setCollect) {

    return Card(
                color: Colors.transparent,
                elevation: 0,
                shape: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(name),
                  onTap: () {
                    setCollect();


                  },
                ),
              );
  }
}

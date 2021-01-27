

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../model/report.dart';
import '../utility/logger.dart';
import '../utility/constant.dart';
import '../utility/style.dart';
import '../utility/time_convert.dart';
import 'list_func.dart';



// TODO сохранить id в локал стораж


class ListTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Logger.events(widget: '${context.widget}', func: 'Widget build');

    int xUp = context.watch<ListTableState>().xUp;

    return Expanded(
      child: FutureBuilder<List<Report>>(
        future: fetchReports(),
        builder: (context, snapshot) {


          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.connectionState == ConnectionState.done) {
            return ListTableBody(reports: snapshot.data);
          } 
          else   {
            return Center(child: Text('Нет данных'));
          }


        },
      ),
    );
  }
}

/// Текстовые Поля ввода
class ListTableBody extends StatefulWidget {
  final List<Report> reports;

  ListTableBody({this.reports});

  @override
  _ListTableBodyState createState() => _ListTableBodyState();
}

class _ListTableBodyState extends State<ListTableBody> {
  bool sort = true;

  onSortNumber(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        widget.reports.sort((a, b) => a.serialNumber.compareTo(b.serialNumber));
      } else {
        widget.reports.sort((a, b) => b.serialNumber.compareTo(a.serialNumber));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    Logger.events(widget: '${context.widget}', func: 'Widget build');

    return Container(
      decoration: widgetContainerDecor(),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ListView(
          children: [
        DataTable(
          sortColumnIndex: 0,
          sortAscending: sort,
          showCheckboxColumn: false,
          columns: <DataColumn>[
            DataColumn(

              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSortNumber(columnIndex, ascending);
              },
              label: Text('№', style: dataColumnStyle()),
            ),
            DataColumn(
              // onSort: (columnIndex, ascending) {
              //   setState(() {
              //     sort = !sort;
              //   });
              //   onSortDate(columnIndex, ascending);
              // },
              label: Text('Дата', style: dataColumnStyle()),
            ),
            //DataColumn(label: Text('Субъект', style: dataColumnStyle())),
            DataColumn(label: Text('Район', style: dataColumnStyle())),
            DataColumn(label: Text('Служба', style: dataColumnStyle())),
          ],
          rows: widget.reports
              .map((data) => DataRow(
                      onSelectChanged: (bool selected) {
                        oneReport.id = data.id;
                        Navigator.pushNamed(context,  PageRout.VOID);
                      },
                      cells: [
                        DataCell(
                          Text(data.serialNumber),
                        ),
                        DataCell(
                          Text('${time(data.completedDate, 'dd.M.yyyy  H:mm')}')
                        ),
                        //DataCell( Text(data.countryID == null ? '-' : data.countryID)),
                        DataCell(
                          Text(data.rayonID == null ? '-' : data.rayonID),
                        ),
                        DataCell(
                          Text(data.sluzhbaID == null ? '-' : data.sluzhbaID),
                        ),
                      ]))
              .toList(),
        ),
      ]),
    );
  }
}






// ignore: must_be_immutable
class ListFUTURE extends StatelessWidget {
  int qLocal = 0;


  @override
  Widget build(BuildContext context) {
    Logger.events(widget: '${context.widget}', func: 'Widget build');


    print('>>>>>> qLocal  ${qLocal += 1}');
    print('>>>>> qGlobal  ${qGlobal += 1}');

    //int xUp = context.watch<ListTableState>().xUp;
    return Expanded(
      child: FutureBuilder<List<Report>>(
        future: fetchReports(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          else if (snapshot.connectionState == ConnectionState.done) {


            return Container(
                decoration: widgetContainerDecor(),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ListView(
                  children: [
                    FlatButton(
                      child: Text(snapshot.data[1].rayonID == null ? '-' : snapshot.data[1].rayonID),
                      onPressed: () {
                        oneReport.id = snapshot.data[1].id;
                        Navigator.pushNamed(context,  PageRout.VOID);
                      },
                    ),
                  ],
                ));
          }
          else   {
            return Center(child: Text('Нет данных'));
          }


        },
      ),
    );


  }
}


int qGlobal = 0;
// ignore: must_be_immutable
class ListNOuture extends StatelessWidget {
  int qLocal = 0;

  @override

  Widget build(BuildContext context) {
    Logger.events(widget: '${context.widget}', func: 'Widget build');





    print('>>>>>> qLocal  ${qLocal += 1}');
    //print('>>>>> qGlobal  ${qGlobal += 1}');
    //print('====== select  ${context.select(( ListTableState value) => value.xUp) }');
    return
      Expanded(child: Center(child:
      Text("${context.select(( ListTableState value) => value.xUp) == null? '' : context.select(( ListTableState value) => value.xUp)}")));



  }
}






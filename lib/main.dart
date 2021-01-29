import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/key_controller.dart';
import '1_home/home_pg_layout.dart';
import '2_list/list_page_layout.dart';
import '2_list/list_data.dart';
import 'location_dic/location_dic_data.dart';

void main() => runApp(ReportsMain());

class ReportsMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('\n--------------------------------------------------------------------\n'
        '   >>> >>> START APPLICATION !!!!!!!!!! START APPLICATION <<< <<<   \n'
        '--------------------------------------------------------------------');
    // Logger.loggerOnOff = true;
    // Logger.events(widget: '${context.widget}', func: funcName, event: '');

    // TODO тут разобраться
    PageRout.currentRout == null
        ? PageRout.getCurrentRout()
        : PageRout.currentRout = PageRout.HOME;

    Future.delayed(Duration(milliseconds: 500));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListTableState>(create: (context) => ListTableState()),
        ChangeNotifierProvider<SubyektState>(create: (context) => SubyektState()),
        ChangeNotifierProvider<RayonState>(create: (context) => RayonState()),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        initialRoute: PageRout.currentRout,
        routes: {
          PageRout.HOME: (context) => HomePgLayout(),
          PageRout.LIST: (context) => ListPgLayout(),
          PageRout.VOID: (context) => VoidMainCLASS(),
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute<void>(
              settings: settings,
              builder: (BuildContext context) {
                return Scaffold(
                  body: Center(
                    child: Text('НЕИЗВЕСТНАЯ ОШИБКА'),
                  ),
                );
              });
        },
      ),
    );
  }
}

class VoidMainCLASS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ReportKEY.getReportID(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              height: 100,
              color: Colors.green,
              child: Text('byIdURI ${ConstructorURI.byIdURI}'),
            );
          } else {
            return Center(child: Text('Нет данных'));
          }
        });
  }
}

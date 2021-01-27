import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utility/constant.dart';
import '1_home/home_pg_layout.dart';
import '2_list/list_page_layout.dart';
import '2_list/list_func.dart';

void main() => runApp(ReportsMain());

class ReportsMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    print('\n--------------------------------------------------------------------\n'
        '   >>> >>> START APPLICATION !!!!!!!!!! START APPLICATION <<< <<<   \n'
        '--------------------------------------------------------------------');
    // Logger.loggerOnOff = true;
    // Logger.events(widget: '${context.widget}', func: funcName, event: '');

    return MultiProvider(
      providers: [
         ChangeNotifierProvider<ListTableState>(create: (context) => ListTableState()),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        initialRoute: PageRout.HOME,
        routes: {
           PageRout.HOME: (context) => HomePgLayout(),
           PageRout.LIST: (context) => ListPaLayout(),
           //PageRout.VOID: (context) => VoidMainCLASS(),
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
    return Container(
      height: 100,
      color: Colors.green,
    );
  }
}
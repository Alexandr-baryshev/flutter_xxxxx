
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';






void main() => runApp(ReportsMain());

class ReportsMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String funcName = 'Widget build';

    print(
        '\n--------------------------------------------------------------------\n'
        '   >>> >>> START APPLICATION !!!!!!!!!! START APPLICATION <<< <<<   \n'
        '--------------------------------------------------------------------');
    // Logger.loggerOnOff = true;
    // Logger.events(widget: '${context.widget}', func: funcName, event: '');




    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<ListTableState>(create: (context) => ListTableState()),

      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        //initialRoute: RoutNameStorage.home,
        routes: {

          // RoutNameStorage.home: (context) => HomePageLayout(),


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

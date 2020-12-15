
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list.dart';
import 'home.dart';



void main() => runApp(ReportsMain());

class ReportsMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    print(
        '\n--------------------------------------------------------------------\n'
            '   >>> >>> START APPLICATION !!!!!!!!!! START APPLICATION <<< <<<   \n'
            '--------------------------------------------------------------------');



    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListState>(create: (context) => ListState()),

      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        initialRoute: HomePageTest.rout,
        routes: {

          HomePageTest.rout: (context) => HomePageTest(),
          ListPageLayout.rout: (context) => ListPageLayout(),


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

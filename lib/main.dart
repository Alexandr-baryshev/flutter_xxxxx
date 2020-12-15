import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list.dart';


void main() => runApp(ReportsMain());

class ReportsMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('\n--------------------------------------------------------------------\n'
        '   >>> >>> START APPLICATION !!!!!!!!!! START APPLICATION <<< <<<   \n'
        '--------------------------------------------------------------------');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TextWidgetState>(create: (context) => TextWidgetState()),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        initialRoute: Home.rout,
        routes: {
          Home.rout: (context) => Home(),
          ListPage.rout: (context) => ListPage(),
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  static String rout = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListTile(
          title: Text('GO NEXT'),
          onTap: () {
            Navigator.pushNamed(context, ListPage.rout);
          },
        ),
      ),
    );
  }
}

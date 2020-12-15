import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';


class ListPageLayout extends StatelessWidget {
  static String rout = 'ListPage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
          ListTop(),
        List(),

        ],
      ),
    ),);

  }
}
// №№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№
/// ▼ ▼ ▼ ▼ ▼ КАКАЯ-ТО ХУЕТА ↓ ↓ ↓ ↓ ↓ ↓


class ListState extends ChangeNotifier {
  int xUp = 0;

  listTableUpdate() {
    xUp += 1;
    notifyListeners();
  }
}


int qGlobal = 0;
// ignore: must_be_immutable
class List extends StatelessWidget {
  int qLocal = 0;

  @override
  Widget build(BuildContext context) {
    print('>>>>>> qLocal  ${qLocal += 1}');

    return
      Expanded(child: Center(child:
          Text("${context.select((ListState value) => value.xUp) == null ? '' : context.select((
          ListState value) => value.xUp)}")));
  }
}


class ListTop extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 20),
      height: 80,

      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            child: FlatButton(
              height: 80,
              padding: EdgeInsets.zero,
              child: Icon(
                Icons.keyboard_return,
              ),
              onPressed: () {
                Navigator.pushNamed(context, HomePageTest.rout);
              },
            ),
          ), // Назад
          Container(
            width: 50,
            child: FlatButton(
              height: 80,
              padding: EdgeInsets.zero,
              child: Icon(
                Icons.update,
              ),
              onPressed: () {
                context.read<ListState>().listTableUpdate();
              },
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(bottom: 5, top: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                'name',
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ), // NAME
          ),
        ],
      ),
    );
  }
}


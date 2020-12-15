import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class ListPage extends StatelessWidget {
  static String rout = 'ListPage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: Icon(
                        Icons.keyboard_return,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Home.rout);
                      },
                    ), // Назад
                    FlatButton(
                      child: Icon(
                        Icons.update,
                      ),
                      onPressed: () {
                        context.read<TextWidgetState>().textNumberCount();
                      },
                    ),
                    TextWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextWidgetState extends ChangeNotifier {
  int textNumber = 0;

  textNumberCount() {
    textNumber += 1;
    notifyListeners();
  }
}


class TextWidget extends StatelessWidget {
  int test = 0;

  @override
  Widget build(BuildContext context) {

    print('>>>>>> test  ${test += 1}');

    return Text(
        "${context.watch<TextWidgetState>().textNumber == null ? '' : context.watch<TextWidgetState>().textNumber}");
  }
}

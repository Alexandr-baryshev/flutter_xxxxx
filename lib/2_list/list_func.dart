import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTableState extends ChangeNotifier {
  int xUp = 0;

  listTableUpdate() {
    xUp += 1 ;
    notifyListeners();
  }
}
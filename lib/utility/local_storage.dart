import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  save({@required String key, @required String value}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString(key, value);
  }

  load({@required String key, Function setFromLocal}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    setFromLocal(storage.getString(key));
  }

  remove({@required String key}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.remove(key);
  }
}

LocalStorage localStorage = new LocalStorage();






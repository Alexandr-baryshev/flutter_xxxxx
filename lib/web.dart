import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';

List<dynamic> jsonObject;

class Web {

  jsonObjectGET() async {
    try {
      var response = await http.get(k_GetUrl);
      jsonObject = jsonDecode(utf8.decode(response.bodyBytes));
      // Чтобы получить jsonObject, метод извлечение разместить ниже.

      nextFun();
    } catch (e) {
      print(e);
    }
  }


  nextFun() {
    print('\nX $jsonObject');
  }


  // Способ получения данных из static переменной другого класса
  xxx() async {
    await Web().jsonObjectGET();
    print(jsonObject);
    // Далее вызвать эту же функцию ниже.
  }
}


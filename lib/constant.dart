import 'package:flutter/material.dart';

// База данных
const String k_Name = 'Отчет об обновлении ППО Системы.';
const String k_GetUrl = 'http://localhost:8888/ppoGet';
const String k_PostUrl = 'http://localhost:8888/ppoPost';

const String k_profRabName = 'Отчет о выполненных профилактических работах.';
const String k_profRabGetUrl = 'http://localhost:8888/profRabGet';
const String k_profRabPostUrl = 'http://localhost:8888/profRabPost';

const String k_incidentName = 'Отчет о предупреждении инцидентов.';
const String k_incidentGetUrl = 'http://localhost:8888/incidentGet';
const String k_incidentPostUrl = 'http://localhost:8888/incidentPost';

// Цвета
const Color k_testBg1 = Color(0xFFF7F7F7);
const Color k_testBg2 = Color(0xFFDEE5D4);
const Color k_testBg3 = Color(0xFFD4D6E5);

// Стили
const k_TextFieldInputDecoration = InputDecoration(
    hintText: 'поиск',
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.all(5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    )
);

const k_TextFieldTextStyle  = TextStyle(color: Colors.black);
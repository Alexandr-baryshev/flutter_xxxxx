var query = [
  {'id': 001, 'smena': 'СМЕНА 1', 'fio': 'Фамилия'},
  {'id': 002, 'smena': 'СМЕНА 1', 'fio': 'Фамилия с1'},
  {'id': 003, 'smena': 'СМЕНА 1', 'fio': null},
  {'id': 001, 'smena': 'СМЕНА 2', 'fio': 'Фамилия'},
  {'id': 002, 'smena': 'СМЕНА 2', 'fio': 'Фамилия с2'},
  {'id': 003, 'smena': 'СМЕНА 2', 'fio': null},
  {'id': 001, 'smena': 'СМЕНА 3', 'fio': 'Фамилия'},
  {'id': 002, 'smena': 'СМЕНА 3', 'fio': 'Фамилия с3'},
  {'id': 003, 'smena': 'СМЕНА 3', 'fio': null},
];


List<String> list = [];
String currentElement = '';

void f (){


  for (var element in query) {

    element['smena'];
  }

}






void main() {

  query.forEach((element) {

    print(element['smena']);

  });

}

class Subyekt {
  String subyektId;
  String subyektName;

  Subyekt({
    this.subyektId,
    this.subyektName,
  });

  factory Subyekt.fromJson(Map<String, dynamic> json) {
    return Subyekt(
      subyektId: json['subyektId'] as String,
      subyektName: json['subyektName'] as String,
    );
  }
}

class Rayon {
  String rayonId;
  String rayonName;
  String subyektId;

  Rayon({
    this.rayonId,
    this.rayonName,
    this.subyektId,
  });

  factory Rayon.fromJson(Map<String, dynamic> json) {
    return Rayon(
      rayonId: json['rayonId'] as String,
      rayonName: json['rayonName'] as String,
      subyektId: json['subyektId'] as String,
    );
  }
}

class Sluzhba {
  String sluzhbaId;
  String sluzhbaName;
  String deleteId;

  Sluzhba({
    this.sluzhbaId,
    this.sluzhbaName,
    this.deleteId,
  });

  factory Sluzhba.fromJson(Map<String, dynamic> json) {
    return Sluzhba(
      sluzhbaId: json['sluzhbaId'] as String,
      sluzhbaName: json['sluzhbaName'] as String,
      deleteId: json['deleteId'] as String,
    );
  }
}

List<Subyekt> subyektALL = [];
List<Subyekt> subyektFILTER = [];


List<Rayon> rayonsALL = [];
List<Rayon> rayonsFILTER = [];

List<Sluzhba> sluzhbaALL = [];




class ActiveComplete {
  String id;
  String teh112id;
  String activeTypeID;
  String activeDescription;
  int completedDate;

  ActiveComplete({
    this.id,
    this.activeTypeID,
    this.activeDescription,
    this.teh112id,
    this.completedDate,
  });

  factory ActiveComplete.fromJson(Map<String, dynamic> json) {
    return ActiveComplete(
      id: json['id'] as String,
      teh112id: json['teh112id'] as String,
      activeTypeID: json['activeTypeID'] as String,
      activeDescription: json['activeDescription'] as String,
      completedDate: json['completedDate'] as int,
    );
  }
}

ActiveComplete activeComplete = new ActiveComplete();
List<ActiveComplete> activeCompleteList = [];




class Report {
  String id;

  String serialNumber;

  String osnovanieRabot;
  String opisanieRabot;
  String opisanieZadachi;
  String resultat;

  String activeTypeID;
  String activeDescription;

  String reserveField1;

  int activeSign;

  String subyektID;
  String rayonID;
  String sluzhbaID;

  int completedDate;

  Report({
    this.id,
    this.serialNumber,
    this.osnovanieRabot,
    this.opisanieRabot,
    this.opisanieZadachi,
    this.resultat,
    this.activeTypeID,
    this.activeDescription,
    this.reserveField1,
    this.activeSign,
    this.subyektID,
    this.rayonID,
    this.sluzhbaID,
    this.completedDate,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as String,
      serialNumber: json['serialNumber'] as String,
      osnovanieRabot: json['osnovanieRabot'] as String,
      opisanieRabot: json['opisanieRabot'] as String,
      opisanieZadachi: json['opisanieZadachi'] as String,
      resultat: json['resultat'] as String,
      activeTypeID: json['activeTypeID'] as String,
      activeDescription: json['activeDescription'] as String,
      reserveField1: json['reserveField1'] as String,
      activeSign: json['activeSign'] as int,
      subyektID: json['subyektID'] as String,
      rayonID: json['rayonID'] as String,
      sluzhbaID: json['sluzhbaID'] as String,
      completedDate: json['completedDate'] as int,
    );
  }

  clear() {
    id = null;
    serialNumber = null;
    osnovanieRabot = null;
    opisanieRabot = null;
    opisanieZadachi = null;
    resultat = null;
    activeTypeID = null;
    activeDescription = null;
    reserveField1 = null;
    activeSign = null;
    subyektID = null;
    rayonID = null;
    sluzhbaID = null;
    completedDate = null;
  }
}

Report oneReport = new Report();

List<Report> allReports = [];

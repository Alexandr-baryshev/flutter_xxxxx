class OpisanieTipaList {
  String tipZadachiID;

  String opisanieTipa;


  OpisanieTipaList({
   this.tipZadachiID,
   this.opisanieTipa,
});

}



List<OpisanieTipaList> opisanieTipaList = [];



class Report {
   String id;

   String serialNumber;

   String osnovanieRabot;
   String opisanieRabot;
   String opisanieZadachi;
   String resultat;

   String tipZadachiID;
   String opisanieTipa;

   String opisanieTipaList;

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

    this.tipZadachiID,
    this.opisanieTipa,

    this.opisanieTipaList,

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

      tipZadachiID: json['tipZadachiID'] as String,
      opisanieTipa: json['opisanieTipa'] as String,

      opisanieTipaList: json['opisanieTipaList'] as String,

      activeSign: json['activeSign'] as int,

      subyektID: json['subyektID'] as String,
      rayonID: json['rayonID'] as String,
      sluzhbaID: json['sluzhbaID'] as String,

      completedDate: json['completedDate'] as int,
    );
  }
}



Report oneReport = new Report();

List<Report> allReports = [];

oneReportCLEAR()  {

  oneReport.id  = null;
  oneReport.serialNumber  = null;
  oneReport.osnovanieRabot  = null;
  oneReport.opisanieRabot  = null;
  oneReport.opisanieZadachi  = null;
  oneReport.resultat  = null;
  oneReport.tipZadachiID  = null;
  oneReport.opisanieTipa  = null;
  oneReport.opisanieTipaList = null;
  oneReport.activeSign  = null;
  oneReport.subyektID  = null;
  oneReport.rayonID  = null;
  oneReport.sluzhbaID  = null;
  oneReport.completedDate  = null;
}
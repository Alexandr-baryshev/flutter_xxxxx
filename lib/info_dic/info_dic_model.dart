class TipZadachi {
  String tipZadachiId;
  String tipZadachiText;

  TipZadachi({
    this.tipZadachiId,
    this.tipZadachiText,
  });

  factory TipZadachi.fromJson(Map<String, dynamic> json) {
    return TipZadachi(
      tipZadachiId: json['tipZadachiId'] as String,
      tipZadachiText: json['tipZadachiText'] as String,
    );
  }
}

List<TipZadachi> tipZadachiList = [];
class TipZadachi {
  String tipZadachiId;
  String tipZadachiCaption;

  TipZadachi({
    this.tipZadachiId,
    this.tipZadachiCaption,
  });

  factory TipZadachi.fromJson(Map<String, dynamic> json) {
    return TipZadachi(
      tipZadachiId: json['tipZadachiId'] as String,
      tipZadachiCaption: json['tipZadachiCaption'] as String,
    );
  }
}

List<TipZadachi> tipZadachiList = [];
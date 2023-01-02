class AlarmInfo {
  AlarmInfo({
    this.id,
    this.title,
    required this.alarmDateTime,
    this.isPending,
    required this.gradientColorIndex,
  });

  int? id;
  String? title;
  DateTime alarmDateTime;
  bool? isPending;
  int gradientColorIndex;

  factory AlarmInfo.fromJson(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending: json["isPending"],
        gradientColorIndex: json["gradientColorIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
      };
}

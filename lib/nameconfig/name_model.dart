class NamesModelnew {
  int? nameTypeId;
  String? nameDescription;
  List<dynamic>? userName;

  NamesModelnew({
    this.nameTypeId,
    this.nameDescription,
    this.userName,
  });

  factory NamesModelnew.fromJson(Map<String, dynamic> json) => NamesModelnew(
        nameTypeId: json["nameTypeId"],
        nameDescription: json["nameDescription"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        'nameTypeId': nameTypeId,
        'nameDescription': nameDescription,
        'userName': userName,
      };
}

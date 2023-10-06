import 'dart:convert';

NamesModel namesModelFromJson(String str) =>
    NamesModel.fromJson(json.decode(str));

String namesModelToJson(NamesModel data) => json.encode(data.toJson());

class NamesModel {
  int? code;
  String? message;
  List<Datum>? data;

  NamesModel({
    this.code,
    this.message,
    this.data,
  });

  factory NamesModel.fromJson(Map<String, dynamic> json) => NamesModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? nameTypeId;
  String? nameDescription;
  List<String>? userName;

  Datum({
    this.nameTypeId,
    this.nameDescription,
    this.userName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        nameTypeId: json["nameTypeId"],
        nameDescription: json["nameDescription"],
        userName: json["userName"] == null
            ? []
            : List<String>.from(json["userName"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "nameTypeId": nameTypeId,
        "nameDescription": nameDescription,
        "userName":
            userName == null ? [] : List<dynamic>.from(userName!.map((x) => x)),
      };
}

class UserNameDatum {
  String? id;
  String? location;
  String? name;

  UserNameDatum({
    this.id,
    this.location,
    this.name,
  });

  factory UserNameDatum.fromJson(Map<String, dynamic> json) => UserNameDatum(
        id: json["id"],
        location: json["location"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "name": name,
      };
}

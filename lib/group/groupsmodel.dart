// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

GroupModel groupModelFromJson(String str) =>
    GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());

class GroupModel {
  int? code;
  String? message;
  Data? data;

  GroupModel({
    this.code,
    this.message,
    this.data,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<Group>? group;
  List<Group>? line;

  Data({
    this.group,
    this.line,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        group: json["group"] == null
            ? []
            : List<Group>.from(json["group"]!.map((x) => Group.fromJson(x))),
        line: json["line"] == null
            ? []
            : List<Group>.from(json["line"]!.map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "group": group == null
            ? []
            : List<dynamic>.from(group!.map((x) => x.toJson())),
        "line": line == null
            ? []
            : List<dynamic>.from(line!.map((x) => x.toJson())),
      };
}

class Group {
  int? srno;
  int? id;
  String? name;
  String? location;
  List<String>? value;

  Group({
    this.srno,
    this.id,
    this.name,
    this.location,
    this.value,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        srno: json["srno"],
        id: json["id"],
        name: json["name"],
        location: json["location"],
        value: json["value"] == null
            ? []
            : List<String>.from(json["value"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "srno": srno,
        "id": id,
        "name": name,
        "location": location,
        "value": value == null ? [] : List<dynamic>.from(value!.map((x) => x)),
      };
}

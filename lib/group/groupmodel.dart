// To parse this JSON data, do
//
//     final groupModels = groupModelFromJson(jsonString);

import 'dart:convert';

GroupModels groupModelFromJson(String str) =>
    GroupModels.fromJson(json.decode(str));

String groupModelToJson(GroupModels data) => json.encode(data.toJson());

class GroupModels {
  List<Line>? line;
  List<Line>? group;

  GroupModels({
    this.line,
    this.group,
  });

  factory GroupModels.fromJson(Map<String, dynamic> json) => GroupModels(
        line: json["line"] == null
            ? []
            : List<Line>.from(json["line"]!.map((x) => Line.fromJson(x))),
        group: json["group"] == null
            ? []
            : List<Line>.from(json["line"]!.map((x) => Line.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "line": line == null
            ? []
            : List<dynamic>.from(line!.map((x) => x.toJson())),
        "group": group == null ? [] : List<dynamic>.from(group!.map((x) => x)),
      };
}

class Line {
  int? sNo;
  String? id;
  String? location;
  String? name;
  List<Line>? valve;

  Line({
    this.sNo,
    this.id,
    this.location,
    this.name,
    this.valve,
  });

  factory Line.fromJson(Map<String, dynamic> json) => Line(
        sNo: json["sNo"],
        id: json["id"],
        location: json["location"],
        name: json["name"],
        valve: json["valve"] == null
            ? []
            : List<Line>.from(json["valve"]!.map((x) => Line.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sNo": sNo,
        "id": id,
        "location": location,
        "name": name,
        "valve": valve == null
            ? []
            : List<dynamic>.from(valve!.map((x) => x.toJson())),
      };
}

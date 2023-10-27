// To parse this JSON data, do
//
//     final conditionModel = conditionModelFromJson(jsonString);

import 'dart:convert';

ConditionModel conditionModelFromJson(String str) => ConditionModel.fromJson(json.decode(str));

String conditionModelToJson(ConditionModel data) => json.encode(data.toJson());

class ConditionModel {
    int? code;
    String? message;
    Data? data;

    ConditionModel({
        this.code,
        this.message,
        this.data,
    });

    factory ConditionModel.fromJson(Map<String, dynamic> json) => ConditionModel(
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
    List<String>? dropdown;
    List<dynamic>? program;
    List<dynamic>? analogSensor;
    List<dynamic>? waterMeter;
    List<Contact>? contact;
    List<Condition>? condition;
    List<ConditionLibrary>? conditionLibrary;

    Data({
        this.dropdown,
        this.program,
        this.analogSensor,
        this.waterMeter,
        this.contact,
        this.condition,
        this.conditionLibrary,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        dropdown: json["dropdown"] == null ? [] : List<String>.from(json["dropdown"]!.map((x) => x)),
        program: json["program"] == null ? [] : List<dynamic>.from(json["program"]!.map((x) => x)),
        analogSensor: json["analogSensor"] == null ? [] : List<dynamic>.from(json["analogSensor"]!.map((x) => x)),
        waterMeter: json["waterMeter"] == null ? [] : List<dynamic>.from(json["waterMeter"]!.map((x) => x)),
        contact: json["contact"] == null ? [] : List<Contact>.from(json["contact"]!.map((x) => Contact.fromJson(x))),
        condition: json["condition"] == null ? [] : List<Condition>.from(json["condition"]!.map((x) => Condition.fromJson(x))),
        conditionLibrary: json["conditionLibrary"] == null ? [] : List<ConditionLibrary>.from(json["conditionLibrary"]!.map((x) => ConditionLibrary.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "dropdown": dropdown == null ? [] : List<dynamic>.from(dropdown!.map((x) => x)),
        "program": program == null ? [] : List<dynamic>.from(program!.map((x) => x)),
        "analogSensor": analogSensor == null ? [] : List<dynamic>.from(analogSensor!.map((x) => x)),
        "waterMeter": waterMeter == null ? [] : List<dynamic>.from(waterMeter!.map((x) => x)),
        "contact": contact == null ? [] : List<dynamic>.from(contact!.map((x) => x.toJson())),
        "condition": condition == null ? [] : List<dynamic>.from(condition!.map((x) => x.toJson())),
        "conditionLibrary": conditionLibrary == null ? [] : List<dynamic>.from(conditionLibrary!.map((x) => x.toJson())),
    };
}

class Condition {
    dynamic sNo;
    String? id;
    String? location;
    String? name;

    Condition({
        this.sNo,
        this.id,
        this.location,
        this.name,
    });

    factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        sNo: json["sNo"],
        id: json["id"],
        location: json["location"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "sNo": sNo,
        "id": id,
        "location": location,
        "name": name,
    };
}

class ConditionLibrary {
    dynamic sNo;
    String? id;
    String? location;
    String? name;
    bool? enable;
    String? state;
    String? duration;
    String? conditionIsTrueWhen;
    String? fromTime;
    String? untilTime;
    bool? notification;
    String? usedByProgram;

    ConditionLibrary({
        this.sNo,
        this.id,
        this.location,
        this.name,
        this.enable,
        this.state,
        this.duration,
        this.conditionIsTrueWhen,
        this.fromTime,
        this.untilTime,
        this.notification,
        this.usedByProgram,
    });

    factory ConditionLibrary.fromJson(Map<String, dynamic> json) => ConditionLibrary(
        sNo: json["sNo"],
        id: json["id"],
        location: json["location"],
        name: json["name"],
        enable: json["enable"],
        state: json["state"],
        duration: json["duration"],
        conditionIsTrueWhen: json["conditionIsTrueWhen"],
        fromTime: json["fromTime"],
        untilTime: json["untilTime"],
        notification: json["notification"],
        usedByProgram: json["usedByProgram"],
    );

    Map<String, dynamic> toJson() => {
        "sNo": sNo,
        "id": id,
        "location": location,
        "name": name,
        "enable": enable,
        "state": state,
        "duration": duration,
        "conditionIsTrueWhen": conditionIsTrueWhen,
        "fromTime": fromTime,
        "untilTime": untilTime,
        "notification": notification,
        "usedByProgram": usedByProgram,
    };
}

class Contact {
    int? sNo;
    String? id;
    String? location;
    String? name;

    Contact({
        this.sNo,
        this.id,
        this.location,
        this.name,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        sNo: json["sNo"],
        id: json["id"],
        location: json["location"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "sNo": sNo,
        "id": id,
        "location": location,
        "name": name,
    };
}

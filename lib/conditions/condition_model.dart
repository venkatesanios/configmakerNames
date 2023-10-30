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
    List<UserNames>? program;
    List<UserNames>? analogSensor;
    List<UserNames>? waterMeter;
    List<UserNames>? contact;
    List<UserNames>? condition;
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
        program: json["program"] == null ? [] : List<UserNames>.from(json["program"]!.map((x) => UserNames.fromJson(x))),
        analogSensor: json["analogSensor"] == null ? [] : List<UserNames>.from(json["analogSensor"]!.map((x) => UserNames.fromJson(x))),
        waterMeter: json["waterMeter"] == null ? [] : List<UserNames>.from(json["waterMeter"]!.map((x)=> UserNames.fromJson(x))),
        contact: json["contact"] == null ? [] : List<UserNames>.from(json["contact"]!.map((x) => UserNames.fromJson(x))),
        condition: json["condition"] == null ? [] : List<UserNames>.from(json["condition"]!.map((x) => UserNames.fromJson(x))),
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

class UserNames {
    dynamic sNo;
    String? id;
    String? location;
    String? name;

    UserNames({
        this.sNo,
        this.id,
        this.location,
        this.name,
    });

    factory UserNames.fromJson(Map<String, dynamic> json) => UserNames(
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
    String? program;
    String? zone;
    String? dropdown1;
    String? dropdown2;
    String? dropdownValue;


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
        this.program,
        this.zone,
        this.dropdown1,
        this.dropdown2,
        this.dropdownValue,

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
        program: json["program"],
        zone: json["zone"],
        dropdown1: json["dropdown1"],
        dropdown2: json["dropdown2"],
        dropdownValue: json["dropdownValue"],
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
        "program": usedByProgram,
        "zone": zone,
        "dropdown1": dropdown1,
        "dropdown2": dropdown2,
        "dropdownValue": dropdownValue,
    };
}
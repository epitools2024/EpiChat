import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:EpiChat/api/intra.dart';

class Plan {
  String scolarYear;
  String titleModule;
  String activity;
  String activityType;
  String nbrHours;
  String roomCode;
  bool isPast;
  bool isProject;
  bool isRdv;

  Plan(
      {this.scolarYear,
      this.titleModule,
      this.activity,
      this.activityType,
      this.isRdv,
      this.nbrHours,
      this.roomCode,
      this.isPast,
      this.isProject});

  factory Plan.fromJSON(Map<String, dynamic> json) {
    return Plan(
        scolarYear: json["scolaryear"],
        titleModule: json["titlemodule"],
        activity: json["acti_title"],
        activityType: json["type_title"],
        nbrHours: json["nb_hours"],
        roomCode: json["room"]["code"],
        isRdv: json["is_rdv"] == "0" ? false : true,
        isPast: json["past"],
        isProject: json["project"]);
  }
}

class PlanningManager {
  String login;

  PlanningManager({@required this.login});

  Future<List<Plan>> getPlanning() async {
    String dateFormatter(DateTime date) =>
        "${date.year}-${date.month}-${date.day}";
    var nowDate = new DateTime.now();
    var nowDateString = dateFormatter(nowDate);
    var inOneMonthDateString =
        dateFormatter(nowDate.add(new Duration(days: 20)));
    final response = await http.get(
        '$login/planning/load?format=json&start=$nowDateString&end=$inOneMonthDateString');
    List<Plan> plans = new List<Plan>();

    if (response.statusCode == 200) {
      var parsedResponse = jsonDecode(response.body);
      parsedResponse.forEach((plan) {
        plans.add(Plan.fromJSON(parsedResponse));
      });
      return plans;
    } else {
      throw Exception('Failed to load');
    }
  }
}

class Planning extends StatefulWidget {
  Planning({Key key}) : super(key: key);

  @override
  _PlanningState createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  var planning = new PlanningManager(
      login:
          "https://intra.epitech.eu/auth-c655ec4bd75eb07059acb3f36c9e2afb314b765b");

  @override
  Widget build(BuildContext context) {
    var plans = planning.getPlanning();

    return FutureBuilder(builder: null);
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';

enum endPoint {
  all,
  alert,
  message,
  notes,
  missed,
  nextRdv,
}

extension endPointExt on endPoint {
  static const names = {
    endPoint.all: '/?format=json',
    endPoint.alert: '/notification/alert?format=json',
    endPoint.message: '/notification/message?format=json',
    endPoint.notes: '/notes?format=json',
    endPoint.missed: '/notification/missed?format=json',
    endPoint.nextRdv: '/notification/coming?format=json',
  };

  String get value => names[this];
}

class Student {
  final String credits;
  final String gpa;
  final String year;
  final String name;
  final String cycle;
  final String studentyear;
  Student({
    this.name,
    this.credits,
    this.gpa,
    this.year,
    this.cycle,
    this.studentyear,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return (Student(
      name: json['title'].toString(),
      credits: json['credits'].toString(),
      gpa: json['gpa'][0]['gpa'].toString(),
      year: json['scolaryear'].toString(),
      cycle: json['gpa'][0]['cycle'].toString(),
      studentyear: json['studentyear'].toString(),
    ));
  }
}

Future<Student> getInfos(String login, String mail) async {
  endPoint point = endPoint.all;

  if (login != null && mail != null) {
    final response = await http.get('$login/user/$mail${point.value}');

    if (response.statusCode == 200) {
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load personal data');
    }
  } else {
    Student(gpa: '0', credits: '0', year: '0', cycle: 'bwachelor');
  }
}

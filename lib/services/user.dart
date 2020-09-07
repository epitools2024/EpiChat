import 'package:EpiChat/lib.dart' as lib;

class EpitechUser {
  final String credits;
  final String gpa;
  final String year;
  final String name;
  final String cycle;
  final String studentyear;
  final bool isAdmin;

  EpitechUser({
    this.name,
    this.credits,
    this.gpa,
    this.year,
    this.cycle,
    this.studentyear,
    this.isAdmin,
  });

  factory EpitechUser.fromJson(Map<String, dynamic> json) {
    return (EpitechUser(
      name: json['title'].toString(),
      credits: json['credits'].toString(),
      gpa: json['gpa'][0]['gpa'].toString(),
      year: json['scolaryear'].toString(),
      cycle: json['gpa'][0]['cycle'].toString(),
      studentyear: json['studentyear'].toString(),
      isAdmin: json['admin'],
    ));
  }
}

class MyUser {
  final String userName;
  final String email;
  final String bio;

  MyUser({
    this.userName,
    this.email,
    this.bio,
  });

  toJson() {
    Map<String, dynamic> json = {
      'username': this.userName,
      'email': this.email,
      'bio': this.bio,
    };
    return (json);
  }
}

import 'package:http/http.dart' as http;
import 'package:EpiChat/services/user.dart';
import 'dart:convert';

class EndPoint {
  static String all = '/?format=json';
  static String alert = '/notification/alert?format=json';
  static String message = '/notification/message?format=json';
  static String notes = '/notes?format=json';
  static String missed = '/notification/missed?format=json';
  static String nextRdv = '/notification/coming?format=json';
}

Future<EpitechUser> getInfos(String login, String mail) async {
  if (login != null && mail != null) {
    final response = await http.get('$login/user/$mail${EndPoint.all}');
    if (response.statusCode == 200) {
      return EpitechUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load personal data');
    }
  } else {
    EpitechUser(gpa: '0', credits: '0', year: '0', cycle: 'bachelor');
  }
}

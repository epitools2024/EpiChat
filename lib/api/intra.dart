import 'package:flutter/material.dart';
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

class Intra {
  String autologin;
  String epitechMail;
  var infos;

  Intra({@required this.epitechMail, @required this.autologin});

  convertToMap(String reqUrl) async {
    var response =
        await http.get(Uri.encodeFull("$autologin/user/$epitechMail$reqUrl"));
    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      return (parsedJson);
    } else {
      return (84);
    }
  }

  //Global  getter //
  alert() {
    endPoint point = endPoint.alert;
    return (convertToMap(point.value));
  }

  message() {
    endPoint point = endPoint.message;

    return (convertToMap(point.value));
  }

  notes() async {
    endPoint point = endPoint.notes;
    var response = await convertToMap(point.value);
    var body = List.of(response['modules']);

    return (body);
  }

  missed() {
    endPoint point = endPoint.missed;
    return (convertToMap(point.value));
  }

  nextRdv() {
    endPoint point = endPoint.nextRdv;
    return (convertToMap(point.value));
  }

  all() {
    endPoint point = endPoint.all;
    return (convertToMap(point.value));
  }

  init() async {
    var response = await all();
    infos = response;
  }

  ///@param something  can be: 'name' 'gpa' 'scolaryear' 'studentyear' 'promo' 'location' 'semester' 'isAdmin
  getInfosAbout(String something) {
    switch (something) {
      case 'personalmail':
        return (infos[something]);
        break;
      case 'firstname':
        return (infos[something]);
        break;
      case 'lastname':
        return (infos[something]);
        break;
      case 'scolaryear':
        return (infos[something]);
        break;
      case 'studentyear':
        return (infos[something]);
        break;
      case 'promo':
        return (infos[something]);
        break;
      case 'location':
        return (infos[something]);
      case 'semester':
        return (infos[something]);
      case 'gpa':
        return (infos['gpa'][0][something]);
        break;
      case 'cycle':
        return (infos['gpa'][0][something]);
        break;
      case 'isAdmin':
        return (infos['admin']);
        break;
      default:
        return "Invalid options";
        break;
    }
  }
}

/*class TestIntra extends StatefulWidget {
  @override
  _TestIntraState createState() => _TestIntraState();
}

class _TestIntraState extends State<TestIntra> {
  var body;
  Intra req = Intra(
      autologin:
          "https://intra.epitech.eu/auth-57a0d4528e3117b98cffc0e2a0c996ac4f14808c",
      epitechMail: "junior.medehou@epitech.eu");

  @override
  Widget build(BuildContext context) {
    req.init();
    return (Column(children: [
      SizedBox(
        height: 100,
      ),
      RaisedButton(
        onPressed: () async {
          var response = await req.getInfosAbout('lastname');
          print("response value = ${response}");
        },
        child: Text("Touch"),
      ),
      Center(
        child: Text(""),
      ),
    ]));
  }
}*/

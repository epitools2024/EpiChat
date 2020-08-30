import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:line_icons/line_icons.dart';
import 'package:EpiChat/widget/custom_widget.dart';
import 'package:EpiChat/api/intra.dart';

class ProfileInfos extends StatefulWidget {
  ProfileInfos({Key key, this.email, this.autologin}) : super(key: key);
  String email;
  String autologin;
  @override
  _ProfileInfosState createState() => _ProfileInfosState();
}

class _ProfileInfosState extends State<ProfileInfos> {
  var gpa;
  var annee;
  var credit;

  _initInfos() async {
    Intra req = Intra(epitechMail: widget.email, autologin: widget.autologin);
    req.init();

    setState(() {
      gpa = req.getInfosAbout('gpa');
      annee = req.getInfosAbout('scolaryear');
      credit = req.getInfosAbout('credit');
    });
  }

  Widget _profileWidget(String urlToPP, String name) {
    return (Container(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              urlToPP,
              scale: 4,
            ),
            radius: MediaQuery.of(context).size.width * (0.2),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ));
  }

  Widget _chartCredit(
      BuildContext context, Key chartKey, Size chartSize, int nbr) {
    Color completedColor;

    return (AnimatedCircularChart(
      key: chartKey,
      size: chartSize,
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              ((60 - nbr) * 100) / 60,
              Colors.blueGrey[600],
              rankKey: 'remaining',
            ),
            new CircularSegmentEntry(
              (nbr * 100) / 60,
              completedColor = nbr <= 20
                  ? Colors.red
                  : (nbr > 20 && nbr <= 40 ? Colors.orange : Colors.green),
              rankKey: 'completing',
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      percentageValues: false,
      holeLabel: "$nbr/60",
      labelStyle: new TextStyle(
        color: Colors.blueGrey[600],
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    ));
  }

  Widget _chartGPA(
      BuildContext context, Key chartKey, Size chartSize, double gpa) {
    Color completedColor;

    return (AnimatedCircularChart(
      key: chartKey,
      size: chartSize,
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              ((4 - gpa) * 100) / 4,
              Colors.blueGrey[600],
              rankKey: 'remaining',
            ),
            new CircularSegmentEntry(
              (4 * 100) / 4,
              completedColor = Colors.blue,
              rankKey: 'completing',
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      percentageValues: false,
      holeLabel: "$gpa",
      labelStyle: new TextStyle(
        color: Colors.blueGrey[600],
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(MediaQuery.of(context).size.width * (0.4),
        MediaQuery.of(context).size.width * (0.4));
    TextStyle labelStyle = TextStyle(
      fontSize: 15,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600,
    );
    Key _chartCreditKey, _chartGPAKey;
    _initInfos();

    return (Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            compenants: [
              IconButton(
                icon: Icon(
                  LineIcons.chevron_circle_left,
                  color: Theme.of(context).accentColor,
                  size: 30,
                ),
                onPressed: () => Navigator.of(context).pop(context),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * (0.01),
              ),
              Center(
                child: Text(
                  "Infos et reglages",
                  style: TextStyle(
                      fontSize: 21,
                      color: Theme.of(context).accentColor,
                      fontFamily: 'Nunito'),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Center(
            child: Column(
              children: [
                _profileWidget('https://randomuser.me/api/portraits/men/17.jpg',
                    "Charmeel (Tek$annee)"),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(children: [
                              _chartCredit(
                                  context, _chartCreditKey, size, credit),
                              Text("Crédits", style: labelStyle)
                            ]),
                          ),
                          Expanded(
                            child: Column(children: [
                              _chartGPA(context, _chartGPAKey, size, gpa),
                              Text(
                                "GPA",
                                style: labelStyle,
                              )
                            ]),
                          )
                        ],
                      ),
                    ])),
              ],
            ),
          ),
        )));
  }
}

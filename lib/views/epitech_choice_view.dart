import 'package:EpiChat/views/widgets/custom_centered_column.dart';
import 'package:EpiChat/views/widgets/custom_centered_row.dart';
import 'package:flutter/material.dart';

class EpitechChoiceView extends StatefulWidget {
  EpitechChoiceView({Key? key}) : super(key: key);

  @override
  _EpitechChoiceViewState createState() => _EpitechChoiceViewState();
}

class _EpitechChoiceViewState extends State<EpitechChoiceView>
    with SingleTickerProviderStateMixin {
  // AnimationController? _controller;
  // Animation<Offset>? _offsetAnimation;
  // Animation<double>? _animation = Animation<double>();

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //   duration: const Duration(seconds: 2),
    //   vsync: this,
    // )..repeat(reverse: true);
    // _offsetAnimation = Tween<Offset>(
    //   begin: Offset.zero,
    //   end: const Offset(0, 0.5),
    // ).animate(CurvedAnimation(
    //   parent: _animation!,
    //   curve: Curves.elasticIn,
    // ));
  }

  @override
  Widget build(BuildContext context) {
    var containerHeight = MediaQuery.of(context).size.height * (0.5);
    var containerWidth = MediaQuery.of(context).size.width * (0.8);

    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).accentColor,
                    Colors.blue[300]!,
                  ]),
            )),
        Align(
          child: Container(
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 1,
                    spreadRadius: 2,
                  )
                ]),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: CustomCenteredColumn(
                children: [
                  Text(
                    "Bienvenue💓",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 25,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: containerHeight * (0.1),
                  ),
                  Text(
                    "Es tu un membre\n(étudiant ou admin) \nd'Epitech ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: containerHeight * (0.1),
                  ),
                  CustomCenteredRow(children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('login', (route) => false);
                      },
                      child: const Text(
                        "Oui",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('home2', (route) => false);
                      },
                      child: const Text("Non"),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

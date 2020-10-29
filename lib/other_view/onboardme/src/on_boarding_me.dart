import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:EpiChat/other_view/onboardme/utilities/widgets/onboarding_screen/screen_data_widgets.dart';
import 'package:EpiChat/other_view/onboardme/utilities/widgets/onboarding_screen/pageIndicator.dart';
import 'package:EpiChat/other_view/onboardme/utilities/widgets/onboarding_screen/call_to_action_widget.dart';
import 'package:EpiChat/other_view/onboardme/utilities/widgets/onboarding_screen/skip_button.dart';
import 'package:EpiChat/other_view/onboardme/utilities/widgets/onboarding_screen/bgBoxDecoration.dart';

class OnboardingMe extends StatefulWidget {
  @required
  int numOfPage;

  @required
  int noOfBackgroundColor;

  @required
  List<Color> bgColor = [];

  List<Map<String, String>> screenContent = [];

  List<String> ctaText = [];

  bool isPageIndicatorCircle = false;

  @required
  String homeRoute;

  OnboardingMe({
    numOfPage = 3,
    noOfBackgroundColor = 4,
    bgColor = const [
      Colors.white,
    ],
    ctaText = const ['Ignorez', 'Commencez'],
    screenContent = const [
      {
        "Scr 1 Heading": "Epitech en main",
        "Scr 1 Sub Heading":
            "Votre intranet, les news vous suivent partout. Restez cablés",
        "Scr 1 Image Path": "assets/png/student1.png",
      },
      {
        "Scr 2 Heading": "Messagerie",
        "Scr 2 Sub Heading":
            "Permet aux utilisateurs de pouvoir participer aux différents sondages et campage de sensibilisation",
        "Scr 2 Image Path": "assets/png/student3.png",
      },
      {
        "Scr 3 Heading": "Chatbot",
        "Scr 3 Sub Heading":
            "Le fil d'actualité représente l'ensemble des publications des U-reporters comme les initiatives, les challenges et plus",
        "Scr 3 Image Path": "assets/png/student2.png",
      },
    ],
    isPageIndicatorCircle = false,
    homeRoute = 'home',
  }) {
    this.numOfPage = numOfPage;
    this.noOfBackgroundColor = noOfBackgroundColor;
    noOfBackgroundColor == 1
        ? this.bgColor = [Colors.black]
        : this.bgColor = bgColor;
    this.ctaText = ctaText;
    this.screenContent = screenContent;
    this.isPageIndicatorCircle = isPageIndicatorCircle;
    this.homeRoute = homeRoute;
  }

  @override
  _OnboardingMeState createState() => _OnboardingMeState();
}

class _OnboardingMeState extends State<OnboardingMe> {
  PageController pageController = PageController(initialPage: 0);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Container(
              decoration: bgBoxDecoration(widget.bgColor),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 50),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerRight,
                        child: skipButton(
                          text: widget.ctaText[0],
                          homeRoute: widget.homeRoute,
                          context: context,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 1.3,
                        child: PageView(
                          physics: ClampingScrollPhysics(),
                          controller: pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              currentPage = page;
                            });
                          },
                          children: screenData(
                              widget.numOfPage, widget.screenContent, context),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: pageIndicator(widget.numOfPage, currentPage,
                            widget.isPageIndicatorCircle, context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomSheet: currentPage == widget.numOfPage - 1
          ? callToAction(
              text: widget.ctaText[1],
              homeRoute: widget.homeRoute,
              context: context)
          : Text(''),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:EpiChat/other_view/onboardme/onboardme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EpiChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Roboto",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Color(0xFF4573F8),
      ),
      home: SplashScreen(),
      routes: {
        'home': (context) => MyHomePage(
              isEpitech: true,
            ),
        'home2': (context) => MyHomePage(
              isEpitech: false,
            ),
        'profil': (context) => ProfileInfos(),
        'chatbot': (context) => ChatBot(),
        'questions': (context) => Questions(),
        'login': (context) => LoginScreen(),
        'splashscreen': (context) => SplashScreen(),
        'onboard': (context) => OnboardingMe(
              homeRoute: "login",
            )
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.isEpitech}) : super(key: key);
  bool isEpitech = false;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedItem = 0;
  PageController _pageController;
  var email, autologin;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    initInfos();
  }

  Future<void> initInfos() async {
    var tmp_mail = await getStringFromSharedPref('email');
    var tmp_login = await getStringFromSharedPref('autologin');

    setState(() {
      email = tmp_mail;
      autologin = tmp_login;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = widget.isEpitech
        ? List<Widget>.of(
            [Chat(), News(), Planning(), MarvinJr(isEpitech: widget.isEpitech)])
        : List<Widget>.of([MarvinJr(isEpitech: widget.isEpitech)]);
    List<GButton> tabs = widget.isEpitech
        ? List<GButton>.of([
            GButton(
              icon: CustomIcon.chat,
              iconColor: Color(0xFF4573F8),
              text: 'Texto',
            ),
            GButton(
              icon: LineIcons.lightbulb_o,
              iconColor: Color(0xFF4573F8),
              text: 'News',
            ),
            GButton(
              icon: CustomIcon.plan,
              iconColor: Color(0xFF4573F8),
              text: 'Planning',
            ),
            GButton(
              icon: FontAwesomeIcons.robot,
              iconColor: Color(0xFF4573F8),
              text: 'M. Jr',
            ),
          ])
        : List<GButton>.of([
            GButton(
              icon: FontAwesomeIcons.robot,
              iconColor: Color(0xFF4573F8),
              text: 'Marvin Jr',
            ),
          ]);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            compenants: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * (0.04)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/png/epichat-name.png",
                      scale: MediaQuery.of(context).size.height * (0.005),
                    ),
                  )),
              Expanded(
                child: SizedBox(),
              ),
              widget.isEpitech
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * (0.001)),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed('profil'),
                          icon: Icon(
                            LineIcons.user,
                            size: MediaQuery.of(context).size.height * (0.05),
                            color: Color(0xFF4573F8),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          )),
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedItem = index;
          });
        },
      ),
      bottomNavigationBar: widget.isEpitech
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 6, color: Colors.black.withOpacity(0.2))
                    ]),
                child: SafeArea(
                  child: GNav(
                    gap: 10,
                    activeColor: Colors.white,
                    iconSize: 25,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    tabBackgroundColor: Theme.of(context).accentColor,
                    selectedIndex: _selectedItem,
                    onTabChange: (index) {
                      setState(() {
                        _selectedItem = index;
                        _pageController.jumpToPage(index);
                      });
                    },
                    tabs: tabs,
                  ),
                ),
              ),
            )
          : Container(
              height: 0,
            ),
    );
  }
}

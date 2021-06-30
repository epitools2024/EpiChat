import 'package:EpiChat/helpers/constants.dart';
import 'package:EpiChat/locator.dart';
import 'package:EpiChat/models/appuser_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'routes.dart';

void main() async {
  await globalInitializer();

  runApp(App());
}

globalInitializer() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);

  Hive.registerAdapter(AppUserAdapter());

  await Hive.openBox<AppUser>("user");
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EpiChat',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      onGenerateRoute: (settings) => AppRouter.generateRoute(
        settings,
      ),
    );
  }
}

import 'package:EpiChat/services/firebase/auth_service.dart';
import 'package:EpiChat/services/firebase/firestore_service.dart';
import 'package:EpiChat/services/local/local_service.dart';
import 'package:EpiChat/viewmodels/epitech_choice_viewmodel.dart';
import 'package:EpiChat/viewmodels/home_viewmodel.dart';
import 'package:EpiChat/viewmodels/login_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => LocalService());

  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => EpitechChoiceViewModel());
}

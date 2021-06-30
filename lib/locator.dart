import 'package:EpiChat/services/firebase/auth_service.dart';
import 'package:EpiChat/services/firebase/firestore_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => AuthService());
}

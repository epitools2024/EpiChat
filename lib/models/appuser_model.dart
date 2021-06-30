import 'package:hive/hive.dart';
part 'appuser_model.g.dart';

@HiveType(typeId: 0)
class AppUser extends HiveObject {
  @HiveField(0)
  final String? username;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? autologin;
  @HiveField(3)
  final bool? isAdmin;

  AppUser({
    this.autologin,
    this.email,
    this.isAdmin,
    this.username,
  });

  toJson() {
    return {
      "username": this.username,
      "email": this.email,
      "isAdmin": this.isAdmin,
      "autologin": this.autologin,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    AppUser user = AppUser(
      username: json["usrname"],
      email: json["email"],
      isAdmin: json["isAdmin"],
      autologin: json["autologin"],
    );
    return user;
  }

  @override
  String toString() {
    return '{user:username:$username, email:$email, autologin:$autologin, isAdmin:$isAdmin}';
  }
}

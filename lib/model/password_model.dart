import 'package:password_administrator/database/db_helper.dart';

class Password {
  final String site_name;
  final String site_url;
  final String password;
  final int id_user;
  bool isPasswordVisible;

  Password({
    required this.site_name,
    required this.site_url,
    required this.password,
    required this.id_user,
    this.isPasswordVisible = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'site_name': site_name,
      'site_url': site_url,
      'password': password,
      'id_user' : id_user,
    };
  }

  Password.fromMap(Map<String, dynamic> map) : this(
    site_name: map['site_name'],
    site_url: map['site_url'],
    password: map['password'],
    id_user: map['id_user'],
    isPasswordVisible : false
  );
}
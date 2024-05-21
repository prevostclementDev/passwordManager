import 'package:password_administrator/database/db_helper.dart';

class Password {
  final String site_name;
  final String site_url;
  final String password;
  final int id_user;

  const Password({
    required this.site_name,
    required this.site_url,
    required this.password,
    required this.id_user,
  });

  Map<String, dynamic> toMap() {
    return {
      'site_name': site_name,
      'site_url': site_url,
      'password': password,
      'id_user' : id_user,
    };
  }

}
import 'package:password_administrator/database/db_helper.dart';

class User {
  final String username;
  final String password;

  const User({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password
    };
  }

  Future list() async {
    final db = await DbHelper().getDatabase();
    final usersList = await db.query('users');
  }

}
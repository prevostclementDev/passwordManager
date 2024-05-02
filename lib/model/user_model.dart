import 'package:password_administrator/database/db_helper.dart';

class User {

  final int id;
  final String username;
  final String password;

  const User({
    required this.id,
    required this.username,
    required this.password,
  });

  Future list() async {
    final db = await DbHelper().getDatabase();
    print( await db.query('users') );

  }

}
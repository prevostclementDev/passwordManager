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

  Future<List<User>> list() async {
    final db = await DbHelper().getDatabase();
    final usersList = await db.query('users');

    return [
      for (final user in usersList)
        User(id: user['id'], username: user['username'], password: user['password'])
    ];

  }

}
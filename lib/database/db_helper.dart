import 'package:flutter/cupertino.dart';
import 'package:password_administrator/model/user_model.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../globals.dart';

class DbHelper {

  static const String dbPath = 'database\\database_password_manager.db';

  Future getDatabase() async {
    sqfliteFfiInit();
    sql.databaseFactory = databaseFactoryFfi;

    WidgetsFlutterBinding.ensureInitialized();

    return await sql.openDatabase(
      p.join(Globals.libPath, dbPath),
    );
  }

  Future<int> addUser(User user) async {
    final db = await getDatabase();

    final result = await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return result;
  }


}
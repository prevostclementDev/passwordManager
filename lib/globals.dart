import 'package:path/path.dart' as p;
import 'package:dotenv/dotenv.dart';

class Globals {

  static final Globals _singleton = Globals._internal();
  static String libPath = '${p.current}\\lib\\';
  static var env = DotEnv(includePlatformEnvironment: true)..load();
  static var user = {};

  factory Globals() {
    return _singleton;
  }

  Globals._internal();
}
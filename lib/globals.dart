import 'package:path/path.dart' as p;

class Globals {

  static final Globals _singleton = Globals._internal();

  static String libPath = '${p.current}\\lib\\';

  factory Globals() {
    return _singleton;
  }

  Globals._internal();

  int userId = 0;
}
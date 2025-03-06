import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractDBHelder {
  initDB();
  closeDB();
  Future<bool> insertData(String table, String data);
  Future<String?> getData(String table);
}

class DBHelper implements AbstractDBHelder {
  SharedPreferences sharedPreferences;
  DBHelper(this.sharedPreferences);
  @override
  initDB() {
    // get db
  }
  @override
  closeDB() {
    // close db
  }
  @override
  Future<bool> insertData(String table, String data) async {
    return await sharedPreferences.setString(table, data);
  }

  @override
  Future<String?> getData(String table) async {
    return sharedPreferences.getString(table);
  }
}

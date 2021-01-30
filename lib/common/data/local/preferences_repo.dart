import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepo {
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  final String ftpKey = "ftp_key";

  Future<int> getFtp() async {
    var sharedPreferences = await getSharedPreferences();
    return sharedPreferences.getInt(ftpKey);
  }

  Future setFtp(int ftp) async {
    var sharedPreferences = await getSharedPreferences();
    sharedPreferences.setInt(ftpKey, ftp);
  }
}

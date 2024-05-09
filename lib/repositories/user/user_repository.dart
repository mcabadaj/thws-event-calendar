import 'package:shared_preferences/shared_preferences.dart';

import 'user.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (_user == null) {
      String? user = prefs.getString('user');
      if (user != null) {
        _user = User(user);
      }
    }
    return _user;
  }

  setUser(User? user) async {
    final prefs = await SharedPreferences.getInstance();
    _user = user;
    if (user == null) {
      prefs.remove('user');
    } else {
      prefs.setString('user', user.name);
    }
  }
}

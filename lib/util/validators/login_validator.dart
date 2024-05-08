class LoginValidator {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username can\'t be empty';
    }
    if (!RegExp(r'^k\d{5}$').hasMatch(value)) {
      return 'Invalid username format';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password can\'t be empty';
    }
    return null;
  }
}

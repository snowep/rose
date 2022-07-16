class Validator {
  static String? validateName({required String name}) {
    if (name.isEmpty) {
      return 'Name is required';
    }
    if (name == null) {
      return null;
    }
  }

  static String? validateEmail({required String email}) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email is required';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    if (password == null) {
      return null;
    } else if (password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'Password is too short';
    }
    return null;
  }
}

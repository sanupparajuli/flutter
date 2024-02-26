mixin ValidationMixin {
  int isPasswordValid(String password) {
    List<String> check = [];

    if (password.length >= 8) {
      check.add("Password must be at least 8 characters long.");
    }

    if (password.contains(RegExp(r'[A-Z]'))) {
      check.add("Password must contain at least one uppercase letter.");
    }

    if (password.contains(RegExp(r'[^A-Za-z0-9]'))) {
      check.add("Password must contain at least one special character.");
    }

    if (password.contains(RegExp(r'[0-9]'))) {
      check.add("Password must contain at least one number.");
    }
    return check.length;
  }

  String isPasswordMatch(String password, String confirmPassword) {
    if (password == confirmPassword) return 'success';
    return 'error';
  }

  bool isPhoneValid(String phone) => phone.length == 10;
  bool isFirstNameValid(String firstName) => firstName.isNotEmpty;
  bool isLastNameValid(String lastName) => lastName.isNotEmpty;

  String isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (regex.hasMatch(email)) return 'success';
    return 'Enter Valid Email';
  }
}

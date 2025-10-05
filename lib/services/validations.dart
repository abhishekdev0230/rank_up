class Helpers {
  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value?.trim().isEmpty ?? true) {
      return "Please Enter Email";
    } else if (!regex.hasMatch(value!)) {
      return 'Please Enter Valid Email';
    } else {
      return null;
    }
  }

  static String? fullName(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "Please Enter Your Number ";
    } else {
      return null;
    }
  }

  static String? customValidator(String? value, String errorText) {
    if (value?.trim().isEmpty ?? true) {
      return errorText;
    } else {
      return null;
    }
  }

  static String? validation({String? value, required String errorMsg}) {
    if (value?.trim().isEmpty ?? true) {
      return errorMsg;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please Enter Password';
    } else if ((value?.length ?? 0) < 6) {
      return 'Password Must Be Of 6 Digits';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(
    String? value,
    String password,
  ) {
    if (value?.trim().isEmpty ?? true) {
      return "Please Enter Confirm Password ";
    } else if (password != value.toString()) {
      return "Password and Confirm Password Should be Same";
    } else {
      return null;
    }
  }
}

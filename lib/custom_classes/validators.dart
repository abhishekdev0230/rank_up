import 'package:intl/intl.dart';

class CommonValidators {
  /// Required Field Validator
  static String? validateRequired(String? value, {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }
    return null;
  }

  /// Date Validator (expects yyyy-MM-dd)

  static String? dateValidation(String? value, {String fieldName = "Date"}) {
    if (value == null || value.trim().isEmpty) {
      return "Please select $fieldName";
    }

    final trimmed = value.trim();

    // Regex for dd-MM-yyyy
    final regex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
    if (!regex.hasMatch(trimmed)) {
      return "Enter $fieldName in dd-MM-yyyy format";
    }

    try {
      final date = DateFormat("dd-MM-yyyy").parseStrict(trimmed);

      final today = DateTime.now();
      final todayDateOnly = DateTime(today.year, today.month, today.day);
      final eighteenYearsAgo = DateTime(today.year - 18, today.month, today.day);

      if (date.isAfter(todayDateOnly)) {
        return "$fieldName cannot be in the future";
      }

      if (date.isAfter(eighteenYearsAgo)) {
        return "You must be at least 18 years old";
      }
    } catch (e) {
      return "Invalid $fieldName";
    }

    return null; // valid
  }





  /// Email Validator
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your email";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "Please enter a valid email address";
    }

    return null;
  }

  /// Name Validator (Only alphabets and spaces allowed)
  static String? validateName(String? value, {String fieldName = "Name"}) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }

    final nameRegex = RegExp(r'^[a-zA-Z\s]+');
    if (!nameRegex.hasMatch(value.trim())) {
      return "$fieldName can contain only letters and spaces";
    }

    return null;
  }

  /// Mobile Number Validator
  static String? validateMobile(String? value,
      {String fieldName = "Mobile number", int maxLength = 10}) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }

    final trimmedValue = value.replaceAll(' ', '');

    if (trimmedValue.length < maxLength) {
      return "$fieldName must be at least $maxLength digits";
    }

    if (trimmedValue.length > maxLength) {
      return "$fieldName cannot exceed $maxLength digits";
    }

    final regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(trimmedValue)) {
      return "$fieldName must contain only digits";
    }

    return null;
  }

  /// Hair Color Validator (only letters & spaces)
  static String? validateHair(String? value,
      {String fieldName = "Hair color"}) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }

    final hairRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!hairRegex.hasMatch(value.trim())) {
      return "$fieldName can contain only letters and spaces";
    }

    return null;
  }

  /// Password Validator (min 8 chars)
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your password";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }

    return null;
  }

  /// Confirm Password Validator
  static String? validateConfirmPassword(String? value, String original) {
    if (value == null || value.trim().isEmpty) {
      return "Please confirm your password";
    }

    if (value != original) {
      return "Passwords do not match";
    }

    return null;
  }

  /// Height Validator (max 220 cm)
  static String? validateHeight(String? value, {String fieldName = "Height"}) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }

    final height = double.tryParse(value.trim());
    if (height == null) {
      return "Please enter a valid number";
    }

    // Height range check
    if (height < 140 || height > 250) {
      return "$fieldName range: 140-250";
    }

    return null; // valid
  }




  /// Weight Validator (max 150 kg)
  static String? validateWeight(String? value, {String fieldName = "Weight"}) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }

    final weight = double.tryParse(value.trim());
    if (weight == null) {
      return "Please enter a valid number";
    }

    if (weight <= 40 || weight > 150) {
      return "$fieldName range: 40-150";
    }

    // if (weight > 150) {
    //   return "$fieldName cannot be more than 150 kg";
    // }

    return null; // valid
  }

}


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetupProvider extends ChangeNotifier {
  String fullName = '';
  String email = '';
  String phoneNumber = '';
  String? selectedClass;
  String? selectedState;
  String? selectedCity;
  XFile? profileImage;

  /// Setters
  void setFullName(String value) {
    fullName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void setSelectedClass(String? value) {
    selectedClass = value;
    notifyListeners();
  }

  void setSelectedState(String? value) {
    selectedState = value;
    notifyListeners();
  }

  void setSelectedCity(String? value) {
    selectedCity = value;
    notifyListeners();
  }

  void setProfileImage(XFile? image) {
    profileImage = image;
    notifyListeners();
  }

  /// Pick image from camera or gallery
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      profileImage = pickedImage;
      notifyListeners();
    }
  }
}

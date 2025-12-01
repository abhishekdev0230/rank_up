import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rank_up/Utils/helper.dart';
import 'package:rank_up/custom_classes/custom_navigator.dart';
import 'package:rank_up/custom_classes/loder.dart';
import 'package:rank_up/services/api_methods.dart';
import 'package:rank_up/services/api_urls.dart';
import 'package:rank_up/services/common_response.dart';
import 'package:rank_up/services/local_storage.dart';
import 'package:rank_up/views/bottom_navigation_bar.dart';
import '../../models/ProfileGetModel.dart';

class ProfileSetupProvider extends ChangeNotifier {

  bool loggedInViaGoogle = false;

  void setLoggedInViaGoogle(bool val) {
    loggedInViaGoogle = val;
    notifyListeners();
  }

  String fullName = '';
  String bookmarkedCount = '';
  String suspendedCardCount = '';
  String email = '';
  String? phoneNumber;

  // 🧩 Dropdown Selections
  String? selectedClass;
  String? selectedState;
  String? selectedCity;
  String? profilePictureGetApi;

  XFile? profileImage;
  final ImagePicker _picker = ImagePicker();

  final List<String> classList = ["Class 11", "Class 12", "Dropper"];

  final List<String> stateList = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
    // 🟪 Union Territories
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli and Daman and Diu",
    "Delhi",
    "Jammu and Kashmir",
    "Ladakh",
    "Lakshadweep",
    "Puducherry",
  ];

  // ✅ City List
  final List<String> cityList = [
    "Ahmedabad",
    "Amritsar",
    "Aurangabad",
    "Bengaluru",
    "Bhopal",
    "Bhubaneswar",
    "Chandigarh",
    "Chennai",
    "Coimbatore",
    "Dehradun",
    "Delhi",
    "Dhanbad",
    "Dispur",
    "Ernakulam",
    "Faridabad",
    "Gandhinagar",
    "Ghaziabad",
    "Guwahati",
    "Gwalior",
    "Hyderabad",
    "Indore",
    "Jaipur",
    "Jammu",
    "Jamshedpur",
    "Jodhpur",
    "Kanpur",
    "Kochi",
    "Kolkata",
    "Kota",
    "Lucknow",
    "Ludhiana",
    "Madurai",
    "Mangaluru",
    "Meerut",
    "Mumbai",
    "Mysuru",
    "Nagpur",
    "Nashik",
    "Noida",
    "Panaji",
    "Patna",
    "Pune",
    "Raipur",
    "Rajkot",
    "Ranchi",
    "Shillong",
    "Shimla",
    "Srinagar",
    "Surat",
    "Thane",
    "Thiruvananthapuram",
    "Tiruchirappalli",
    "Udaipur",
    "Vadodara",
    "Varanasi",
    "Vijayawada",
    "Visakhapatnam",
  ];

  // ✅ Setters
  void setFullName(String value) {
    fullName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
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

  // ✅ Pick image
  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setProfileImage(pickedImage);
    }
  }

  // ✅ Clear all
  void clearProfile() {
    fullName = '';
    email = '';
    selectedClass = null;
    selectedState = null;
    selectedCity = null;
    profileImage = null;
    notifyListeners();
  }

  // ✅ API Call: Complete Profile
  static Future<CommonResponse?> completeProfileApi({
    required BuildContext context,
    required String fullName,
    required String email,
    required String selectedClass,
    required String selectedState,
    required String selectedCity,
    File? profileImage,
  }) async {
    try {
      CommonLoaderApi.show(context);

      // 🔹 Read token
      Map<String, String> headers = await ApiHeaders.withStoredToken();

      // 🔹 Format class value (remove "Class ")
      String formattedClass = selectedClass.startsWith("Class ")
          ? selectedClass.replaceAll("Class ", "").trim()
          : selectedClass;

      // 🔹 API Call
      final response = await ApiMethods().postMethodCM(
        header: headers,
        method: ApiUrls.completeProfile,
        body: {
          "fullName": fullName,
          "email": email,
          "class": formattedClass,
          "state": selectedState,
          "city": selectedCity,
          "profile_image": profileImage?.path.toString(),
        },
      );

      CommonLoaderApi.hide(context);

      if (response?.message != null) {
        Helper.customToast(response!.message!);
      }

      // ✅ Success handling
      if (response?.status == true) {
        await StorageManager.savingData(StorageManager.isLogin, true);
        CustomNavigator.pushRemoveUntil(
          context,
          BottomNavController(initialIndex: 0),
        );
      }
      return response;
    } catch (e) {
      CommonLoaderApi.hide(context);
      Helper.customToast("Error: $e");
      return CommonResponse(status: false, message: "Error: $e");
    }
  }

  // ✅ API Call: Get Profile
  Future<ProfileGetModel?> getProfileApi(BuildContext context) async {
    CommonLoaderApi.show(context);

    // 🔹 Read token
    Map<String, String> headers = await ApiHeaders.withStoredToken();

    // 🔹 API Call
    final response = await ApiMethods().getMethodTwo(
      header: headers,
      method: ApiUrls.profile,
      body: {},
    );

    if (response.isNotEmpty) {
      final Map<String, dynamic> json = jsonDecode(response);
      // 🔹 Parse to ProfileGetModel
      final profileData = ProfileGetModel.fromJson(json);
      CommonLoaderApi.hide(context);

      if (profileData.status == true && profileData.data != null) {
        fullName = profileData.data!.fullName ?? '';
        bookmarkedCount = profileData.data!.stats?.bookmarks.toString() ?? '';
        suspendedCardCount = profileData.data!.stats?.suspendedFlashcards.toString() ?? '';
        email = profileData.data!.email ?? '';
        String? apiClass = profileData.data!.dataClass;
        if (apiClass != null) {
          if (apiClass == "11" || apiClass == "Class 11") {
            selectedClass = "Class 11";
          } else if (apiClass == "12" || apiClass == "Class 12") {
            selectedClass = "Class 12";
          } else if (apiClass == "Dropper" || apiClass == "Class Dropper") {
            selectedClass = "Dropper";
          } else {
            selectedClass = apiClass; // fallback
          }
        }
        profilePictureGetApi = profileData.data?.profilePicture;
        selectedState = profileData.data!.state;
        selectedCity = profileData.data!.city;
        phoneNumber = profileData.data!.phoneNumber;

        notifyListeners();
      }

      return profileData;
    } else {
      CommonLoaderApi.hide(context);
      Helper.customToast("Empty response from server");
      return ProfileGetModel(status: false, message: "Empty response");
    }
  }

  Future<void> updateProfile(BuildContext context) async {
    try {
      CommonLoaderApi.show(context);

      // 🔹 Format class (remove "Class " prefix)
      String formattedClass = (selectedClass ?? "").startsWith("Class ")
          ? selectedClass!.replaceAll("Class ", "").trim()
          : (selectedClass ?? "");

      // 🔹 Build request fields
      Map<String, String> fields = {
        "fullName": fullName,
        "email": email,
        "state": selectedState ?? "",
        "city": selectedCity ?? "",
        "class": formattedClass, // Always send only 11, 12, or Dropper
      };

      final headers = await ApiHeaders.withStoredToken();

      // 🔹 API Call (PATCH method)
      final res = await ApiMethods().patchMultipartMethodCM(
        method: ApiUrls.profileUpdate,
        file: profileImage != null ? File(profileImage!.path) : null,
        fileFieldName: "profile_image",
        fields: fields,
        headers: headers,
      );
      CommonLoaderApi.hide(context);
      if (res != null && res.status == true) {
        await getProfileApi(context);
        CustomNavigator.popNavigate(context);
      } else {
        Helper.customToast(res?.message ?? "Something went wrong");
      }
    } catch (e) {
      CommonLoaderApi.hide(context);
      Helper.customToast("Error: $e");
    }
  }

}

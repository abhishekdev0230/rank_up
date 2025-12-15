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
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli and Daman and Diu",
    "Delhi",
    "Jammu and Kashmir",
    "Ladakh",
    "Lakshadweep",
    "Puducherry",
  ];

  final Map<String, List<String>> stateCityMap = {
    "Andhra Pradesh": [
      "Visakhapatnam",
      "Vijayawada",
      "Guntur",
      "Nellore",
      "Kurnool",
      "Tirupati",
      "Kadapa",
    ],

    "Arunachal Pradesh": [
      "Itanagar",
      "Tawang",
      "Pasighat",
      "Ziro",
      "Bomdila",
    ],

    "Assam": [
      "Guwahati",
      "Silchar",
      "Dibrugarh",
      "Jorhat",
      "Tezpur",
    ],

    "Bihar": [
      "Patna",
      "Gaya",
      "Bhagalpur",
      "Purnea",
      "Muzaffarpur",
    ],

    "Chhattisgarh": [
      "Raipur",
      "Bhilai",
      "Bilaspur",
      "Durg",
      "Korba",
    ],

    "Goa": [
      "Panaji",
      "Margao",
      "Vasco da Gama",
      "Mapusa",
    ],

    "Gujarat": [
      "Ahmedabad",
      "Surat",
      "Vadodara",
      "Rajkot",
      "Bhavnagar",
    ],

    "Haryana": [
      "Faridabad",
      "Gurugram",
      "Panipat",
      "Hisar",
      "Ambala",
    ],

    "Himachal Pradesh": [
      "Shimla",
      "Manali",
      "Dharamshala",
      "Solan",
      "Mandi",
    ],

    "Jharkhand": [
      "Ranchi",
      "Jamshedpur",
      "Dhanbad",
      "Hazaribagh",
      "Bokaro",
    ],

    "Karnataka": [
      "Bengaluru",
      "Mysuru",
      "Mangaluru",
      "Hubballi",
      "Belagavi",
    ],

    "Kerala": [
      "Thiruvananthapuram",
      "Kochi",
      "Kozhikode",
      "Thrissur",
      "Kollam",
    ],

    "Madhya Pradesh": [
      "Indore",
      "Bhopal",
      "Gwalior",
      "Jabalpur",
      "Ujjain",
      "Sagar",
      "Ratlam",
      "Rewa",
      "Satna",
      "Dewas",
      "Chhindwara",
      "Morena",
      "Khargone",
      "Bhind",
      "Shivpuri",
      "Vidisha",
      "Guna",
      "Hoshangabad",
      "Betul",
      "Sehore",
      "Khandwa",
      "Burhanpur",
      "Mandsaur",
      "Neemuch",
      "Singrauli",
      "Seoni",
      "Damoh",
      "Datia",
      "Shajapur",
      "Raisen",
      "Rajgarh",
      "Itarsi",
      "Mhow",
      "Sendhwa",
      "Nagda",
      "Harda",
      "Ashok Nagar",
      "Chhatarpur",
      "Panna",
      "Tikamgarh",
      "Anuppur",
      "Umaria",
      "Dindori",
      "Mandla",
    ],


    "Maharashtra": [
      "Mumbai",
      "Pune",
      "Nagpur",
      "Nashik",
      "Thane",
      "Aurangabad",
      "Kolhapur",
    ],

    "Manipur": [
      "Imphal",
      "Bishnupur",
      "Churachandpur",
      "Thoubal",
    ],

    "Meghalaya": [
      "Shillong",
      "Tura",
      "Nongpoh",
    ],

    "Mizoram": [
      "Aizawl",
      "Lunglei",
      "Serchhip",
    ],

    "Nagaland": [
      "Kohima",
      "Dimapur",
      "Mokokchung",
    ],

    "Odisha": [
      "Bhubaneswar",
      "Cuttack",
      "Rourkela",
      "Berhampur",
      "Sambalpur",
    ],

    "Punjab": [
      "Amritsar",
      "Ludhiana",
      "Jalandhar",
      "Patiala",
      "Bathinda",
    ],

    "Rajasthan": [
      "Jaipur",
      "Jodhpur",
      "Udaipur",
      "Kota",
      "Ajmer",
    ],

    "Sikkim": [
      "Gangtok",
      "Namchi",
      "Gyalshing",
    ],

    "Tamil Nadu": [
      "Chennai",
      "Coimbatore",
      "Madurai",
      "Salem",
      "Tiruchirappalli",
    ],

    "Telangana": [
      "Hyderabad",
      "Warangal",
      "Karimnagar",
      "Nizamabad",
    ],

    "Tripura": [
      "Agartala",
      "Dharmanagar",
      "Udaipur",
    ],

    "Uttar Pradesh": [
      "Lucknow",
      "Kanpur",
      "Varanasi",
      "Noida",
      "Agra",
      "Prayagraj",
      "Ghaziabad",
    ],

    "Uttarakhand": [
      "Dehradun",
      "Haridwar",
      "Rishikesh",
      "Haldwani",
      "Roorkee",
    ],

    "West Bengal": [
      "Kolkata",
      "Howrah",
      "Durgapur",
      "Siliguri",
      "Asansol",
    ],

    // ===========================
    //        UNION TERRITORIES
    // ===========================

    "Andaman and Nicobar Islands": [
      "Port Blair",
      "Diglipur",
      "Mayabunder",
    ],

    "Chandigarh": [
      "Chandigarh",
    ],

    "Dadra and Nagar Haveli and Daman and Diu": [
      "Silvassa",
      "Daman",
      "Diu",
    ],

    "Delhi": [
      "New Delhi",
      "Dwarka",
      "Saket",
      "Rohini",
      "Laxmi Nagar",
    ],

    "Jammu and Kashmir": [
      "Srinagar",
      "Jammu",
      "Anantnag",
      "Baramulla",
    ],

    "Ladakh": [
      "Leh",
      "Kargil",
    ],

    "Lakshadweep": [
      "Kavaratti",
      "Agatti",
      "Minicoy",
    ],

    "Puducherry": [
      "Puducherry",
      "Karaikal",
      "Mahe",
      "Yanam",
    ],
  };



  List<String> getCitiesForSelectedState() {
    if (selectedState == null) return [];
    return stateCityMap[selectedState] ?? [];
  }
  void setSelectedState(String? value) {
    selectedState = value;
    selectedCity = null;
    notifyListeners();
  }


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



  void setSelectedCity(String? value) {
    selectedCity = value;
    notifyListeners();
  }

  void setProfileImage(XFile? image) {
    profileImage = image;
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setProfileImage(pickedImage);
    }
  }

  void clearProfile() {
    fullName = '';
    email = '';
    selectedClass = null;
    selectedState = null;
    selectedCity = null;
    profileImage = null;
    notifyListeners();
  }

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

      Map<String, String> headers = await ApiHeaders.withStoredToken();

      // 🔹 Format class value (remove "Class ")
      String formattedClass = selectedClass.startsWith("Class ")
          ? selectedClass.replaceAll("Class ", "").trim()
          : selectedClass;

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

  Future<ProfileGetModel?> getProfileApi(BuildContext context) async {
    CommonLoaderApi.show(context);

    Map<String, String> headers = await ApiHeaders.withStoredToken();

    final response = await ApiMethods().getMethodTwo(
      header: headers,
      method: ApiUrls.profile,
      body: {},
    );

    if (response.isNotEmpty) {
      final Map<String, dynamic> json = jsonDecode(response);
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

      String formattedClass = (selectedClass ?? "").startsWith("Class ")
          ? selectedClass!.replaceAll("Class ", "").trim()
          : (selectedClass ?? "");

      Map<String, String> fields = {
        "fullName": fullName,
        "email": email,
        "state": selectedState ?? "",
        "city": selectedCity ?? "",
        "class": formattedClass,
      };

      final headers = await ApiHeaders.withStoredToken();

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

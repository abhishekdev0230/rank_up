class ApiUrls {
  static final ApiUrls _apiMethods = ApiUrls._internal();

  ApiUrls._internal();

  factory ApiUrls() {
    return _apiMethods;
  }

  /// --------------------->>>>>  Google map Key  <<<<<----------------------------
  static const String google_apiKey = 'AIzaSyBCi-I8dhVghsr20HVVyCfkxBpsXVe2O60';
  // static const String google_apiKey = 'AIzaSyD7fSNx2zaxcHmraMpgojfk18m3y-Spk7Y';

  // static const String google_apiKey = 'AIzaSyAXe2oOd_1R0qTzx1cFuMY0euqD3kakg9o';
  /// --------------------->>>>>  Google place search base url  <<<<<----------------------------
  static const String google_place_base_url =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?';

  /// --------------------->>>>>  Google place detail base url  <<<<<----------------------------
  static const String googleplace_detail_base_url = 'https://maps.googleapis.com/maps/api/place/details/json?';

  /// --------------------->>>>>  Base URL dev. <<<<<----------------------------
  static const String baseURL = "https://work.mobidudes.in/OM/privee/api/";
  static const String imageBaseURL = "https://work.mobidudes.in/OM/privee/";

  ///.....................live................
  // static const String baseURL = "https://kellyturkeyfarms.co.uk/api/";
  // static const String imageBaseURL = "https://kellyturkeyfarms.co.uk/";

  /// --------------------->>>>>  All URL  <<<<<----------------------------
  static const String login = "${baseURL}login";
  static const String register = "${baseURL}register-user";
  static const String logout = "${baseURL}logout";
  static const String profileImage = "${baseURL}profile-image";
  static const String userImage = "${baseURL}user-image";
  static const String userGender = "${baseURL}user-gender";
  static const String getLookingForListing = "${baseURL}get-LookingFor-listing";
  static const String lookingFor = "${baseURL}looking-for";
  static const String additionalDetail = "${baseURL}additional-detail";
  static const String interestedIn = "${baseURL}intrested-in";
  static const String hearAboutUsListing = "${baseURL}hear-about-us-listing";
  static const String hearAboutUs= "${baseURL}hear-about-us";
  static const String sendOtp= "${baseURL}send-otp";
  static const String verifyOtp= "${baseURL}verify-otp";
  static const String resetPassword= "${baseURL}reset-otp";
  static const String adminStatus= "${baseURL}admin-status";
  static const String countryCode= "${baseURL}country-code";
  static const String getNationality= "${baseURL}get-nationality";
  static const String getRegion= "${baseURL}get-region";
  static const String getCity= "${baseURL}get-cityById";
  static const String getSexOrientation= "${baseURL}get-sexOrientation";
  static const String getZodiacSign= "${baseURL}get-zodiacSign";
  static const String profileDetail= "${baseURL}profile-detail";
  static const String privacyPolicy= "${baseURL}privicy-policy";
  static const String termCondition= "${baseURL}term-condition";
  static const String editAccountDetail= "${baseURL}edit-account-detail";
  static const String editAbout= "${baseURL}edit-about";
  static const String editPerfectMatch= "${baseURL}edit-perfect-match";
  static const String updateLookingFor= "${baseURL}edit-lookingfor";
  static const String addGalleryImages= "${baseURL}add-gallery-images";
  static const String addPrivatePhoto= "${baseURL}add-private-photo";

}

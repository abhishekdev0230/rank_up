class ApiUrls {
  ApiUrls._(); // private constructor

  /// --------------------->>>>>  Google Map Keys  <<<<<----------------------------
  static const String googleApiKey = 'AIzaSyBCi-I8dhVghsr20HVVyCfkxBpsXVe2O60';

  static const String googlePlaceBaseUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?';
  static const String googlePlaceDetailBaseUrl =
      'https://maps.googleapis.com/maps/api/place/details/json?';

  /// --------------------->>>>>  Base URL (Production)  <<<<<----------------------------
  static const String baseUrl = "https://rankup-backend-production.up.railway.app/api/v1/auth/";

  /// --------------------->>>>>  Auth APIs  <<<<<----------------------------
  static const String sendOtp = "${baseUrl}send-otp";
  static const String verifyOtp = "${baseUrl}verify-otp";
  static const String completeProfile = "${baseUrl}complete-profile";
  static const String profile = "${baseUrl}profile";
  static const String profileUpdate = "${baseUrl}profile-update";
}

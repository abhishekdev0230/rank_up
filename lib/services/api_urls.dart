class ApiUrls {
  ApiUrls._(); // private constructor

  /// --------------------->>>>>  Google Map Keys  <<<<<----------------------------
  static const String googleApiKey = 'AIzaSyBCi-I8dhVghsr20HVVyCfkxBpsXVe2O60';

  static const String googlePlaceBaseUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?';
  static const String googlePlaceDetailBaseUrl =
      'https://maps.googleapis.com/maps/api/place/details/json?';

  /// --------------------->>>>>  Base URL (Production)  <<<<<----------------------------
  static const String baseUrl = "https://rankup-backend-production.up.railway.app/api/v1/";

  /// --------------------->>>>>  Auth APIs  <<<<<----------------------------
  static const String sendOtp = "${baseUrl}auth/send-otp";
  static const String verifyOtp = "${baseUrl}auth/verify-otp";
  static const String completeProfile = "${baseUrl}auth/complete-profile";
  static const String profile = "${baseUrl}auth/profile";
  static const String profileUpdate = "${baseUrl}auth/profile-update";


  /// --------------------->>>>>  Flashcards APIs  <<<<<----------------------------
  static const String flashcardsClasses = "${baseUrl}flashcards/classes/:classCode/subjects";
  static const String flashcardsChapters = "${baseUrl}flashcards/subjects/:subjectId/chapters";
  static const String flashcardsTopics = "${baseUrl}flashcards/chapters/:chapterId/topics";
  static const String flashcardsTopicsView = "${baseUrl}flashcards/topics/:topicId/view";
  static const String flashcardsTopicsQuetions = "${baseUrl}flashcards/topic/:topicId";
  static const String flashcardsTopicsQuetionsprogress = "${baseUrl}flashcards/:flashcardId/progress";
  static const String flashcardsTopicsQuetionsCompletion = "${baseUrl}flashcards/topic/:topicId/completion";
  static const String bookmarks = "${baseUrl}bookmarks";
  ///..............profile.................
  static const String bookmarksListApi = "${baseUrl}bookmarks";
  static const String bookmarksListRemoveApi = "${baseUrl}bookmarks/:bookmarkId/remove";
  static const String suspendedCards = "${baseUrl}suspended-cards";
  static const String suspendedCardsRemove = "${baseUrl}suspended-cards/:progressId/remove";
  ///................terms privacy refund about............
  static const String staticPageBySlug = "${baseUrl}static-pages/slug/:slug";
  static const String faq = "${baseUrl}faq";

  /// --------------------->>>>>  home APIs  <<<<<----------------------------
  static const String homeDashboard = "${baseUrl}home/dashboard";
}

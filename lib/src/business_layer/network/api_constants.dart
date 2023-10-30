class ApiConstants {
  /// api URLs - start -------------------------------------------------
  /// Api URLS DEVELOPMENT
  static const urlDevServer = 'http://15.222.138.218:3001/v1/';
  static const devApiKey = '';

  /// Api URLS PRODUCTION
  static const urlProdServer = '';
  static const prodApiKey = '';

  /// Api URLS TESTING
  static const urlTestServer = 'http://15.222.137.237:3001/v1/';
  static const testApiKey = '';

  /// api URLs - end ---------------------------------------------------

  /// for checking network connection
  static const String googleLink = "google.com";

  /// api end_points - start ---------------------------------------------------

  static const String login = "users/login";
  static const String socialLogin = "users/socialLogin";
  static const String signup = "users/register";
  static const String emailOrPhoneVerification = "users/emailVerification";
  static const String phoneVerification = "users/phoneVerification";
  static const String serviceProvidersList = "serviceProviders/list";
  static const String forgotPassword = "users/forgetPassword";
  static const String resetPassword = "users/resetPassword";
  static const String userProfile = "users/userProfile";
  static const String updateUserProfile = "users/update";
  static const String updateImage = "users/upload";
  static const String getCmsData = "cms/";
  static const String getFAQData = "cms/faqs";
  static const String addAddress = "users/addAddress";
  static const String allAddress = "users/getAddress";
  static const String addFavourite = "serviceProviders/addFavServiceProvider";
  static const String myBookings = "bookings/list";
  static const String getNotification = "cms/getNotification";
  static const String logout = "users/logout";
  static const String resendOtp = "users/resendOtp";
  static const String homeBanner = "users/banner";

  static String deleteAddress(String? addressId) {
    return "users/removeAddress/$addressId";
  }

  /// passwords
  static const String changePassword = "/users/changePassword";

  /// booking
  static const String getAvailableSlots = "bookings/availableSlots";
  static const String payment = "bookings/payment";
  static const String getPropertyDetails = "bookings/getPropertyDetails";
  static const String createBooking = "bookings/create";
  static const String cancelBooking = "bookings/cancel";
  static const String addReviews = "serviceProviders/addReviews";
  static const String getSaveCards = "users/cards";
  static const String deleteSaveCard = "users/deleteCard";

  /// api end_points - end -----------------------------------------------------
}

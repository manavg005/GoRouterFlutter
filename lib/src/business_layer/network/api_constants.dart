class ApiConstants {
  /// api URLs - start -------------------------------------------------
  /// Api URLS DEVELOPMENT
  static const urlDevServer = 'http://15.222.138.218:3000/v1/';
  static const devApiKey = '';

  /// Api URLS PRODUCTION
  static const urlProdServer = '';
  static const prodApiKey = '';

  /// Api URLS TESTING
  static const urlTestServer = 'http://15.222.137.237:3000/v1/';
  static const testApiKey = '';

  /// api URLs - end ---------------------------------------------------

  /// for checking network connection
  static const String googleLink = "google.com";

  /// api end_points - start ---------------------------------------------------

  static const String login = "admin/login";
  static const String homeManagement = "admin/home-management";
  static const String userManagement = "admin/user-management";
  static const String cleanerManagement = "admin/cleaner-management";
  static const String bookingManagement = "admin/booking-management";
  static const String notificationManagement = "admin/list-notification";
  static const String paymentManagement = "admin/payment-management";
  static const String sendNotification = "admin/create-notification";

  static String userActiveInactive(String? userId) {
    return "admin/active-inactive-user/$userId";
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

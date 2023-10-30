// ignore_for_file: constant_identifier_names

class StringConstants {
  static const String NO_CONNECTION = "No Internet Connection";
  static const String SOMETHING_WENT_WRONG = "Something went wrong";
  static const String EMPTY = "";
  static const String TITLE = "KeyPit Kleen";
  static const String LOGO = "logo";

  static const String loginTypeApple = "Apple";
  static const String loginTypeGoogle = "Google";
  static const String loginTypeFacebook = "Facebook";

  static const String profileUpdateSuccess = "profileUpdateSuccess";
  static const String reviewAddedSuccess = "reviewAddedSuccess";

  static const String defaultDateTimeFormat = 'EEE, d MMM yy, hh:mm a';
  static const String defaultTimeFormat = 'hh:mm a';

  static const String companyID = 'companyID';
  static const String companyName = 'companyName';
  static const String productId = 'productId';
  static const String variantId = 'variantId';
  static const String categoryName = 'categoryName';
  static const String categoryId = 'categoryId';
  static const String all = 'All';
  static const String freeDelivery = 'Free Delivery';
  static const String primary = 'primary';
  static const String secondary = 'secondary';

  /// payment
  static const String paymentDecline = "Payment Declined";
  static const String paymentSuccess = "Payment Success";
  static const String paymentFailed = "Payment Failed";

  static const List<String> indiaStatesList = [
    "State",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Andaman and Nicobar Islands",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Chandigarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Lakshadweep",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Pondicherry",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
  ];
}

abstract class BookingStatus {
  //0: Awaiting,1: Accepted, 2:Ongoing,3: Complete, 4: Cancelled
  static int awaiting = 0;
  static int accepted = 1;
  static int ongoing = 2;
  static int completed = 3;
  static int cancelled = 4;

  /* static String getBookingStatus(int status) {
    if (status == awaiting) {
      return "Upcoming";
    }
    if (status == accepted) {
      return "Accepted";
    }
    if (status == ongoing) {
      return "Ongoing";
    }
    if (status == completed) {
      return "Completed";
    }
    if (status == cancelled) {
      return "Cancelled";
    }
    return "";
  }*/
}

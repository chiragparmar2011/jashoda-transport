class AppUrl {
  static const String baseUrl = 'https://truck-load.onrender.com/api/';

  /// Auth
  static const String sendOTP = "auth/send-otp";
  static const String register = "auth/register";
  static const String verifyOTP = "auth/verify-otp";
  static const String getUser = "auth/get-user-by-id";
  static const String updateUser = "auth/user-update";
  static const String recentCalculation = "truck-load/get-recent-truck-details";
  static const String loadCalculation = "truck-load/calculate-truck-load";
  static const String saveTruckLoad = "truck-load/save-truck-load";
  static const String fetchTruckDetail = "truck-load/get-truck-details";
  static const String fetchSingleTruck = "truck-load/get-truck-details-by-id";
}

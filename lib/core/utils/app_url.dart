class AppUrl {
  static const String baseUrl = 'https://tapload.onrender.com/api';

  /// Auth
  static const String sendOTP = "/auth/send-otp";
  static const String register = "/auth/register";
  static const String verifyOTP = "/auth/verify-otp";
  static const String updateUser = "/auth/user-update";
  static const String recentCalculation = "/truck-load/get-recent-truck-details";
  static const String loadCalculation = "/truck-load/create-load-calculation";
  static const String getTruckDetail = "/truck-load/get-truck-details";
}

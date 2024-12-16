class OtpVerificationResponse {
  final String message;
  final bool isRegistered;
  final String? userId;

  OtpVerificationResponse({
    required this.message,
    required this.isRegistered,
    this.userId,
  });
}
class ApiClient {
  static const String baseUrl = 'http://192.168.10.22:8001';
  static String get loginUrl => '$baseUrl/auth/login';
  static String get registrationUrl => '$baseUrl/auth/register';
  static String get activeAccUrl => '$baseUrl/auth/activate-account';
  static String get forgetPassUrl => '$baseUrl/auth/forgot-password';
  static String get resetPassUrl => '$baseUrl/auth/reset-password';
  static String get forgetPassOtpVerifyUrl => '$baseUrl/auth/forget-pass-otp-verify';
  static String get userProfileUrl => '$baseUrl/user/profile';
  static String get userEditProfileUrl => '$baseUrl/user/edit-profile';

}
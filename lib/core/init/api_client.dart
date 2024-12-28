class ApiClient {
  static const String baseUrl = 'http://192.168.10.22:8001';
  static String get loginUrl => '$baseUrl/auth/login';
  static String get registrationUrl => '$baseUrl/auth/register';
  static String get activeAccUrl => '$baseUrl/auth/activate-account';
  static String get forgetPassUrl => '$baseUrl/auth/forgot-password';
  static String get resetPassUrl => '$baseUrl/auth/reset-password';
  static String get forgetPassOtpVerifyUrl => '$baseUrl/auth/forget-pass-otp-verify';
  static String get userProfileUrl => '$baseUrl/user/my-profile';
  static String get createTaskUrl => '$baseUrl/task/create-task';
  static String get getAllTaskUrl => '$baseUrl/task/get-all-task';
  static String get deleteTaskUrl => '$baseUrl/task/delete-task/';
  static String get getSpecificTaskUrl => '$baseUrl/task/get-task/';
  static String get activeUserUrl => '$baseUrl/user/activate-user';
  static String get updateUserUrl => '$baseUrl/user/update-profile';
}
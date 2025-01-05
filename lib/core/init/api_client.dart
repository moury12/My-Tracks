class ApiClient {
  static const String baseUrl = 'http://192.168.12.75:8001';
  static String get loginUrl => '$baseUrl/auth/login';
  static String get registrationUrl => '$baseUrl/auth/register';
  static String get activeAccUrl => '$baseUrl/auth/activate-account';
  static String get forgetPassUrl => '$baseUrl/auth/forgot-password';
  static String get resetPassUrl => '$baseUrl/auth/reset-password';
  static String get changePassUrl => '$baseUrl/auth/change-password';
  static String get forgetPassOtpVerifyUrl => '$baseUrl/auth/forget-pass-otp-verify';
  static String get deleteProfileUrl => '$baseUrl/user/delete-account';
  static String get userProfileUrl => '$baseUrl/user/profile';
  static String get userEditProfileUrl => '$baseUrl/user/edit-profile';
  static String get categoryUrl => '$baseUrl/dashboard/get-all-category';
  static String get addBusinessTrackUrl => '$baseUrl/business/track';
  static String get updateTrackUrl => '$baseUrl/business/update-track';
  static String get createTrackSlotUrl => '$baseUrl/business/create-slot';
  static String get deleteSlotUrl => '$baseUrl/business/delete-slot';
  static String get getSingleBusinessUrl => '$baseUrl/business/get-single-business';
  static String get createEventUrl => '$baseUrl/business/event';
  static String get myBusinessUrl => '$baseUrl/business/my-business';
  static String get getParticipantsUrl => '$baseUrl/business/view-all-participants';


}
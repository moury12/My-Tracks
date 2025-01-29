class ApiClient {
  static const String baseUrl = 'http://10.0.60.26:8001';
  static const String baseUrlWithoutPort = 'http://10.0.60.26';
  static String get loginUrl => '$baseUrl/auth/login';
  static String get registrationUrl => '$baseUrl/auth/register';
  static String get activeAccUrl => '$baseUrl/auth/activate-account';
  static String get forgetPassUrl => '$baseUrl/auth/forgot-password';
  static String get resetPassUrl => '$baseUrl/auth/reset-password';
  static String get changePassUrl => '$baseUrl/auth/change-password';
  static String get forgetPassOtpVerifyUrl =>
      '$baseUrl/auth/forget-pass-otp-verify';
  static String get deleteProfileUrl => '$baseUrl/user/delete-account';
  static String get userProfileUrl => '$baseUrl/user/profile';
  static String get userEditProfileUrl => '$baseUrl/user/edit-profile';
  static String get categoryUrl => '$baseUrl/dashboard/get-all-category';
  static String get addBusinessTrackUrl => '$baseUrl/business/track';
  static String get updateTrackUrl => '$baseUrl/business/update-track';
  static String get createTrackSlotUrl => '$baseUrl/business/create-slot';
  static String get deleteSlotUrl => '$baseUrl/business/delete-slot';
  static String get getSingleBusinessUrl =>
      '$baseUrl/business/get-single-business';
  static String get createEventUrl => '$baseUrl/business/event';
  static String get getBookingUrl => '$baseUrl/business/get-booking';
  static String get myBusinessUrl => '$baseUrl/business/my-business';
  static String get searchForSlotUrl => '$baseUrl/business/search-for-slots';
  static String get getAllBusinessUrl => '$baseUrl/business/all-business';
  static String get getBookASlotUrl => '$baseUrl/business/book-a-slot';
  static String get getJoinEventUrl => '$baseUrl/business/join-event';
  static String get promoteTrackUrl => '$baseUrl/business/get-promoted-tracks';
  static String get getParticipantsUrl =>
      '$baseUrl/business/view-all-participants';
  static String get activeDeactivateUrl =>
      '$baseUrl/business/active-deactivate-track';
  static String get getNotificationUrl =>
      '$baseUrl/business/get-all-notifications';
  static String get getAllRentersOnDateUrl =>
      '$baseUrl/business/renters-on-date';

  static String get getLikeDisLikeUrl => '$baseUrl/review/like-dislike';
  static String get postReviewUrl => '$baseUrl/review/post-review';
  static String get getAllReviewUrl => '$baseUrl/review/get-all-review';
  static String get postFeedbackUrl => '$baseUrl/feedback/post-feedback';
  static String get paymentCheckoutUrl => '$baseUrl/payment/checkout-booking';
  static String get getTermsConditionUrl =>
      '$baseUrl/manage/get-terms-conditions';
  static String get getPrivacyPolicy => '$baseUrl/manage/get-privacy-policy';
  static String get checkoutPromotionUrl =>
      '$baseUrl/payment/checkout-promotion';
  static String get getSinglePayoutUrl =>
      '$baseUrl/payment/get-single-payout-info';
  static String get paymentOnboardingUrl =>
      '$baseUrl/payment/onboarding';
}

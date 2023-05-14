class DataSourceURL {
  // static String baseUrl = 'https://app.top1ive.com/api/';
  // static String baseImagesUrl = 'https://app.top1ive.com/';

  static String baseUrl = 'http://192.168.2.112/api/';
  static String baseImagesUrl = 'http://192.168.2.112/';

  ///necessary
  static String checkExistAccount = 'check/exist/account';
  static String checkUniqueAccount = 'check/unique/account';
  static String editPassword = 'edit/password';
  static String editPin = 'edit/pin';
  static String forgetPin = 'forget/pin';
  static String signup = 'signup';
  static String login = 'login';
  static String verifyAndLogin = 'verify/and/login';
  static String changePhone = 'change/phone';
  static String reSendEmailVerifyCodeEvent = 'reSend/email/verify/codeEvent';
  static String changeEmail = 'change/email';
  static String logout = 'logout';
  static String editUserDetails = 'edit/user/details';
  static String phoneAuthSendOTP = 'phone-auth/sendOTP/';
  static String checkOTPCode = 'check/OTP/code';
  static String createUserInvitationUrl = 'create/user/invitation/url';

  ///PROFILE
  static String getAllProfilePlatforms = 'get/all/profile/platforms';
  static String getAllNationalities = 'get/all/nationalities';
  static String getAllIdentificationType = 'get/all/identification/types';
  static String updateSingleInfo = 'update/single/info';
  static String getProfileAttachments = 'get/profile/attachments';
  static String addNewProfileAttachments = 'add/new/profile/attachments';
  static String deleteProfileAttachments = 'delete/profile/attachments';

  /// MAIN MENU
  static String getAllAdds = 'get/all/adds';
  static String getAllProductionsGroups = 'get/all/productions/groups';
  static String getProductionsGroupsPlatforms =
      'get/productions/groups/platforms';
  static String getPlatformsCategories = 'get/platforms/categories';

  ///Charging Requests
  static String addNewOrder = 'add/new/order';
  static String checkCopon = 'check/copon';
  static String getUserChargingRequests = 'get/user/charging/request';
  static String getCustomersChargingRequests = 'get/customers/charging/request';
  static String acceptConfirmChargingRequests =
      'accept/confirm/charging/request';

  ///Wallet
  static String getCurrencies = 'get/currencies';
  static String getBanks = 'get/banks';
  static String feedWalletRequest = 'feed/wallet/request';
  static String updateFeedWalletRequest = 'update/feed/wallet/request';
  static String getUserFeedWalletUploadedRequests =
      'get/user/feed/wallet/requests';
  static String getCustomerFeedWalletUploadedRequests =
      'get/customers/feed/wallet/requests';

  static String acceptConfirmNewFeedWalletRequest =
      'accept/confirm/new/feed/wallet/requests';

  ///platform
  static String getAllPartnerAccessiblePlatform =
      'get/all/partner/accessible/platform';

  static String getAllPartnerPlatformsWithBroadcastersCount =
      'get/all/partner/platforms/with/broadcasters/count';

  ///broadcaster
  static String addBroadcasterToPartner = 'add/broadcaster/to/partner/request';

  ///partners
  static String getAllPartners = 'get/all/partners';
  static String getPartnerBroadcaster = 'get/partner/broadcasters';

  ///ExchangeMoney
  static String getTransformingDetails = 'get/transforming/details';
  static String getMyTransfersMoney = 'get/my/exchange/money/processes';
  static String pushMoney = 'push/money';
  static String pullMoney = 'pull/money';

  ///notifications
  static String getUserNotifications = 'get/user/notifications';
  static String deactivateNotification = 'deactivate/notification';

  ///customer service
  static String getCustomerServiceData = 'get/customer/service/data';
}
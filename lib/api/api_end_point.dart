class ApiEndPoints {
  static const baseUrl = 'https://marketpleacesbackend.vercel.app/api';
  static const sendOtp = '$baseUrl/user/send-otp';
  static const otpVerify = '$baseUrl/user/login';
  static const customerRegistration = '$baseUrl/customer/register';
  static const profile = '$baseUrl/customer/get_details';
  static const dashboard = '$baseUrl/customer/dashboard';
  static getVendors(String? category, String? type, String? search) =>
      '$baseUrl/customer/getVendor?category=$category&name=$search&type=$type';
  static  vendorDetails(String vendorId, String userId) => '$baseUrl/customer/getVendorbyId/$vendorId?user_id=$userId';
  static  offersDetails(String offerId, String userId) => '$baseUrl/customer/offer/get_details/$offerId?user_id=$userId';
  static const  makePayment = '$baseUrl/customer/add_payment';
  static const  fetchPurchasedOffers = '$baseUrl/customer/brought-offer';












  ///=================>>
  static const updateMerchantBusiness = '$baseUrl/vendor/update';
  static const merchantCategory = '$baseUrl/vendor/categroy';
  static const merchantSubCategory = '$baseUrl/vendor/sub_categroy';
  static const addOffers = '$baseUrl/offer/add';
  static const getUserProfile = '$baseUrl/get-user';
  static const updateProfile = '$baseUrl/update-user';
  static const createReport = '$baseUrl/issues/report/create';
  static const issueReportHistory = '$baseUrl/issues/report/history';
  static const issueReportDetails = '$baseUrl/issues/report/detail';
  static const startDeliver = '$baseUrl/delivery/tracking/start';
  static const updateCordinete = '$baseUrl/delivery/tracking/update';
  static const completeDelivery = '$baseUrl/delivery/tracking/close';
  static const sosCreate = '$baseUrl/sos/create';
  static const sosHistory = '$baseUrl/sos/history';
  static const cancelSos = '$baseUrl/sos/cancel';
  static const notificationList = '$baseUrl/notification/list';
  static const readNotification = '$baseUrl/notification/read';
  static const allowNotifications = '$baseUrl/notification/setting/edit';
  static const notificationTypes = '$baseUrl/notification/setting/list';
  static const helpSupport = '$baseUrl/help/support';
}

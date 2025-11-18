class ApiEndPoints {
  // static const baseUrl = 'https://marketpleacesbackend.vercel.app/api';
  static const baseUrl = 'https://mktplace.fpdemo.com/api';
  static const sendOtp = '$baseUrl/user/send-otp';
  static const otpVerify = '$baseUrl/user/login';
  static const customerRegistration = '$baseUrl/customer/register';
  static const profile = '$baseUrl/customer/get_details';
  static const dashboard = '$baseUrl/customer/dashboard';

  static getVendors(String? category, String? type, String? search, int page) =>
      '$baseUrl/customer/getVendor?category=$category&name=$search&type=$type&page=$page';

  static vendorDetails(String vendorId, String userId) =>
      '$baseUrl/customer/getVendorbyId/$vendorId?user_id=$userId';

  static offersDetails(String offerId, String userId) =>
      '$baseUrl/customer/offer/get_details/$offerId?user_id=$userId';
  static const makePayment = '$baseUrl/customer/add_payment';
  static const fetchPurchasedOffers = '$baseUrl/customer/brought-offer';
  static const purchasedOffersDetails = '$baseUrl/customer/brought-offer';
  static const updateBillAmount = '$baseUrl/customer/payment/update';
  static const updateProfile = '$baseUrl/customer/update';
  static const privacyPolicyPage =
      'https://marketplacesfronted.vercel.app/privacy-policy';
  static const termsPolicyPage = 'https://marketplacesfronted.vercel.app/terms';
  static const helpSupportPage =
      'https://marketplacesfronted.vercel.app/support';

  static const orderHistory = '$baseUrl/customer/redeemed-offer?page=';
  static const saveBill = '$baseUrl/customer/bill-add';

  static const updateMobile = '$baseUrl/customer/phone-update';


}

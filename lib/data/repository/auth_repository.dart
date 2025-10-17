
import 'package:market_place_customer/data/models/profile_model.dart';
import 'package:market_place_customer/data/models/user_otp_modal.dart';
import 'package:market_place_customer/utils/exports.dart';

class AuthRepository {
  final api = ApiManager();
  Future<UserModel?> loginUser(
      {required BuildContext context, required String mobileNumber}) async {
    var data = {'phone': mobileNumber};
    final result =
        await api.post(url: ApiEndPoints.sendOtp, data: data, useToken: false);
    if (result is String) {
      snackBar(context, result, AppColors.redColor);
      return null;
    } else {
      return UserModel.fromJson(result);
    }
  }

  /// otp verify
  Future<UserOtpModal?> otpVerify(
      {required BuildContext context,
      required String mobile,
      required String roleType,
      required String otp}) async {
    var data = {
      "phone": mobile.toString(),
      "otp": otp.toString(),
      'role': roleType.toString()
    };

    final result = await api.post(url: ApiEndPoints.otpVerify, data: data);

    print('------>>>>$result');

    if (result is String) {
      snackBar(context, result, AppColors.redColor);
      return null;
    } else {
      return UserOtpModal.fromJson(result);
    }
  }

  /// customer registration
  Future customerRegistration(
      {required BuildContext context,
      required CustomerSignupEvent customer}) async {
    var data = {
      "name": customer.customer.name,
      "phone": customer.customer.mobile,
      "email": customer.customer.email,
    };

    print('data--------->>>>>>$data');

    final result =
        await api.post(url: ApiEndPoints.customerRegistration, data: data);
    print('--rr------->>>>>>$result');
    if (result is String) {
      return result;
    } else {
      return CustomerSignupModel.fromJson(result);
    }
  }

  /// update customer profile
  Future updateCustomerProfile(
      {required BuildContext context,
      required CustomerRegistrationModel customer}) async {
    var data = {
      "name": customer.name,
      "email": customer.email,
      "phone": customer.mobile,
      "image": customer.img
    };
    print('JSON===>>>$data');
    final result = await api.post(
        url: ApiEndPoints.updateMerchantBusiness, data: data, context: context);
    if (result is String) {
      snackBar(context, result, AppColors.redColor);
      return null;
    } else {
      return CustomerSignupModel.fromJson(result);
    }
  }




  /// fetch profile data
  Future fetchProfile(BuildContext context) async {
    final result =
        await api.get(url: ApiEndPoints.profile, context: context);

    print("RES ==> $result");
    if (result is String) {
      return result;
    } else {
      return ProfileModel.fromJson(result);
    }
  }
}

import 'package:market_place_customer/data/models/update_mobile_model.dart';
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
      "email": customer.customer.email
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

  /// otp verify
  Future<UpdateMobileNumberModel?> updateMobile(
      {required BuildContext context,
      required String mobile,
      required String otp}) async {
    var data = {"phone": mobile.toString(), "otp": otp.toString()};

    final result = await api.post(
        url: ApiEndPoints.updateMobile, data: data, useToken: true);
    print('------>>>>$result');
    if (result is String) {
      return throw Exception(result.toString());
    } else {
      return UpdateMobileNumberModel.fromJson(result);
    }
  }
}

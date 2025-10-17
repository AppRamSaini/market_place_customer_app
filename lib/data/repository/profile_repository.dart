import 'package:dio/dio.dart';
import 'package:market_place_customer/data/models/user_profile_model.dart';
import 'package:market_place_customer/utils/exports.dart';

class ProfileRepository {
  final api = ApiManager();

  /// get user profile
  Future<UserProfileModel?> getUserProfile(BuildContext context) async {
    final result = await api.get(url: ApiEndPoints.getUserProfile);
    print('----profile------>>>>>$result');

    if (result is String) {
      snackBar(context, result, AppColors.redColor);
      return null;
    } else {
      return UserProfileModel.fromJson(result);
    }
  }

  ///  update profile api
  Future updateProfile(BuildContext context, var data) async {
    final result = await api.post(url: ApiEndPoints.updateProfile, data: data);
    print('---------->>>>>$result');

    if (result is String) {
      snackBar(context, result, AppColors.redColor);
    } else {
      return result;
    }
  }
}

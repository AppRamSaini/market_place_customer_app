import 'package:market_place_customer/utils/exports.dart';

class ProfileRepository {
  final api = ApiManager();

  /// get user profile
  /// fetch profile data
  Future fetchProfile(BuildContext context) async {
    final result = await api.get(url: ApiEndPoints.profile, context: context);
    print("RES ==> $result");
    if (result is String) {
      return result;
    } else {
      return ProfileModel.fromJson(result);
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

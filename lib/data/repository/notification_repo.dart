import 'package:market_place_customer/data/models/get_notification_model.dart';

import 'package:market_place_customer/data/models/support_model.dart';
import 'package:market_place_customer/utils/exports.dart';

class NotificationsRepository {
  final api = ApiManager();

  /// fetch notifications
  Future fetchNotifications() async {
    final result = await api.get(url: ApiEndPoints.notificationList);
    if (result is String) {
      return result;
    } else {
      return GetNotificationModel.fromJson(result);
    }
  }

  ///  read notification  counts api
  Future readNotificationCountsApi(BuildContext context) async {
    final result = await api.get(url: ApiEndPoints.readNotification);
    if (result is String) {
      snackBar(context, result, AppColors.redColor);
    } else {
      return result;
    }
  }




  /// get support details
  Future fetchSupportDetails(BuildContext context) async {
    final result = await api.get(url: ApiEndPoints.helpSupport);
    if (result is String) {
      snackBar(context, result, AppColors.redColor);
      return null;
    } else {
      return HelpSupportModel.fromJson(result);
    }
  }
}

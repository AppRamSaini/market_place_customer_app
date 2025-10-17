
import 'package:market_place_customer/utils/exports.dart';

abstract class NotificationsEvent {}

class FetchNotificationsEvent extends NotificationsEvent {
  final BuildContext context;
  FetchNotificationsEvent({required this.context});
}

class FetchNotificationsTypesEvent extends NotificationsEvent {
  final BuildContext context;
  FetchNotificationsTypesEvent({required this.context});
}

class UpdateNotificationSubmitted extends NotificationsEvent {
  final String notificationId;
  final String status;
  final BuildContext context;
  UpdateNotificationSubmitted({required this.context,required this.status,required this.notificationId});
}

class ReadCountsNotificationApi extends NotificationsEvent {
  final String status;
  final BuildContext context;
  ReadCountsNotificationApi({required this.context,required this.status});
}




class ReadNotificationEvent extends NotificationsEvent {
  final BuildContext context;
  ReadNotificationEvent({required this.context});
}





class FetchPrivacyEvent extends NotificationsEvent {
  final BuildContext context;
  FetchPrivacyEvent({required this.context});
}
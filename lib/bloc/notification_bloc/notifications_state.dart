import 'package:market_place_customer/data/models/get_notification_model.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {
  final GetNotificationModel getNotificationModel;
  NotificationsSuccess({required this.getNotificationModel});
}

class NotificationsInvalidResult extends NotificationsState {}

/// for update notification bloc
abstract class UpdateNotificationsState {}

class ReadNotificationLoading extends UpdateNotificationsState {}

class ReadNotificationSuccess extends UpdateNotificationsState {}

class UpdateNotificationsInvalidResult extends UpdateNotificationsState {}

class UpdateNotificationsFailure extends UpdateNotificationsState {
  final String error;
  UpdateNotificationsFailure({required this.error});
}

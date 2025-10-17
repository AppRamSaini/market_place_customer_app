import 'package:market_place_customer/bloc/notification_bloc/notifications_event.dart';
import 'package:market_place_customer/bloc/notification_bloc/notifications_state.dart';
import 'package:market_place_customer/data/models/get_notification_model.dart';
import 'package:market_place_customer/data/repository/notification_repo.dart';
import 'package:market_place_customer/utils/exports.dart';
//
// class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
//   final notificationRepo = NotificationsRepository();
//
//   NotificationsBloc() : super(NotificationsInitial()) {
//     on<FetchNotificationsEvent>(_onFetchNotifications);
//   }
//
// }
// class NotificationsUpdateBloc
//     extends Bloc<NotificationsEvent, UpdateNotificationsState> {
//   final notificationRepo = NotificationsRepository();
//
//   // NotificationsUpdateBloc() : super(NotificationsUpdateInitial()) {
//   //   on<ReadNotificationEvent>(_onReadNotification);
//   // }
//
//
//
//   Future _onReadNotification(ReadNotificationEvent event,
//       Emitter<UpdateNotificationsState> emit) async {
//     emit(ReadNotificationLoading());
//     try {
//       final notification =
//           await notificationRepo.readNotificationCountsApi(event.context);
//       if (notification != null) {
//         emit(ReadNotificationSuccess());
//       } else {
//         emit(UpdateNotificationsInvalidResult());
//       }
//     } catch (e) {
//       emit(UpdateNotificationsFailure(error: e.toString()));
//     }
//   }
// }

// import 'package:market_place_customer/bloc/notification_bloc/notifications_event.dart';
// import 'package:market_place_customer/bloc/notification_bloc/notifications_state.dart';
// import 'package:market_place_customer/utils/exports.dart';
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   @override
//   void initState() {
//     super.initState();
//     onRefresh();
//   }
//
//   Future<void> onRefresh() async {
//     // context
//     //     .read<NotificationsBloc>()
//     //     .add(FetchNotificationsEvent(context: context));
//   }
//
//   Future<void> readNotificationApiCall() async {
//     // context
//     //     .read<NotificationsUpdateBloc>()
//     //     .add(ReadNotificationEvent(context: context));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         onRefresh();
//         return true;
//       },
//       child: BlocListener<NotificationsBloc, NotificationsState>(
//         listener: (_, state) {
//           if (state is NotificationsSuccess) {
//             readNotificationApiCall();
//           }
//         },
//         child: Scaffold(
//           appBar: customAppbar(title: "Notification",context: context),
//           body: RefreshIndicator(
//             onRefresh: onRefresh,
//             child: BlocBuilder<NotificationsBloc, NotificationsState>(
//               builder: (context, state) {
//                 if (state is NotificationsLoading) {
//                   return notificationShimmerLoading();
//                 } else if (state is NotificationsFailure) {
//                   return Center(
//                       child: Text(state.error.toString(),
//                           style: AppStyle.medium_14(AppColors.redColor)));
//                 } else if (state is NotificationsSuccess) {
//                   final data = state.getNotificationModel.data;
//                   if (data!.notification!.isEmpty) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Image.asset(Assets.loginImg,
//                               height: size.height * 0.3,
//                               width: size.width * 0.6,
//                               fit: BoxFit.fill),
//                           SizedBox(height: size.height * 0.02),
//                           Text("No Notifications Found!",
//                               style: AppStyle.medium_16(AppColors.redColor)),
//                         ],
//                       ),
//                     );
//                   }
//
//                   return ListView.builder(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: size.width * 0.03),
//                       itemCount: data.notification!.length,
//                       itemBuilder: (_, index) {
//                         var dataList = data.notification;
//                         var date = formatDateFromString(
//                             dataList![index].createdAt!.toString());
//
//                         print('<>>>>>>>>>>>>>>>>>${dataList[index].title}');
//
//                         return Card(
//                           margin: EdgeInsets.only(top: 10),
//                           color: AppColors.white10,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           child: ListTile(
//                             dense: true,
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: size.width * 0.02),
//                             title: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(dataList![index].title!.toString() ?? '',
//                                     style: AppStyle.medium_14(
//                                         AppColors.themeColor)),
//                                 Text(date.toString(),
//                                     style:
//                                         AppStyle.normal_10(AppColors.redColor))
//                               ],
//                             ),
//                             subtitle: Text(dataList[index].content ?? '',
//                                 style:
//                                     AppStyle.normal_12(AppColors.blackColor)),
//                             leading: CircleAvatar(
//                               backgroundColor: AppColors.themeColor,
//                               child: Icon(Icons.notifications_none,
//                                   color: AppColors.whiteColor),
//                             ),
//                           ),
//                         );
//                       });
//                 } else {
//                   return SizedBox();
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

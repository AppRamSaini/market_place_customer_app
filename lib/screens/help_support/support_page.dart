import 'package:market_place_customer/bloc/support_bloc/support_bloc.dart';
import 'package:market_place_customer/bloc/support_bloc/support_event.dart';
import 'package:market_place_customer/bloc/support_bloc/support_state.dart';
import 'package:market_place_customer/utils/exports.dart';
import 'package:market_place_customer/utils/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  Future<void> onRefresh() async {
    context.read<SupportBloc>().add(FetchSupportEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "Help & Support"),
/*
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
              heroTag: '2',
              backgroundColor: AppColors.themeColor1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              onPressed: () {
                String? userId = LocalStorage.getString(Pref.userId);
                String? driverName = LocalStorage.getString(Pref.userName);
                final String supportId = 'support_001';
                String chatId =
                    generateChatId(userId.toString(), supportId);
                print('----->>>$userId');

                AppRouter().navigateTo(
                    context,
                    DriverChatMessagePage(
                        driverName: driverName.toString(),
                        chatId: chatId,
                        supportUid: supportId,
                        driverUid: userId.toString(),
                        currentUserId: userId.toString()));
              },
              child: Icon(Icons.chat, color: AppColors.whiteColor)),
          if (_unreadCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
                child: Text(
                  '$_unreadCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
*/
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: BlocBuilder<SupportBloc, SupportState>(
          builder: (context, state) {
            if (state is SupportLoading) {
              return Center(child: notificationShimmerLoading());
            } else if (state is SupportFailure) {
              return Center(
                  child: Text(state.error.toString(),
                      style: AppStyle.medium_14(AppColors.redColor)));
            } else if (state is SupportSuccess) {
              final data = state.helpSupportModel;

              return Column(
                children: [
                  supportWidget(
                      title: "Support Team Contact",
                      subtitle: data.phone ?? '',
                      icon: Icons.phone,
                      onTap: () => launchPhone(data.phone ?? '')),
                  supportWidget(
                    title: "Support Email",
                    subtitle: data.email ?? '',
                    icon: Icons.email_outlined,
                    onTap: () => launchEmail(
                      toEmail: data.email ?? 'example@gmail.com',
                    ),
                  )
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

Widget supportWidget(
        {IconData? icon,
        String? subtitle,
        String? title,
        void Function()? onTap}) =>
    Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: AppColors.whiteColor,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
            backgroundColor: AppColors.themeColor,
            child: Icon(icon, color: AppColors.whiteColor)),
        title: Text(title.toString(),
            style: AppStyle.normal_16(AppColors.themeColor)),
        subtitle: Text(
          subtitle.toString(),
          style: AppStyle.normal_14(AppColors.blackColor),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: AppColors.themeColor,
        ),
      ),
    );

import 'package:market_place_customer/screens/location/search_location.dart';
import 'package:market_place_customer/utils/exports.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DetectLocation extends StatefulWidget {
  const DetectLocation({super.key});
  @override
  State<DetectLocation> createState() => _DetectLocationState();
}

class _DetectLocationState extends State<DetectLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(Assets.gegStarted))),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            AppColors.transparent,
            AppColors.blackColor.withOpacity(0.2)
          ])),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
            child: Padding(
              padding: globalBottomPadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Set your location to browse high rated & top offers vendors around you",
                    textAlign: TextAlign.center,
                    style: AppStyle.normal_16(AppColors.white80),
                  ).animate().fadeIn(duration: 800.ms, delay: 0.ms),
                  SizedBox(height: size.height * 0.02),
                  CustomButton3(
                      onPressed: () {
                        print('object');
                        EasyLoading.show(status: "Please wait...");
                        LocalStorage.setString(Pref.location,
                            "Devi Marg, Bani Park, Jaipur - 302006, Rajasthan, India");
                        Future.delayed(const Duration(seconds: 4), () {
                          AppRouter().navigateAndClearStack(
                              context, const CustomerDashboard());
                          // AppRouter().navigateTo(context, const LoginScreen());
                          EasyLoading.dismiss();
                        });
                      },
                      minWidth: size.width * 0.4,
                      txt: "Detect My Location",
                      bgColor: AppColors.yellowColor),
                  SizedBox(height: size.height * 0.01),
                  TextButton(
                    onPressed: () => AppRouter()
                        .navigateTo(context, const SearchLocationPage()),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Set Location Manually",
                                    style: AppStyle.medium_14(
                                        AppColors.whiteColor)),
                                const SizedBox(height: 1),
                                Container(
                                  height: 1,
                                  width: 150,
                                  color: AppColors.white50,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 1200.ms, delay: 0.ms),
                  ),
                  SizedBox(height: size.height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

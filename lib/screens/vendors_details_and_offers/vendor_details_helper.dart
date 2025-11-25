import 'package:market_place_customer/data/models/vendor_details_model.dart';

import '../../utils/exports.dart';

class OffersDataCardWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String amount;
  final String offerText;
  final double imgHeight;
  final double imgWidth;
  final bool isExpired;
  final bool isPurchased;

  const OffersDataCardWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.amount,
    required this.offerText,
    required this.imgHeight,
    required this.imgWidth,
    required this.isExpired,
    required this.isPurchased,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background image
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: FadeInImage.assetNetwork(
            placeholder: Assets.dummy,
            image: imageUrl,
            fit: BoxFit.cover,
            height: imgHeight,
            width: imgWidth,
            imageErrorBuilder: (_, __, ___) => Image.asset(
              Assets.dummy,
              fit: BoxFit.cover,
              height: imgHeight,
              width: imgWidth,
            ),
          ),
        ),

        /// Offer details (bottom text)
        Container(
          width: size.width,
          height: imgHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [AppColors.transparent, AppColors.black50])),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: size.height * 0.02),
                  child: offerChipAndFavoriteWidget(offerText)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: AppStyle.medium_14(AppColors.whiteColor),
                            overflow: TextOverflow.ellipsis),
                        Text(amount,
                            style: AppStyle.medium_13(AppColors.parrot)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // /// Purchased Badge
        // if (isPurchased)
        //   Positioned(
        //     top: 10,
        //     right: -25,
        //     child: FadeInDown(
        //       duration: const Duration(milliseconds: 700),
        //       child: Transform.rotate(
        //         angle: 0.5,
        //         child: Container(
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
        //           color: Colors.green.withOpacity(0.8),
        //           child: const Text(
        //             "PURCHASED",
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 12,
        //                 fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),

        /// Expired Overlay
        if (isExpired)
          AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 700),
            child: Container(
              height: imgHeight,
              width: imgWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.black50,
              ),
              child: Center(
                child: BounceInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "OFFER EXPIRED",
                      style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// vendor open & close time format

String getTodayTiming(Timing timing) {
  final now = DateTime.now();
  final days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  final todayKey = days[now.weekday % 7];

  // --- Weekly Off Fix ----
  bool isWeeklyOff = false;
  if (timing.weeklyOffDay != null && timing.weeklyOffDay!.isNotEmpty) {
    final offDate = DateTime.parse(timing.weeklyOffDay!); // <-- FIX
    if (offDate.year == now.year &&
        offDate.month == now.month &&
        offDate.day == now.day) {
      isWeeklyOff = true;
    }
  }

  if (isWeeklyOff) return "Today Closed";

  DayHour? todayTiming;
  switch (todayKey) {
    case "Mon":
      todayTiming = timing.openingHours?.mon;
      break;
    case "Tue":
      todayTiming = timing.openingHours?.tue;
      break;
    case "Wed":
      todayTiming = timing.openingHours?.wed;
      break;
    case "Thu":
      todayTiming = timing.openingHours?.thu;
      break;
    case "Fri":
      todayTiming = timing.openingHours?.fri;
      break;
    case "Sat":
      todayTiming = timing.openingHours?.sat;
      break;
    case "Sun":
      todayTiming = timing.openingHours?.sun;
      break;
  }

  if (todayTiming == null ||
      todayTiming.active == false ||
      todayTiming.open == null ||
      todayTiming.close == null) {
    return "Today Closed";
  }

  String formatTime(String time) {
    final parts = time.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    String suffix = hour >= 12 ? "PM" : "AM";
    hour = hour > 12 ? hour - 12 : hour;
    if (hour == 0) hour = 12;
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $suffix";
  }

  return "Open : ${formatTime(todayTiming.open!)}  |  Close : ${formatTime(todayTiming.close!)}";
}

String formatTime(String time) {
  final parts = time.split(":");
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);
  String suffix = hour >= 12 ? "PM" : "AM";
  hour = hour > 12 ? hour - 12 : hour;
  if (hour == 0) hour = 12;
  return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $suffix";
}

String getDayTiming(DayHour? d) {
  if (d == null || d.active == false || d.open == null || d.close == null) {
    return "Closed";
  }
  return "Open ${formatTime(d.open!)} | Close ${formatTime(d.close!)}";
}

Map<String, String> getAllWeekTimings(Timing timing) {
  return {
    "Monday": getDayTiming(timing.openingHours?.mon),
    "Tuesday": getDayTiming(timing.openingHours?.tue),
    "Wednesday": getDayTiming(timing.openingHours?.wed),
    "Thursday": getDayTiming(timing.openingHours?.thu),
    "Friday": getDayTiming(timing.openingHours?.fri),
    "Saturday": getDayTiming(timing.openingHours?.sat),
    "Sunday": getDayTiming(timing.openingHours?.sun),
  };
}

String getTodayTitleText(Timing timing) {
  final now = DateTime.now();
  final weekdayNames = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  final todayKey = weekdayNames[now.weekday % 7];

  // Weekly Off
  if (timing.weeklyOffDay != null && timing.weeklyOffDay!.isNotEmpty) {
    final offDate = DateTime.parse(timing.weeklyOffDay!);
    if (offDate.year == now.year &&
        offDate.month == now.month &&
        offDate.day == now.day) {
      return "Today : Closed";
    }
  }

  DayHour? todayTiming;
  switch (todayKey) {
    case "Monday":
      todayTiming = timing.openingHours?.mon;
      break;
    case "Tuesday":
      todayTiming = timing.openingHours?.tue;
      break;
    case "Wednesday":
      todayTiming = timing.openingHours?.wed;
      break;
    case "Thursday":
      todayTiming = timing.openingHours?.thu;
      break;
    case "Friday":
      todayTiming = timing.openingHours?.fri;
      break;
    case "Saturday":
      todayTiming = timing.openingHours?.sat;
      break;
    case "Sunday":
      todayTiming = timing.openingHours?.sun;
      break;
  }

  if (todayTiming == null ||
      todayTiming.active == false ||
      todayTiming.open == null ||
      todayTiming.close == null) {
    return "Today : Closed";
  }

  return "Today : Open ${formatTime(todayTiming.open!)} | Close ${formatTime(todayTiming.close!)}";
}

String? getExtraHolidayText(Timing timing) {
  if (timing.weeklyOffDay == null || timing.weeklyOffDay!.isEmpty) return null;
  final date = DateTime.parse(timing.weeklyOffDay!);
  final formatted = "${date.day} ${_monthName(date.month)} ${date.year}";
  return "Extra Holiday : ${_weekdayName(date.weekday)}   $formatted";
}

String _weekdayName(int day) {
  const names = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  return names[day % 7];
}

String _monthName(int m) {
  const months = [
    "",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  return months[m];
}

/// Custom Expansion Tile
Widget customExpansionTile(
        {required BuildContext context,
        required String txt,
        required String subTitle,
        List<Widget> children = const <Widget>[]}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.theme5),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          dense: true,
          initiallyExpanded: true,
          backgroundColor: AppColors.transparent,
          childrenPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(txt, style: AppStyle.medium_16(AppColors.black20)),
          subtitle: Text(subTitle ?? "Tap to expand",
              style: AppStyle.normal_12(AppColors.black20)),
          children: children,
        ),
      ),
    );

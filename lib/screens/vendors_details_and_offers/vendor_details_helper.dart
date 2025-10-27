import 'package:market_place_customer/data/models/vendor_details_model.dart';

import '../../utils/exports.dart';

class OffersDataCardWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String amount;
  final String offerText;
  final double imgHeight;
  final double imgWidth;
  const OffersDataCardWidget(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.amount,
      required this.offerText,required this.imgHeight,required this.imgWidth,
      });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(10), bottom: Radius.circular(10)),
          child: FadeInImage(
            fit: BoxFit.cover,
            height: imgHeight,
            width: imgWidth,
            placeholder: const AssetImage(Assets.dummy),
            image: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : const AssetImage(Assets.dummy) as ImageProvider,
            imageErrorBuilder: (_, child, st) => Image.asset(Assets.dummy,
                height: imgHeight, fit: BoxFit.cover, width: imgWidth),
          ),
        ),
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
                child: offerChipAndFavoriteWidget(offerText),
              ),
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
        )
      ],
    );
  }
}


/// vendor open & close time format

String getTodayTiming(Timing timing) {
  final now = DateTime.now();

  // आज का दिन निकालो (Mon, Tue, Wed ...)
  final days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  final todayKey = days[now.weekday % 7]; // Sunday को handle करने के लिए

  // 🔹 Step 1: Check Weekly Off Day
  bool isWeeklyOff = false;
  if (timing.weeklyOffDay != null) {
    final offDate = timing.weeklyOffDay!;
    if (offDate.year == now.year &&
        offDate.month == now.month &&
        offDate.day == now.day) {
      isWeeklyOff = true;
    }
  }

  if (isWeeklyOff) {
    return "Today Closed";
  }

  // 🔹 Step 2: आज का Opening Hour ऑब्जेक्ट निकालो
  Fri? todayTiming;
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

  // 🔹 Step 3: अगर आज बंद है या डेटा नहीं है
  if (todayTiming == null ||
      todayTiming.active == false ||
      todayTiming.open == null ||
      todayTiming.close == null) {
    return "Today Closed";
  }

  // 🔹 Step 4: Time को readable format में convert करो (e.g. 09:00 → 09:00 AM)
  String formatTime(String time) {
    final parts = time.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    String suffix = hour >= 12 ? "PM" : "AM";
    hour = hour > 12 ? hour - 12 : hour;
    if (hour == 0) hour = 12;
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $suffix";
  }

  return "Open Time : ${formatTime(todayTiming.open!)}  |  Close Time : ${formatTime(todayTiming.close!)}";
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
          childrenPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(txt, style: AppStyle.medium_16(AppColors.black20)),
          subtitle: Text(subTitle??"Tap to expand",
              style: AppStyle.normal_12(AppColors.black20)),
          children: children,
        ),
      ),
    );

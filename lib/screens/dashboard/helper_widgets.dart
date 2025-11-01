import 'package:animate_do/animate_do.dart';
import 'package:market_place_customer/screens/dashboard/search_vendors.dart';

import '../../utils/exports.dart';

/// OFFERS CHIP FOR GLOBAL DATA
Widget offersCardChipAndFavoriteWidget(String offersCounts,
    {String? expireTime}) {
  bool hasExpireTime = expireTime != null && expireTime.isNotEmpty;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            Assets.offersChip,
            height: size.height * 0.04,
            fit: BoxFit.cover,
            width: size.width * 0.24,
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.022, bottom: 2),
            child: Text(
              offersCounts,
              textAlign: TextAlign.center,
              style: AppStyle.medium_15(AppColors.white10),
            ),
          ),
        ],
      ),

      // ✅ Expiry Time Safe Condition
      if (hasExpireTime)
        Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.orange,
          ),
          child: Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                "Expires in $expireTime",
                style: AppStyle.normal_12(AppColors.whiteColor),
              ),
            ],
          ),
        ),
    ],
  );
}

/// OFFERS CARD FOR GLOBAL DATA

class NearbyRestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String distance;
  final String cuisines;
  final String flatData;
  final String offerText;
  final String? offersCounts;
  double carWidth;
  double imgHeight;
  final bool isExpired;
  final bool isPurchased;

  NearbyRestaurantCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.distance,
    required this.cuisines,
    required this.flatData,
    required this.offerText,
    required this.offersCounts,
    required this.imgHeight,
    required this.carWidth,
    required this.isExpired,
    required this.isPurchased,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16), bottom: Radius.circular(10)),
          child: FadeInImage(
            height: imgHeight,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: const AssetImage(Assets.dummy),
            image: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : const AssetImage(Assets.dummy) as ImageProvider,
            imageErrorBuilder: (_, __, ___) => Image.asset(
              Assets.dummy,
              height: imgHeight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
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
                  colors: [AppColors.transparent, AppColors.black70])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: size.height * 0.03),
                  child: offersCardChipAndFavoriteWidget(flatData.toString())),
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
                            style: AppStyle.medium_16(AppColors.whiteColor),
                            overflow: TextOverflow.ellipsis),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                                    "${location ?? ''} • ${distance ?? ''}",
                                    style:
                                        AppStyle.normal_12(AppColors.white10))),
                            Text(offersCounts.toString(),
                                textAlign: TextAlign.center,
                                style: AppStyle.normal_14(AppColors.white10)),
                          ],
                        ),
                        Text(cuisines,
                            style: AppStyle.medium_12(AppColors.parrot)),
                      ],
                    ),
                  ),
                  offerText.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.black70,
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(16))),
                          child: Row(
                            children: [
                              const Icon(Icons.local_offer,
                                  size: 18, color: Colors.deepOrange),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(offerText,
                                    style:
                                        AppStyle.medium_14(AppColors.orange)),
                              ),
                            ],
                          ))
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),

        /// Purchased Badge
        if (isPurchased)
          Positioned(
            top: 10,
            right: -25,
            child: FadeInDown(
              duration: const Duration(milliseconds: 700),
              child: Transform.rotate(
                angle: 0.5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                  color: Colors.green.withOpacity(0.8),
                  child: const Text(
                    "PURCHASED",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),

        /// Expired Overlay
        if (isExpired)
          AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 700),
            child: Container(
              height: imgHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.black50),
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

/// <<<<----------------------FOR CATEGORY SECTION---------------------->>>>

/// offers chip for category section
Widget offerChipAndFavoriteWidget(String offersCounts) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(Assets.offersChip,
                height: size.height * 0.04,
                fit: BoxFit.cover,
                width: size.width * 0.22),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.02),
              child: Text(offersCounts,
                  textAlign: TextAlign.center,
                  style: AppStyle.medium_13(AppColors.white10)),
            ),
          ],
        ),
        // Padding(
        //     padding: EdgeInsets.only(
        //         right: size.width * 0.03, bottom: size.height * 0.012),
        //     child: Align(
        //       alignment: Alignment.topRight,
        //       child: CircleAvatar(
        //           radius: 15,
        //           backgroundColor: AppColors.theme60,
        //           child: Icon(Icons.favorite_border,
        //               color: AppColors.white80, size: 15)),
        //     )),
      ],
    );

/// CATEGORY CARD FOR CATEGORY SECTION

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  double carWidth;
  double imgHeight;

  CategoryCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.imgHeight,
      required this.carWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            height: imgHeight,
            width: carWidth,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade200,
                period: const Duration(seconds: 1),
                child: Container(
                  width: carWidth,
                  height: imgHeight,
                  color: Colors.white,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade200,
                period: const Duration(seconds: 1),
                child: Container(
                  width: carWidth,
                  height: imgHeight,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
        SizedBox(height: size.height * 0.005),
        Text(name,
            style: AppStyle.normal_13(AppColors.blackColor),
            overflow: TextOverflow.ellipsis),
      ],
    );
  }
}

/// SUB CATEGORY CARD FOR CATEGORY SECTION

class SubCategoryCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String distance;
  final String cuisines;
  final String offersCount;
  final String offerText;
  double carWidth;
  double imgHeight;

  SubCategoryCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.location,
      required this.distance,
      required this.cuisines,
      required this.offersCount,
      required this.offerText,
      required this.imgHeight,
      required this.carWidth});

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
            width: double.infinity,
            placeholder: const AssetImage(Assets.dummy),
            image: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : const AssetImage(Assets.dummy) as ImageProvider,
            imageErrorBuilder: (_, child, st) => Image.asset(Assets.dummy,
                height: imgHeight, fit: BoxFit.cover, width: double.infinity),
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
                  colors: [AppColors.transparent, AppColors.black70])),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: offerChipAndFavoriteWidget(offersCount),
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
                        Text("${location ?? ''} • ${distance ?? ''}",
                            style: AppStyle.medium_13(AppColors.white10)),
                        Text(cuisines,
                            style: AppStyle.medium_13(AppColors.parrot)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10))),
                    child: Row(
                      children: [
                        const Icon(Icons.local_offer,
                            size: 18, color: AppColors.whiteColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(offerText,
                              style: AppStyle.medium_13(AppColors.whiteColor)),
                        ),
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

/// SEARCH CIRCLE BTN

searchBtn(BuildContext context, double opacity1) => IconButton(
      highlightColor: AppColors.transparent,
      onPressed: () =>
          AppRouter().navigateTo(context, const SearchVendorsPage()),
      icon: CircleAvatar(
        backgroundColor:
            Color.lerp(AppColors.black70, AppColors.theme10, opacity1),
        child: Image.asset(Assets.searchIcon,
            height: 18,
            color:
                Color.lerp(AppColors.white50, AppColors.themeColor, opacity1)),
      ),
    );

/// BACK BTN
backBtn(BuildContext context, double opacity) => IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_ios_new,
        size: 20,
        color: Color.lerp(AppColors.whiteColor, AppColors.blackColor, opacity),
      ),
    );

/// CALCULATE DISTANCE

/// find address and distance
Future<Map<String, String>> getAddressAndDistance(
    double vendorLat, double vendorLng) async {
  // 1️ Get vendor address
  String address = await getExactAddressFromLatLng(vendorLat, vendorLng);

  // Get distance from user to vendor
  double distanceKm = await getDistanceBetweenPoints(vendorLat, vendorLng);

  return {
    "address": address,
    "distance": "${distanceKm.toStringAsFixed(1)} km",
  };
}

/// UI WIDGET CARDS FOR NEARBY VENDORS
class RestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String distance;
  final String cuisines;
  final String offersCount;
  final String offerText;
  double carWidth;
  double imgHeight;

  RestaurantCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.location,
      required this.distance,
      required this.cuisines,
      required this.offersCount,
      required this.offerText,
      required this.imgHeight,
      required this.carWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: carWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: FadeInImage(
                  height: imgHeight,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: const AssetImage(Assets.dummy),
                  image: imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl)
                      : const AssetImage(Assets.dummy) as ImageProvider,
                  imageErrorBuilder: (_, child, st) => Image.asset(Assets.dummy,
                      height: size.height * 0.17,
                      fit: BoxFit.cover,
                      width: double.infinity),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.025),
                child: offersCardChipAndFavoriteWidget(offersCount),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: AppStyle.medium_18(AppColors.themeColor),
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text("$location • $distance",
                    style: AppStyle.normal_13(AppColors.greyColor)),
                const SizedBox(height: 2),
                Text(cuisines, style: AppStyle.medium_13(AppColors.black20)),
              ],
            ),
          ),

          const Divider(height: 1),

          // Offer section
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: AppColors.themeColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16))),
            child: Row(
              children: [
                const Icon(Icons.local_offer,
                    size: 18, color: AppColors.whiteColor),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(offerText,
                      style: AppStyle.medium_14(AppColors.whiteColor)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// VIEW ALL WIDGET

Widget ViewAllWidget({required String title, void Function()? onPressed}) =>
    Padding(
      padding:
          EdgeInsets.only(left: size.width * 0.034, right: size.width * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyle.normal_19(AppColors.themeColor)),
          TextButton(
              onPressed: onPressed,
              child: Row(
                children: [
                  Text("View All", style: AppStyle.normal_15(AppColors.orange)),
                  const Icon(Icons.arrow_forward_ios_outlined,
                      size: 15, color: AppColors.orange)
                ],
              ))
        ],
      ),
    );

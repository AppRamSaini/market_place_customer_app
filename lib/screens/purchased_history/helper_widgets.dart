import 'package:animate_do/animate_do.dart';

import '../../utils/exports.dart';

class PurchasedOffersHistoryCardWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String purchasedPrice;
  final String discount;
  final DateTime expireIn;
  final String flatData;
  final String offerText;
  final String? offersCounts;
  double carWidth;
  double imgHeight;
  final bool isExpired;
  final bool isPurchased;

  PurchasedOffersHistoryCardWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.purchasedPrice,
    required this.discount,
    required this.expireIn,
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
                  child: offersCardChipAndFavoriteWidget(flatData.toString(),
                      expireTime: expireIn)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: AppStyle.medium_16(AppColors.whiteColor),
                            overflow: TextOverflow.ellipsis),
                        Text("Maximum Discount: ₹${discount.toString()}",
                            textAlign: TextAlign.center,
                            style: AppStyle.normal_12(AppColors.white10)),
                      ],
                    ),
                  ),
                  offerText.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: AppColors.black70,
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(16))),
                          child: Row(
                            children: [
                              const Icon(Icons.local_offer,
                                  size: 18, color: Colors.deepOrange),
                              const SizedBox(width: 6),
                              Text(offerText,
                                  style: AppStyle.medium_16(AppColors.orange)),
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
          AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 700),
            child: Container(
              height: imgHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.black50),
            ),
          ),
        if (isPurchased)
          Positioned(
            top: 15,
            right: -30,
            child: FadeInDown(
              duration: const Duration(milliseconds: 700),
              child: Transform.rotate(
                angle: 0.5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
                  color: Colors.green.withOpacity(0.8),
                  child: const Text(
                    "Offers Used",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
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
                  from: 100,
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

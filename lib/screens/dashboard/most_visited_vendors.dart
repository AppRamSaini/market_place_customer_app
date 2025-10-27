import 'package:draggable_carousel_slider/draggable_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/screens/dashboard/helper_widgets.dart';
import 'package:market_place_customer/screens/location/search_manual_location.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/vendors_details_page.dart';
import 'package:market_place_customer/utils/exports.dart';

class MostVisitedVendors extends StatefulWidget {
  final List<PopularVendorElement>? popularVendor;
  const MostVisitedVendors({super.key, required this.popularVendor});

  @override
  State<MostVisitedVendors> createState() => _MostVisitedVendorsState();
}

class _MostVisitedVendorsState extends State<MostVisitedVendors> {
  final Map<String, Map<String, String>> _locationCache = {};

  ///  Distance + Address caching
  Future<Map<String, String>> _getVendorAddressAndDistance(
      String lat, String lng) async {
    final key = '$lat,$lng';

    if (_locationCache.containsKey(key)) {
      return _locationCache[key]!;
    }

    try {
      final data =
          await getAddressAndDistance(double.parse(lat), double.parse(lng));
      _locationCache[key] = data;
      return data;
    } catch (e) {
      return {'distance': 'N/A', 'address': ''};
    }
  }

  Widget _image(String path, double width, double height,
      {bool shimmer = false, OfferData? offerData}) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            path,
            width: size.width * 0.8,
            height: size.height * 0.5,
            fit: BoxFit.fitHeight,
            loadingBuilder: (context, child, loadingProgress) =>
                AnimatedCrossFade(
              firstChild: child,
              secondChild: Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade700,
                  enabled: true,
                  period: const Duration(seconds: 2),
                  child: Container(
                      width: width, height: height, color: Colors.black)),
              crossFadeState: shimmer ||
                      ((child as Semantics).child as RawImage).image == null
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ),
        Container(
          width: size.width * 0.8,
          height: size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [AppColors.transparent, AppColors.black70],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: size.height * 0.04),
                  child: offersCardChipAndFavoriteWidget(
                      offerData!.flatData.toString())),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(offerData!.title ?? '',
                            style: AppStyle.medium_18(AppColors.whiteColor),
                            overflow: TextOverflow.ellipsis),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${offerData.location ?? ''} • ${offerData.distance ?? ''}",
                                style: AppStyle.normal_12(AppColors.white10),
                              ),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Text(
                              "${offerData.offerCount}+ OFFERS",
                              textAlign: TextAlign.center,
                              style: AppStyle.medium_15(AppColors.white10),
                            ),
                          ],
                        ),
                        Text(offerData.category ?? '',
                            style: AppStyle.medium_13(AppColors.yellowColor)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B274F).withOpacity(0.9),
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.local_offer,
                            size: 18, color: Colors.deepOrange),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(offerData.offersText ?? '',
                              style: AppStyle.medium_16(AppColors.orange)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: DraggableSlider(
        loop: true,
        onPressed: (index) {},
        children: List.generate(widget.popularVendor!.length, (index) {
          final vendor = widget.popularVendor![index].vendor!;
          final lat = vendor.lat ?? "0.0";
          final lng = vendor.long ?? "0.0";
          final key = '$lat,$lng';

          return FutureBuilder<Map<String, String>>(
            future:
                _getVendorAddressAndDistance(lat.toString(), lng.toString()),
            builder: (context, snapshot) {
              String distance = '';
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                distance = snapshot.data!['distance'] ?? '';
              } else if (_locationCache.containsKey(key)) {
                distance = _locationCache[key]!['distance'] ?? '';
              } else {
                distance = '...';
              }

              OfferData offerData = OfferData(
                title: vendor.businessName ?? '',
                location: "${vendor.area}, ${vendor.city}" ?? '',
                distance: distance,
                category: vendor.category?.name ?? '',
                offerCount:
                    widget.popularVendor![index].activeOffersCount.toString(),
                flatData: widget.popularVendor![index].maxOffer?.type ==
                        'percentage'
                    ? "Flat ${widget.popularVendor![index].maxOffer?.amount ?? ''}%"
                    : "Flat ₹${widget.popularVendor![index].maxOffer?.amount ?? ''}",
                offersText: widget.popularVendor![index].maxOffer?.type ==
                        'percentage'
                    ? "Flat ${widget.popularVendor![index].maxOffer?.amount ?? ''}% OFF On Total Bill"
                    : "Flat ₹${widget.popularVendor![index].maxOffer?.amount ?? ''} OFF On Total Bill",
              );

              return GestureDetector(
                onTap: () {
                  AppRouter().navigateTo(
                      context,
                      OffersDetailsPage(
                          vendorId: vendor.user?.id?.toString() ?? "0"));
                },
                child: _image(
                  vendor.businessLogo ?? '',
                  size.width * 0.8,
                  size.height * 0.6,
                  offerData: offerData,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class OfferData {
  final String? title;
  final String? location;
  final String? category;
  final String? distance;
  final String? offerCount;
  final String? offersText;
  final String? flatData;

  OfferData({
    this.title,
    this.location,
    this.category,
    this.distance,
    this.offerCount,
    this.flatData,
    this.offersText,
  });
}

import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/vendors_details_page.dart';

import '../../utils/exports.dart';

class NearbyVendors extends StatefulWidget {
  final List<Nearbyvendor> nearbyVendorsList;

  const NearbyVendors({super.key, required this.nearbyVendorsList});

  @override
  State<NearbyVendors> createState() => _NearbyVendorsState();
}

class _NearbyVendorsState extends State<NearbyVendors> {
  final Map<String, Map<String, String>> _locationCache = {};

  /// ✅ Distance + Address caching function
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(widget.nearbyVendorsList.length, (index) {
          final vendor = widget.nearbyVendorsList[index];
          final lat = vendor.vendor?.lat ?? "0.0";
          final lng = vendor.vendor?.long ?? "0.0";
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

              return Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.03,
                    right: index == widget.nearbyVendorsList.length - 1
                        ? size.width * 0.03
                        : 0.0),
                child: GestureDetector(
                  onTap: () {
                    AppRouter().navigateTo(
                        context,
                        OffersDetailsPage(
                            vendorId:
                                vendor.vendor?.user?.id?.toString() ?? "0"));
                  },
                  child: RestaurantCard(
                    carWidth: size.width * 0.68,
                    imgHeight: size.height * 0.17,
                    imageUrl: vendor.vendor?.businessLogo ?? '',
                    name: vendor.vendor?.businessName ?? '',
                    location:
                        "${vendor.vendor?.area ?? ''}, ${vendor.vendor?.city ?? ''}",
                    distance: distance,
                    cuisines: vendor.vendor?.category?.name ?? '',
                    offersCount: vendor.maxOffer?.type == 'percentage'
                        ? "Flat ${vendor.maxOffer?.amount ?? ''}%"
                        : "Flat ₹${vendor.maxOffer?.amount ?? ''}",
                    offerText: vendor.maxOffer?.type == 'percentage'
                        ? "Flat ${vendor.maxOffer?.amount ?? ''}% off On Total Bill"
                        : "Flat ₹${vendor.maxOffer?.amount ?? ''} off On Total Bill",
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

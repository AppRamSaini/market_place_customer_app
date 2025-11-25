import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/screens/dashboard/view_all_vendors_page.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/vendors_details_page.dart';

import '../../utils/exports.dart';

class PopularVendors extends StatelessWidget {
  List<PopularvendorElement> popularVendor;
  List<CategoryElement> popularCategory;

  PopularVendors(
      {super.key, required this.popularVendor, required this.popularCategory});

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
    return Column(
      children: [
        SizedBox(height: size.height * 0.03),
        ViewAllWidget(
          title: 'Popular Vendors',
          onPressed: () => AppRouter().navigateTo(
              context,
              ViewAllVendorsPage(
                  popularCategory: popularCategory, type: "popular")),
        ),
        SizedBox(height: size.height * 0.005),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(popularVendor.length, (index) {
              final vendor = popularVendor[index];
              final lat = vendor.vendor?.lat ?? "0.0";
              final lng = vendor.vendor?.long ?? "0.0";
              final key = '$lat,$lng';

              return FutureBuilder<Map<String, String>>(
                  future: _getVendorAddressAndDistance(
                      lat.toString(), lng.toString()),
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
                          right: index == popularVendor.length - 1
                              ? size.width * 0.03
                              : 0.0),
                      child: GestureDetector(
                        onTap: () => AppRouter().navigateTo(
                            context,
                            OffersDetailsPage(
                                vendorId: popularVendor[index]
                                    .vendor!
                                    .user!
                                    .id
                                    .toString())),
                        child: RestaurantCard(
                          carWidth: size.width * 0.68,
                          imgHeight: size.height * 0.17,
                          imageUrl:
                              popularVendor[index].vendor!.businessLogo ?? '',
                          name: popularVendor[index].vendor!.businessName ?? '',
                          location:
                              "${popularVendor[index].vendor!.area}, ${popularVendor[index].vendor!.city ?? ''}",
                          distance: distance,
                          cuisines:
                              popularVendor[index].vendor!.category!.name ?? '',
                          offersCount: popularVendor[index].maxOffer!.type ==
                                  'percentage'
                              ? "Flat ${popularVendor[index].maxOffer!.amount ?? ''}% "
                              : "Flat ₹${popularVendor[index].maxOffer!.amount ?? ''}",
                          offerText: popularVendor[index].maxOffer!.type ==
                                  'percentage'
                              ? "Flat ${popularVendor[index].maxOffer!.amount ?? ''} % OFF On Total Bill"
                              : "Flat ₹${popularVendor[index].maxOffer!.amount ?? ''}  OFF On Total Bill",
                        ),
                      ),
                    );
                  });
            }),
          ),
        ),
      ],
    );
  }
}

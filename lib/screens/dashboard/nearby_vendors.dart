import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/screens/location/search_location.dart';

import '../../utils/exports.dart';

class NearbyVendors extends StatelessWidget {
  List<NearbyvendorElement> nearbyVendorsList;
  NearbyVendors({super.key, required this.nearbyVendorsList});

  @override
  Widget build(BuildContext context) {
    return




      SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(
          nearbyVendorsList.length,
          (index) => Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.03,
                right: index == 4 ? size.width * 0.03 : 0.0),
            child: RestaurantCard(
              carWidth: size.width * 0.68,
              imgHeight: size.height * 0.17,
              imageUrl: nearbyVendorsList[index].vendor!.businessLogo ?? '',
              name: nearbyVendorsList[index].vendor!.businessName ?? '',
              location: nearbyVendorsList[index].vendor!.address ?? '',
              distance: "7.3 km",
              cuisines: nearbyVendorsList[index].vendor!.category!.name ?? '',
              offersCount: nearbyVendorsList[index].maxOffer!.type ==
                      'percentage'
                  ? "Flat ${nearbyVendorsList[index].maxOffer!.amount ?? ''}% "
                  : "Flat ₹${nearbyVendorsList[index].maxOffer!.amount ?? ''}",
              offerText: nearbyVendorsList[index].maxOffer!.type == 'percentage'
                  ? "Flat ${nearbyVendorsList[index].maxOffer!.amount ?? ''} % OFF On Total Bill"
                  : "Flat ₹${nearbyVendorsList[index].maxOffer!.amount ?? ''}  OFF On Total Bill",
            ),
          ),
        ),
      ),
    );
  }
}

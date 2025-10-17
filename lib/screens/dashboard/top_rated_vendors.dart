import 'package:market_place_customer/screens/profile/business_gallery.dart';
import 'package:market_place_customer/utils/exports.dart';

import 'helper_widgets.dart';

class TopRatedVendors extends StatelessWidget {
  const TopRatedVendors({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.35,
      child: PageView.builder(
        itemCount: images.length,
        physics: const BouncingScrollPhysics(),
        padEnds: true,
        itemBuilder: (_, index) => Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.03, right: size.width * 0.03),
          child: NearbyRestaurantCard(
            carWidth: size.width * 0.9,
            imgHeight: size.height * 0.35,
            imageUrl: images![index]['url'] ?? '',
            name: "The Burger Farm",
            location: "Shayam Nagar Sodala, Jaipur",
            distance: "7.3 km",
            cuisines: "Chinese, North Indian",
            flatData: "700",
            offerText: "Flat 20% OFF On Total Bill",
            offersCounts: "20",
          ),
        ),
      ),
    );
  }
}

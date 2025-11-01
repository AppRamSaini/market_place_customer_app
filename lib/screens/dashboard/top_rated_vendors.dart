import 'package:market_place_customer/utils/exports.dart';

class TopRatedVendors extends StatelessWidget {
  const TopRatedVendors({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) => Padding(
        padding: EdgeInsets.only(
            left: size.width * 0.03,
            right: size.width * 0.03,
            top: size.height * 0.01),
        child: NearbyRestaurantCard(
          carWidth: size.width * 0.9,
          imgHeight: size.height * 0.3,
          isPurchased: false,
          isExpired: false,
          imageUrl: images[index]['url'] ?? '',
          name: "The Burger Farm",
          location: "Shayam Nagar Sodala, Jaipur",
          distance: "7.3 km",
          cuisines: "Chinese, North Indian",
          flatData: "700",
          offerText: "Flat 20% OFF On Total Bill",
          offersCounts: "20",
        ),
      ),
    );
  }
}

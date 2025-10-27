import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import '../../utils/exports.dart';

class PopularVendors extends StatelessWidget {
  List<PopularVendorElement> popularVendor;
  PopularVendors({super.key, required this.popularVendor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.03),

        ViewAllWidget(title: 'Popular Vendors', onPressed: () {}),
        SizedBox(height: size.height * 0.005),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              popularVendor.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.03,
                    right: index == 4 ? size.width * 0.03 : 0.0),
                child: RestaurantCard(
                  carWidth: size.width * 0.68,
                  imgHeight: size.height * 0.17,
                  imageUrl: popularVendor[index].vendor!.businessLogo ?? '',
                  name: popularVendor[index].vendor!.businessName ?? '',
                  location: popularVendor[index].vendor!.address ?? '',
                  distance: "7.3 km",
                  cuisines: popularVendor[index].vendor!.category!.name ?? '',
                  offersCount: popularVendor[index].maxOffer!.type ==
                          'percentage'
                      ? "Flat ${popularVendor[index].maxOffer!.amount ?? ''}% "
                      : "Flat ₹${popularVendor[index].maxOffer!.amount ?? ''}",
                  offerText: popularVendor[index].maxOffer!.type == 'percentage'
                      ? "Flat ${popularVendor[index].maxOffer!.amount ?? ''} % OFF On Total Bill"
                      : "Flat ₹${popularVendor[index].maxOffer!.amount ?? ''}  OFF On Total Bill",
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

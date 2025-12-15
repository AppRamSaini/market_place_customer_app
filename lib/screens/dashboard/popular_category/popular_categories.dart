import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/screens/dashboard/popular_category/category_widgets.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/vendors_details_page.dart';
import 'package:market_place_customer/utils/exports.dart';

class PopularCategories extends StatefulWidget {
  final List<CategoryElement>? categoryData;

  const PopularCategories({super.key, required this.categoryData});

  @override
  State<PopularCategories> createState() => _PopularCategoriesState();
}

class _PopularCategoriesState extends State<PopularCategories> {
  int selectedIndex = 0;
  Map<String, Map<String, String>> locationCache = {};

  /// calculate distance
  Future<Map<String, String>> getVendorAddressAndDistance(
      String lat, String lng) async {
    final key = '$lat,$lng';

    if (locationCache.containsKey(key)) {
      return locationCache[key]!;
    }
    final data =
        await getAddressAndDistance(double.parse(lat), double.parse(lng));
    locationCache[key] = data;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    /// Current selected category vendors list
    final selectedVendors = widget.categoryData![selectedIndex].vendors ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.categoryData!.length,
              (index) {
                final category = widget.categoryData![index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.03, right: size.width * 0.03),
                    child: Column(
                      children: [
                        CategoryCard(
                          carWidth: size.width * 0.2,
                          imgHeight: size.width * 0.2,
                          imageUrl: category.image ?? '',
                          name: category.name ?? '',
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          height: 1.5,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? AppColors.themeColor
                                : AppColors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        GridView.builder(
          itemCount: selectedVendors.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: size.height * 0.23),
          itemBuilder: (_, index) {
            final vendor = selectedVendors[index];
            final percent = vendor.maxOffer!.type == 'percentage';

            return FutureBuilder<Map<String, String>>(
              future: getVendorAddressAndDistance(
                vendor.vendor!.lat.toString(),
                vendor.vendor!.long.toString(),
              ),
              builder: (context, snap) {
                final distance = snap.hasData ? snap.data!['distance']! : '';

                return SubCategoryCard(
                  onTap: () => AppRouter().navigateTo(
                      context,
                      OffersDetailsPage(
                          vendorId: vendor.vendor!.user!.id.toString())),
                  carWidth: size.width * 0.4,
                  imgHeight: size.width * 0.25,
                  imageUrl: (vendor.vendor!.businessLogo != null &&
                          vendor.vendor!.businessLogo!.trim().isNotEmpty)
                      ? vendor.vendor!.businessLogo!
                      : '',
                  name: vendor.vendor!.businessName ?? 'N/A',
                  location: vendor.vendor!.area ?? 'N/A',
                  distance: distance,
                  cuisines: vendor.vendor!.subcategory!.name ?? "",
                  offerText: percent
                      ? "🎁 Flat ${vendor.maxOffer!.amount}% OFF"
                      : "🎁 Flat ₹${vendor.maxOffer!.amount} OFF",
                );
              },
            );
          },
        ),
      ],
    );
  }
}

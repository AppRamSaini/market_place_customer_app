import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/utils/exports.dart';

class PopularCategories extends StatelessWidget {
  final List<VendorsCategory>? categoryData;

  const PopularCategories({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(
            categoryData!.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.03, right: size.width * 0.03),
              child: CategoryCard(
                carWidth: size.width * 0.25,
                imgHeight: size.width * 0.25,
                imageUrl:
                    "https://t4.ftcdn.net/jpg/03/31/04/57/360_F_331045790_C1JRCk4HIdVkiyrsJ16vzMuuWhZnBpbE.jpg" ??
                        '',
                name: categoryData![index].name ?? '',
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: size.height * 0.03),
      GridView.builder(
        itemCount: 5,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 1.0),
        itemBuilder: (_, index) => SubCategoryCard(
          carWidth: size.width * 0.4,
          imgHeight: size.height * 0.6,
          imageUrl:
              'https://www.eatright.org/-/media/images/eatright-landing-pages/fruitslp_804x482.jpg',
          name: "The Burger Farm",
          location: "Valise Nagar",
          distance: "7.3 km",
          cuisines: "Chinese, North Indian",
          offersCount: "Flat ₹200",
          offerText: "Flat 20% OFF",
        ),
      ),
    ]);
  }
}

import '../../../utils/exports.dart';

/// SUB CATEGORY CARD FOR CATEGORY SECTION
class SubCategoryCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String distance;
  final String cuisines;
  final String offerText;
  double carWidth;
  double imgHeight;
  void Function()? onTap;

  SubCategoryCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.distance,
    required this.cuisines,
    required this.offerText,
    required this.imgHeight,
    required this.carWidth,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: FadeInImage(
              fit: BoxFit.cover,
              height: imgHeight,
              width: double.infinity,
              placeholder: const AssetImage(Assets.dummy),
              image: (imageUrl != null &&
                      imageUrl.trim().isNotEmpty &&
                      imageUrl != "null")
                  ? NetworkImage(imageUrl)
                  : const AssetImage(Assets.dummy),
              imageErrorBuilder: (_, __, ___) => Image.asset(
                Assets.dummy,
                height: imgHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// DETAILS
          Container(
            width: size.width,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [AppColors.white10, AppColors.whiteColor])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE + LOCATION + CUISINE
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(name,
                        style: AppStyle.medium_13(AppColors.themeColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text("$location • $distance",
                        style: AppStyle.medium_12(AppColors.black50),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(cuisines,
                        style: AppStyle.medium_12(AppColors.themeColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)),
                const SizedBox(height: 5),

                /// OFFER TAG
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: AppColors.themeColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10))),
                  child: Text(
                    offerText,
                    style: AppStyle.normal_13(AppColors.whiteColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// CATEGORY CARD FOR CATEGORY SECTION

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  double carWidth;
  double imgHeight;

  CategoryCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.imgHeight,
      required this.carWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(imageUrl,
              height: imgHeight, width: carWidth, fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Image.asset(Assets.dummy,
                fit: BoxFit.cover, height: imgHeight, width: carWidth);
          }, errorBuilder: (context, error, stackTrace) {
            return Image.asset(Assets.dummy,
                fit: BoxFit.cover, height: imgHeight, width: carWidth);
          }),
        ),
        SizedBox(height: size.height * 0.005),
        Text(name,
            style: AppStyle.normal_13(AppColors.blackColor),
            overflow: TextOverflow.ellipsis),
      ],
    );
  }
}

// import 'package:market_place_customer/screens/dashboard/helper_widgets.dart';
// import 'package:market_place_customer/screens/profile/business_gallery.dart';
// import 'package:market_place_customer/screens/dashboard/top_rated_vendors.dart';
// import '../../utils/exports.dart';
//
// class OffersListingPage extends StatefulWidget {
//   const OffersListingPage({super.key});
//
//   @override
//   State<OffersListingPage> createState() => _OffersListingPageState();
// }
//
// class _OffersListingPageState extends State<OffersListingPage> {
//   final ScrollController _scrollController = ScrollController();
//   final TextEditingController controller = TextEditingController();
//   double _appBarOpacity = 0.0;
//   double _flexTitleOpacity = 1.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       double offset = _scrollController.offset;
//       double maxOffset = size.height * 0.3;
//       double opacity = (offset / maxOffset).clamp(0.0, 1.0);
//       setState(() {
//         _appBarOpacity = opacity;
//         _flexTitleOpacity = 1.0 - opacity;
//       });
//     });
//     // refreshData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: CustomScrollView(
//       controller: _scrollController,
//       slivers: [
//         SliverAppBar(
//             expandedHeight: size.height * 0.12,
//             floating: false,
//             pinned: true,
//             snap: false,
//             stretch: true,
//             leading: Opacity(
//                 opacity: _appBarOpacity,
//                 child: TextButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     child:  Icon(Icons.arrow_back_ios,size: 22,color: AppColors.black20))),
//             title: Opacity(
//                 opacity: _appBarOpacity,
//                 child: Text("Popular Nearby Vendors",
//                     style: AppStyle.medium_18(AppColors.black20))),
//             flexibleSpace: FlexibleSpaceBar(
//                 collapseMode: CollapseMode.parallax,
//                 titlePadding: EdgeInsets.zero, // padding remove
//                 background: SafeArea(
//                   child: Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: size.width * 0.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: size.height * 0.01),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Opacity(
//                                 opacity: _flexTitleOpacity,
//                                 child: TextButton(
//                                     onPressed: () => Navigator.of(context).pop(),
//                                     child:  Icon(Icons.arrow_back_ios,size: 22,color: AppColors.black20))),
//                             SizedBox(width: size.width * 0.02),
//                             Opacity(
//                                 opacity: _flexTitleOpacity,
//                                 child: Text("Popular Nearby Vendors",
//                                     style:
//                                         AppStyle.medium_18(AppColors.black20))),
//                           ],
//                         ),
//                         SizedBox(height: size.height * 0.0),
//                         Flexible(
//                           child: Opacity(
//                             opacity: _flexTitleOpacity,
//                             child: Padding(
//                               padding:  EdgeInsets.symmetric(horizontal: size.width*0.036),
//                               child: AnimatedHintSearchField(
//                                 controller: controller,
//                                 suffix: controller.text.isNotEmpty
//                                     ? IconButton(
//                                         icon: Icon(Icons.clear,
//                                             color: AppColors.white60),
//                                         onPressed: () => controller.clear())
//                                     : null,
//                                 fillColor: AppColors.theme50,
//                                 onChanged: (value) {},
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ))),
//         SliverList.builder(
//           itemCount: images.length,
//           itemBuilder: (_, index) => Padding(
//             padding: EdgeInsets.only(
//                 left: size.width * 0.034,
//                 right: size.width * 0.034,
//                 top: size.height * 0.015),
//             child: NearbyRestaurantCard(
//               carWidth: size.width * 0.9,
//               imgHeight: size.height * 0.35,
//               imageUrl: images![index]['url'] ?? '',
//               name: "The Burger Farm",
//               location: "Shayam Nagar Sodala, Jaipur",
//               distance: "7.3 km",
//               cuisines: "Chinese, North Indian",
//               priceForTwo: "700",
//               offerText: "Flat 20% OFF On Total Bill",
//               offersCounts: "20",
//             ),
//           ),
//         ),
//       ],
//     ));
//   }
// }

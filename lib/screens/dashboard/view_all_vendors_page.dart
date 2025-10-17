import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_all_vendors/fetch_all_vendors_event.dart';
import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/screens/location/location_from_map.dart';
import 'package:market_place_customer/screens/location/search_location.dart';
import '../../utils/exports.dart';

class ViewAllVendorsPage extends StatefulWidget {
  final String? type;
  final List<VendorsCategory>? popularCategory;
  const ViewAllVendorsPage({super.key, this.type, this.popularCategory});

  @override
  State<ViewAllVendorsPage> createState() => _ViewAllVendorsPageState();
}

class _ViewAllVendorsPageState extends State<ViewAllVendorsPage> {
  final ScrollController _scrollController = ScrollController();
  double _flexTitleOpacity = 1.0;
  Map<String, String> addressCache = {};

  @override
  void initState() {
    super.initState();
    fetchVendors(type: widget.type);

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double maxOffset = size.height * 0.3;
      double opacity = (offset / maxOffset).clamp(0.0, 1.0);
      setState(() {
        _flexTitleOpacity = 1.0 - opacity;
      });
    });
  }

  Future fetchVendors({String? type, String? category}) async {
    context
        .read<FetchVendorsBloc>()
        .add(GetVendorsEvent(context: context, type: type, category: category));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.themeColor,
            expandedHeight: size.height * 0.11,
            floating: false,
            pinned: true,
            snap: false,
            stretch: true,
            leadingWidth: size.width * 0.1,
            leading: Padding(
                padding: const EdgeInsets.all(3),
                child: backBtn(context, _flexTitleOpacity)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Popular Nearby Vendors",
                    style: AppStyle.medium_18(Color.lerp(AppColors.whiteColor,
                        AppColors.blackColor, _flexTitleOpacity)!)),
                searchBtn(context, _flexTitleOpacity)
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              titlePadding: EdgeInsets.zero,
              background: Container(
                color: AppColors.whiteColor,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.07),
                      Opacity(
                        opacity: _flexTitleOpacity,
                        child: CategoriesList(
                            popularCategory: widget.popularCategory,
                            type: widget.type),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child:
              RefreshIndicator(
                onRefresh: fetchVendors,
              child: BlocBuilder<FetchVendorsBloc, FetchVendorsState>(
                builder: (context, state) {
                  if (state is FetchVendorsLoading) {
                    return SizedBox(
                        height: size.height * 0.7,
                        child: const BurgerKingShimmer());
                  } else if (state is FetchVendorsFailure) {
                    return Center(
                        child: Text(state.error,
                            style: AppStyle.medium_14(AppColors.redColor)));
                  } else if (state is FetchVendorsSuccess) {
                    final vendorsList = state.model.data ?? [];

                    return




                      ListView.builder(
                      itemCount: vendorsList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final vendor = vendorsList[index];

                        return FutureBuilder<Map<String, String>>(
                          future: getAddressAndDistance(
                              vendor.vendor!.lat!, vendor.vendor!.long!),
                          builder: (context, snapshot) {
                            String location = 'Loading...';
                            String distance = '';

                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              location = snapshot.data!['address']!;
                              distance = snapshot.data!['distance']!;
                            }

                            return Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.015,
                                  left: size.width * 0.03,
                                  right: size.width * 0.03,
                                  bottom: index == vendorsList.length - 1
                                      ? size.height * 0.1
                                      : 0.0),
                              child: NearbyRestaurantCard(
                                carWidth: size.width * 0.9,
                                imgHeight: size.height * 0.3,
                                imageUrl: vendor.vendor!.businessLogo ?? '',
                                name: vendor.vendor!.businessName ?? '',
                                location: location,
                                distance: distance,
                                cuisines: vendor.vendor!.category!.name ?? '',
                                flatData: "Flat 36%",
                                offerText: vendor.maxOffer != null
                                    ? vendor.maxOffer!.type == 'percentage'
                                        ? "Flat ${vendor.maxOffer!.amount}% OFF"
                                        : "Flat ₹${vendor.maxOffer!.amount} OFF"
                                    : '',
                                offersCounts: vendor.activeOffersCount! > 0
                                    ? '${vendor.activeOffersCount}+ OFFER'
                                    : '',
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

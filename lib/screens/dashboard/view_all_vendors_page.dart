import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';

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
  Map<String, Map<String, String>> locationCache = {};

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

  /// fetch vendors
  Future fetchVendors({String? type, String? category}) async {
    context
        .read<FetchVendorsBloc>()
        .add(GetVendorsEvent(context: context, type: type, category: category));
  }

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
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: fetchVendors,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.themeColor,
              expandedHeight: size.height * 0.11,
              pinned: true,
              leadingWidth: size.width * 0.1,
              leading: Padding(
                  padding: const EdgeInsets.all(3),
                  child: backBtn(context, _flexTitleOpacity)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Vendors",
                    style: AppStyle.medium_18(
                      Color.lerp(AppColors.whiteColor, AppColors.blackColor,
                          _flexTitleOpacity)!,
                    ),
                  ),
                  searchBtn(context, _flexTitleOpacity)
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
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
                            type: widget.type,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<FetchVendorsBloc, FetchVendorsState>(
                builder: (context, state) {
                  if (state is FetchVendorsLoading) {
                    return const BurgerKingShimmer();
                  } else if (state is FetchVendorsFailure) {
                    return Center(
                      child: Text(
                        state.error,
                        style: AppStyle.medium_14(AppColors.redColor),
                      ),
                    );
                  } else if (state is FetchVendorsSuccess) {
                    final vendorsList = state.model.data ?? [];

                    return Padding(
                      padding: EdgeInsets.only(top: size.height * 0.012),
                      child: ListView.builder(
                        itemCount: vendorsList.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, index) {
                          final vendor = vendorsList[index];
                          final lat = vendor.vendor!.lat!;
                          final lng = vendor.vendor!.long!;
                          final key = '$lat,$lng';

                          return FutureBuilder<Map<String, String>>(
                            future: getVendorAddressAndDistance(
                                lat.toString(), lng.toString()),
                            builder: (context, snapshot) {
                              String location = 'Fetching...';
                              String distance = '';

                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                location = snapshot.data!['address']!;
                                distance = snapshot.data!['distance']!;
                              } else if (locationCache.containsKey(key)) {
                                // Use cached data even while building
                                location = locationCache[key]!['address']!;
                                distance = locationCache[key]!['distance']!;
                              }

                              return Padding(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.03,
                                    right: size.width * 0.03,
                                    bottom: index == vendorsList.length - 1
                                        ? size.height * 0.1
                                        : size.height * 0.012),
                                child: NearbyRestaurantCard(
                                  isPurchased: false,
                                  isExpired: false,
                                  carWidth: size.width * 0.9,
                                  imgHeight: size.height * 0.3,
                                  imageUrl: vendor.vendor!.businessLogo ?? '',
                                  name: vendor.vendor!.businessName ?? '',
                                  location: location,
                                  distance: distance,
                                  cuisines: vendor.vendor!.category!.name ?? '',
                                  flatData: vendor.maxOffer != null
                                      ? vendor.maxOffer!.type == 'percentage'
                                          ? "Flat ${vendor.maxOffer!.amount}%"
                                          : "Flat ₹${vendor.maxOffer!.amount}"
                                      : 'FREE',
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
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

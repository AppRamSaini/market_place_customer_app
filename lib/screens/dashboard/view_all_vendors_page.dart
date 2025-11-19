import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/vendors_details_page.dart';

import '../../utils/exports.dart';

class ViewAllVendorsPage extends StatefulWidget {
  final String? type;
  final List<CategoryElement>? popularCategory;

  const ViewAllVendorsPage({super.key, this.type, this.popularCategory});

  @override
  State<ViewAllVendorsPage> createState() => _ViewAllVendorsPageState();
}

class _ViewAllVendorsPageState extends State<ViewAllVendorsPage> {
  final ScrollController _scrollController = ScrollController();
  double _flexTitleOpacity = 1.0;
  Map<String, Map<String, String>> locationCache = {};

  int _page = 1;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchData(
      {String? type, String? category, bool isLoadMore = false}) async {
    context.read<FetchVendorsBloc>().add(GetVendorsEvent(
        context: context,
        type: type,
        category: category,
        page: _page,
        isLoadMore: isLoadMore));
  }

  void _onScroll() {
    double offset = _scrollController.offset;
    double maxOffset = size.height * 0.3;
    double opacity = (offset / maxOffset).clamp(0.0, 1.0);

    setState(() {
      _flexTitleOpacity = 1.0 - opacity;
    });

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _loadMore();
    }
  }

  String _category = '';

  /// set types
  Future setCategoryType(String type) async => setState(() => _category = type);

  int totalPages = 1;

  void _loadMore() async {
    final bloc = context.read<FetchVendorsBloc>();
    final state = bloc.state;

    if (state is FetchVendorsSuccess) {
      totalPages = state.model.data!.totalPages ?? 1;
      if (_page >= totalPages) return;

      if (state.hasReachedMax) return;
      if (state.isPaginating) return;
      if (_isFetchingMore) return;

      _isFetchingMore = true;
      _page++;

      await _fetchData(
          isLoadMore: true, type: widget.type.toString(), category: _category);

      _isFetchingMore = false;
    }
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
        onRefresh: () async {
          _fetchData(type: widget.type.toString(), isLoadMore: false);
        },
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
                    style: AppStyle.medium_18(Color.lerp(AppColors.whiteColor,
                        AppColors.blackColor, _flexTitleOpacity)!),
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
                            onTap: setCategoryType,
                            page: _page,
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
                        child: Text(state.error,
                            style: AppStyle.medium_14(AppColors.redColor)));
                  } else if (state is FetchVendorsSuccess) {
                    final vendorsList = state.model.data!.data ?? [];

                    return Padding(
                      padding: EdgeInsets.only(top: size.height * 0.012),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            vendorsList.length + (state.isPaginating ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == vendorsList.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: AppColors.themeColor,
                                ),
                              ),
                            );
                          }

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
                                child: GestureDetector(
                                  onTap: () => AppRouter().navigateTo(
                                      context,
                                      OffersDetailsPage(
                                          vendorId: vendor.vendor!.user!.id
                                              .toString())),
                                  child: NearbyRestaurantCard(
                                    isPurchased: false,
                                    isExpired: false,
                                    carWidth: size.width * 0.9,
                                    imgHeight: size.height * 0.3,
                                    imageUrl: vendor.vendor!.businessLogo ?? '',
                                    name: vendor.vendor!.businessName ?? '',
                                    location: location,
                                    distance: distance,
                                    cuisines:
                                        vendor.vendor!.category!.name ?? '',
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

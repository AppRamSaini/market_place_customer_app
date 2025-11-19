import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/screens/dashboard/popular_category/category_widgets.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/vendors_details_page.dart';
import 'package:market_place_customer/utils/exports.dart';

class ViewAllPopularCategories extends StatefulWidget {
  final List<CategoryElement>? categoryData;
  final String? type;

  const ViewAllPopularCategories(
      {super.key, required this.categoryData, required this.type});

  @override
  State<ViewAllPopularCategories> createState() =>
      _ViewAllPopularCategoriesState();
}

class _ViewAllPopularCategoriesState extends State<ViewAllPopularCategories> {
  final ScrollController _scrollController = ScrollController();
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

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedVendors = widget.categoryData![selectedIndex].vendors ?? [];

    return Scaffold(
      appBar: customAppbar(title: "Popular Categories", context: context),
      body: Column(
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
                        setCategoryType(category.name.toString());
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.03, right: size.width * 0.03),
                      child: Column(
                        children: [
                          CategoryCard(
                              carWidth: size.width * 0.1,
                              imgHeight: size.width * 0.1,
                              imageUrl: category.image ?? '',
                              name: category.name ?? ''),
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
          BlocBuilder<FetchVendorsBloc, FetchVendorsState>(
            builder: (context, state) {
              if (state is FetchVendorsLoading) {
                return const BurgerKingShimmer();
              }

              if (state is FetchVendorsFailure) {
                return errorMessage(state.error, topSize: size.height * 0.4);
              }

              if (state is FetchVendorsSuccess) {
                final selectedVendors =
                    widget.categoryData![selectedIndex].vendors ?? [];

                return Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        crossAxisCount: 2,
                        mainAxisExtent: size.height * 0.23),
                    itemCount:
                        selectedVendors.length + (state.isPaginating ? 1 : 0),
                    itemBuilder: (_, index) {
                      if (index == selectedVendors.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      }

                      final vendor = selectedVendors[index];

                      return FutureBuilder<Map<String, String>>(
                        future: getVendorAddressAndDistance(
                          vendor.vendor!.lat.toString(),
                          vendor.vendor!.long.toString(),
                        ),
                        builder: (context, snap) {
                          final distance =
                              snap.hasData ? snap.data!['distance']! : '';

                          final isPercent =
                              vendor.maxOffer!.type == 'percentage';

                          return SubCategoryCard(
                            onTap: () => AppRouter().navigateTo(
                                context,
                                OffersDetailsPage(
                                    vendorId:
                                        vendor.vendor!.user!.id.toString())),
                            carWidth: size.width * 0.4,
                            imgHeight: size.width * 0.27,
                            imageUrl: vendor.vendor!.businessLogo ?? '',
                            name: vendor.vendor!.businessName ?? 'N/A',
                            location: vendor.vendor!.area ?? 'N/A',
                            distance: distance,
                            cuisines: vendor.vendor!.subcategory!.name ?? "",
                            offerText: isPercent
                                ? "🎁 Flat ${vendor.maxOffer!.amount}% OFF"
                                : "🎁 Flat ₹${vendor.maxOffer!.amount} OFF",
                          );
                        },
                      );
                    },
                  ),
                );
              }

              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}

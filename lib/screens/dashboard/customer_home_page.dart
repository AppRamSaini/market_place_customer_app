import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_dashbaord_offers/dashboard_offers_event.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_dashbaord_offers/dashboard_offers_state.dart';
import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/screens/dashboard/helper_widgets.dart';
import 'package:market_place_customer/screens/dashboard/nearby_vendors.dart';
import 'package:market_place_customer/screens/dashboard/popular_categories.dart';
import 'package:market_place_customer/screens/dashboard/search_vendors.dart';
import 'package:market_place_customer/screens/dashboard/view_all_vendors_page.dart';
import 'package:market_place_customer/screens/location/search_manual_location.dart';
import 'package:market_place_customer/screens/dashboard/most_visited_vendors.dart';
import 'package:market_place_customer/utils/exports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  double _appBarOpacity = 0.0;
  double _flexTitleOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    findLocation();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double maxOffset = size.height * 0.3;
      double opacity = (offset / maxOffset).clamp(0.0, 1.0);
      setState(() {
        _appBarOpacity = opacity;
        _flexTitleOpacity = 1.0 - opacity;
      });
    });
    refreshData();
  }

  refreshData() {
    context
        .read<FetchDashboardOffersBloc>()
        .add(DashboardOffersEvent(context: context));
  }

  bool searchValue = false;
  String location = 'fetching your location...';
  findLocation() => setState(() {
        var address = LocalStorage.getString(Pref.location);
        if (address != null) {
          location = address;
        }
      });

  late BuildContext dialogContext;

  Widget locationWidget(double opacity) => Opacity(
      opacity: opacity,
      child: SizedBox(
        width: size.width * 0.76,
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.location_on_outlined,
              color: AppColors.whiteColor, size: 26),
          title: Text("Popular Nearby Vendors",
              style: AppStyle.medium_15(opacity != _appBarOpacity
                  ? AppColors.redColor
                  : AppColors.whiteColor)),
          subtitle: Text(
            location ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppStyle.normal_12(AppColors.whiteColor),
          ),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await exitPageDialog(context);
        return shouldExit;
      },
      child: MultiBlocListener(
        listeners: [

          BlocListener<FetchDashboardOffersBloc, FetchDashboardOffersState>(
            listener: (context, state) {
              if (state is FetchDashboardOffersSuccess) {
              }
            },
          ),
        ],
        child: Scaffold(
          body:
              BlocBuilder<FetchDashboardOffersBloc, FetchDashboardOffersState>(
                  builder: (context, state) {
            if (state is FetchDashboardOffersLoading) {
              return const Center(child: BurgerKingShimmer());
            } else if (state is FetchDashboardOffersFailure) {
              return Padding(
                padding: const EdgeInsets.all(40),
                child: Center(
                  child: Text(
                    state.error.toString(),
                    textAlign: TextAlign.center,
                    style: AppStyle.medium_14(AppColors.redColor),
                  ),
                ),
              );
            } else if (state is FetchDashboardOffersSuccess) {
              final offersData = state.dashboardOffersModel.data;
              List<NearbyvendorElement> nearbyVendorsList =
                  offersData!.nearbyvendor!;

              List<PopularVendorElement> popularVendor =
                  offersData!.popularvendor!;

              List<VendorsCategory> popularCategory = offersData!.category!;

              return RefreshIndicator(
                onRefresh: () async => refreshData(),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Color.lerp(AppColors.white50,
                          AppColors.themeColor, _appBarOpacity),
                      expandedHeight: size.height * 0.36,
                      floating: false,
                      pinned: true,
                      snap: false,
                      stretch: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          locationWidget(_appBarOpacity),
                          Expanded(
                              child: searchBtn(context, _flexTitleOpacity)),
                          _flexTitleOpacity == 1.0
                              ? Opacity(
                                  opacity: _flexTitleOpacity,
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () {
                                            AppRouter().navigateTo(context,
                                                const SearchLocationPage());
                                          },
                                          child: CircleAvatar(
                                              radius: 15,
                                              backgroundColor:
                                                  AppColors.black70,
                                              child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: AppColors.white60)))))
                              : const SizedBox(),
                        ],
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          titlePadding: EdgeInsets.zero, // padding remove
                          background: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(40)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(Assets.homeBanner))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.032),
                              child: SafeArea(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    locationWidget(_flexTitleOpacity),
                                    Opacity(
                                      opacity: _flexTitleOpacity,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: AnimatedHintSearchField(
                                          onTap: () => AppRouter().navigateTo(
                                              context,
                                              const SearchVendorsPage()),
                                          readOnly: true,
                                          controller: controller,
                                          suffix: searchValue
                                              ? IconButton(
                                                  icon: Icon(Icons.cancel,
                                                      color: AppColors.white60,
                                                      size: 25),
                                                  onPressed: () {
                                                    setState(() =>
                                                        searchValue = false);
                                                    controller.clear();
                                                  })
                                              : null,
                                          fillColor: AppColors.black70,
                                          onChanged: (value) {
                                            if (value.length > 2) {
                                              setState(
                                                  () => searchValue = true);
                                            } else {}
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.015)),
                    SliverToBoxAdapter(
                        child: ViewAllWidget(
                            title: 'Nearby Vendors',
                            onPressed: () => AppRouter().navigateTo(
                                context,
                                ViewAllVendorsPage(
                                    popularCategory: popularCategory,
                                    type: "nearby")))),
                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.01)),
                    SliverToBoxAdapter(
                        child: NearbyVendors(
                            nearbyVendorsList: nearbyVendorsList)),
                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.015)),
                    SliverToBoxAdapter(
                        child: ViewAllWidget(
                            title: 'Popular Categories', onPressed: () {})),
                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.012)),
                    SliverToBoxAdapter(
                        child:
                            PopularCategories(categoryData: popularCategory)),
                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.02)),
                    SliverToBoxAdapter(
                        child: ViewAllWidget(
                            title: 'Most Visited Vendors',
                            onPressed: () => AppRouter().navigateTo(
                                context,
                                ViewAllVendorsPage(
                                    popularCategory: popularCategory,
                                    type: "popular")))),
                    SliverToBoxAdapter(
                        child:
                            MostVisitedVendors(popularVendor: popularVendor)),
                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.015)),
                    // SliverToBoxAdapter(
                    //     child: ViewAllWidget(
                    //         title: 'Top Rated Vendors', onPressed: () {})),
                    // SliverToBoxAdapter(child: SizedBox(height: size.height * 0.03)),
                    // const SliverToBoxAdapter(child: TopRatedVendors()),
                    // SliverToBoxAdapter(child: SizedBox(height: size.height * 0.03)),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_dashbaord_offers/dashboard_offers_event.dart';
import 'package:market_place_customer/screens/dashboard/most_visited_vendors.dart';
import 'package:market_place_customer/screens/dashboard/nearby_vendors.dart';
import 'package:market_place_customer/screens/dashboard/popular_categories.dart';
import 'package:market_place_customer/screens/dashboard/search_vendors.dart';
import 'package:market_place_customer/screens/dashboard/view_all_vendors_page.dart';
import 'package:market_place_customer/screens/dilogs/exit_page_dilog.dart';
import 'package:market_place_customer/screens/location/search_manual_location.dart';
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

  bool searchValue = false;
  String location = 'Fetching your location...';

  @override
  void initState() {
    super.initState();
    findLocation();
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      final maxOffset = size.height * 0.3;
      final opacity = (offset / maxOffset).clamp(0.0, 1.0);
      setState(() {
        _appBarOpacity = opacity;
        _flexTitleOpacity = 1.0 - opacity;
      });
    });
  }

  void findLocation() {
    final address = LocalStorage.getString(Pref.location);
    if (address != null) {
      setState(() => location = address);
    }
  }

  Future<void> refreshData() async {
    context.read<FetchDashboardOffersBloc>().add(
          DashboardOffersEvent(context: context),
        );
  }

  Widget locationWidget(double opacity) => AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: opacity,
        child: SizedBox(
          width: size.width * 0.76,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.location_on_outlined,
                color: AppColors.whiteColor, size: 26),
            title: Text(
              "Popular Nearby Vendors",
              style: AppStyle.medium_15(opacity != _appBarOpacity
                  ? AppColors.redColor
                  : AppColors.whiteColor),
            ),
            subtitle: Text(
              location,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.normal_12(AppColors.whiteColor),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        bool? shouldExit = await showExitConfirmationSheet(context);
        if (shouldExit != null && shouldExit == true) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: BlocBuilder<FetchDashboardOffersBloc, FetchDashboardOffersState>(
          builder: (context, state) {
            if (state is FetchDashboardOffersLoading) {
              return const Center(child: BurgerKingShimmer());
            }

            if (state is FetchDashboardOffersFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    state.error.toString(),
                    textAlign: TextAlign.center,
                    style: AppStyle.medium_14(AppColors.redColor),
                  ),
                ),
              );
            }

            if (state is FetchDashboardOffersSuccess) {
              final offersData = state.dashboardOffersModel.data!;
              final nearbyVendorsList = offersData.nearbyvendor ?? [];
              final popularVendor = offersData.popularvendor ?? [];
              final popularCategory = offersData.category ?? [];

              return RefreshIndicator(
                onRefresh: refreshData,
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
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
                          titlePadding: EdgeInsets.zero,
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
                                        child: SlideInRight(
                                          duration:
                                              const Duration(milliseconds: 700),
                                          child: AnimatedHintSearchField(
                                            onTap: () => AppRouter().navigateTo(
                                                context,
                                                const SearchVendorsPage()),
                                            readOnly: true,
                                            controller: controller,
                                            suffix: searchValue
                                                ? IconButton(
                                                    icon: Icon(Icons.cancel,
                                                        color:
                                                            AppColors.white60,
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),

                    // // 🔹 Modern Animated AppBar
                    // SliverAppBar(
                    //   expandedHeight: size.height * 0.36,
                    //   pinned: true,
                    //   stretch: true,
                    //   backgroundColor: Color.lerp(AppColors.whiteColor,
                    //       AppColors.themeColor, _appBarOpacity),
                    //   flexibleSpace: LayoutBuilder(
                    //     builder: (context, constraints) {
                    //       final t = (constraints.maxHeight - kToolbarHeight) /
                    //           (size.height * 0.36 - kToolbarHeight);
                    //       return Stack(
                    //         fit: StackFit.expand,
                    //         children: [
                    //           // Background with Gradient Overlay
                    //           Opacity(
                    //             opacity: 0.9,
                    //             child: Image.asset(
                    //               Assets.homeBanner,
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //           Container(
                    //             decoration: BoxDecoration(
                    //               gradient: LinearGradient(
                    //                 begin: Alignment.topCenter,
                    //                 end: Alignment.bottomCenter,
                    //                 colors: [
                    //                   Colors.black.withOpacity(0.3),
                    //                   Colors.black.withOpacity(0.5),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           // Frosted blur effect
                    //           // if (_appBarOpacity > 0.6)
                    //           //   BackdropFilter(
                    //           //     filter:
                    //           //         ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    //           //     child: Container(color: Colors.black12),
                    //           //   ),
                    //
                    //           SafeArea(
                    //             child: Padding(
                    //               padding: const EdgeInsets.symmetric(
                    //                   horizontal: 16, vertical: 12),
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   FadeInDown(
                    //                       duration:
                    //                           const Duration(milliseconds: 600),
                    //                       child: locationWidget(
                    //                           _flexTitleOpacity)),
                    //                   const SizedBox(height: 8),
                    //                   AnimatedOpacity(
                    //                     duration:
                    //                         const Duration(milliseconds: 600),
                    //                     opacity: _flexTitleOpacity,
                    //                     child: SlideInRight(
                    //                       duration:
                    //                           const Duration(milliseconds: 700),
                    //                       child: AnimatedHintSearchField(
                    //                         onTap: () => AppRouter().navigateTo(
                    //                             context,
                    //                             const SearchVendorsPage()),
                    //                         readOnly: true,
                    //                         controller: controller,
                    //                         suffix: searchValue
                    //                             ? IconButton(
                    //                                 icon: Icon(Icons.cancel,
                    //                                     color:
                    //                                         AppColors.white60,
                    //                                     size: 22),
                    //                                 onPressed: () {
                    //                                   setState(() =>
                    //                                       searchValue = false);
                    //                                   controller.clear();
                    //                                 },
                    //                               )
                    //                             : null,
                    //                         fillColor: AppColors.black70,
                    //                         onChanged: (v) {
                    //                           if (v.length > 2) {
                    //                             setState(
                    //                                 () => searchValue = true);
                    //                           }
                    //                         },
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),

                    // 🔹 Content Sections with Staggered Animations
                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.02)),

                    SliverToBoxAdapter(
                        child: FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 100),
                      child: ViewAllWidget(
                        title: 'Nearby Vendors',
                        onPressed: () => AppRouter().navigateTo(
                          context,
                          ViewAllVendorsPage(
                              popularCategory: popularCategory, type: "nearby"),
                        ),
                      ),
                    )),

                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.01)),

                    SliverToBoxAdapter(
                        child: FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 200),
                      child:
                          NearbyVendors(nearbyVendorsList: nearbyVendorsList),
                    )),

                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.03)),

                    SliverToBoxAdapter(
                        child: FadeInUp(
                      duration: const Duration(milliseconds: 900),
                      delay: const Duration(milliseconds: 300),
                      child: ViewAllWidget(
                          title: 'Popular Categories', onPressed: () {}),
                    )),

                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.015)),

                    SliverToBoxAdapter(
                        child: FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 400),
                      child: PopularCategories(categoryData: popularCategory),
                    )),

                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.03)),

                    SliverToBoxAdapter(
                        child: FadeInUp(
                      duration: const Duration(milliseconds: 1100),
                      delay: const Duration(milliseconds: 500),
                      child: ViewAllWidget(
                        title: 'Most Visited Vendors',
                        onPressed: () => AppRouter().navigateTo(
                          context,
                          ViewAllVendorsPage(
                              popularCategory: popularCategory,
                              type: "popular"),
                        ),
                      ),
                    )),

                    SliverToBoxAdapter(
                        child: FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      delay: const Duration(milliseconds: 600),
                      child: MostVisitedVendors(popularVendor: popularVendor),
                    )),

                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.04)),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

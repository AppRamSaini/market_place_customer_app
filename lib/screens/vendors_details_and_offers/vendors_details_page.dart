import 'package:carousel_slider/carousel_slider.dart';
import 'package:market_place_customer/data/models/vendor_details_model.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/offers_details.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/vendor_details_helper.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/vendor_helper_widgets.dart';
import 'package:market_place_customer/utils/exports.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../bloc/vendors_data_bloc/view_vendors_details/vendor_details_state.dart';

class OffersDetailsPage extends StatefulWidget {
  final String vendorId;

  const OffersDetailsPage({super.key, required this.vendorId});

  @override
  State<OffersDetailsPage> createState() => _OffersDetailsPageState();
}

class _OffersDetailsPageState extends State<OffersDetailsPage> {
  final ScrollController _scrollController = ScrollController();

  double _appBarOpacity = 0.0;
  double _flexTitleOpacity = 1.0;
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double maxOffset = size.height * 0.3;

      double opacity = (offset / maxOffset).clamp(0.0, 1.0);
      setState(() {
        _appBarOpacity = opacity; // appbar title opacity
        _flexTitleOpacity = 1.0 - opacity; // flexible title opacity
      });
    });
    refreshData();
  }

  refreshData() {
    context.read<VendorDetailsBloc>().add(ViewVendorDetailsEvent(
        context: context, vendorId: widget.vendorId.toString()));
  }

  late BuildContext dialogContext;

  /// calculate distance
  Map<String, Map<String, String>> locationCache = {};

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
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentBloc, PaymentState>(listener: (context, state) {
          if (state is PaymentSuccess) {
            // onRefreshData();
          }
        })
      ],
      child: Scaffold(
        body: BlocBuilder<VendorDetailsBloc, VendorDetailsState>(
          builder: (context, state) {
            if (state is VendorDetailsLoading) {
              return const BurgerKingShimmer();
            } else if (state is VendorDetailsFailure) {
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
            } else if (state is VendorDetailsSuccess) {
              final vendorsData = state.vendorsDetailsModel.data;

              List<String> businessImages =
                  vendorsData!.businessDetails!.businessImage ?? [];
              List<Offer>? offers = vendorsData.offers ?? [];

              List<Similar>? similarVendors = vendorsData.similar ?? [];

              final timingText = getTodayTiming(vendorsData.timing!);
              final allTimings = getAllWeekTimings(vendorsData.timing!);
              final holiday = getExtraHolidayText(vendorsData.timing!);

              final vendor = vendorsData.businessDetails;
              final lat = vendor!.lat ?? "0.0";
              final lng = vendor.long ?? "0.0";
              final key = '$lat,$lng';

              return RefreshIndicator(
                onRefresh: () async => refreshData(),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      expandedHeight: size.height * 0.3,
                      floating: false,
                      pinned: true,
                      snap: false,
                      stretch: true,
                      backgroundColor: AppColors.themeColor,
                      leading: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.theme10.withOpacity(0.1)),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back_ios_new,
                                size: 20,
                                color: _flexTitleOpacity == 1.0
                                    ? AppColors.blackColor
                                    : AppColors.whiteColor),
                          ),
                        ),
                      ),
                      title: Opacity(
                          opacity: _appBarOpacity,
                          child: Text(
                              vendorsData.businessDetails!.businessName ?? '',
                              style: AppStyle.medium_15(AppColors.whiteColor))),
                      flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          titlePadding:
                              const EdgeInsets.only(left: 10, bottom: 10),
                          title: Opacity(
                              opacity: _flexTitleOpacity,
                              child: Text(
                                  vendorsData.businessDetails!.businessName ??
                                      '',
                                  textScaleFactor: 0.8,
                                  style: AppStyle.medium_14(
                                      AppColors.whiteColor))),
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (businessImages.isEmpty)
                                FadeInImage(
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    placeholder: const AssetImage(Assets.dummy),
                                    image: NetworkImage(vendorsData
                                            .businessDetails!.businessLogo
                                            .toString() ??
                                        ''),
                                    imageErrorBuilder: (_, child, st) =>
                                        Image.asset(Assets.dummy,
                                            fit: BoxFit.cover))
                              else
                                ...List.generate(businessImages.length,
                                    (index) {
                                  bool isActive = index == _currentIndex;
                                  return AnimatedOpacity(
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    // Fade duration
                                    opacity: isActive ? 1.0 : 0.0,
                                    curve: Curves.easeInOut,
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      placeholder:
                                          const AssetImage(Assets.dummy),
                                      image: businessImages.isNotEmpty
                                          ? NetworkImage(
                                              businessImages[index] ?? '')
                                          : const AssetImage(Assets.dummy)
                                              as ImageProvider,
                                      imageErrorBuilder: (_, child, st) =>
                                          Image.asset(Assets.dummy,
                                              fit: BoxFit.cover),
                                    ),
                                  );
                                }),

                              // CarouselSlider for controlling the page index
                              if (businessImages.isEmpty)
                                const SizedBox()
                              else
                                CarouselSlider.builder(
                                  itemCount: businessImages.length,
                                  itemBuilder: (context, index, realIndex) {
                                    return const SizedBox.shrink();
                                  },
                                  carouselController: _carouselController,
                                  options: CarouselOptions(
                                    height: double.infinity,
                                    viewportFraction: 1.0,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 5),
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                  ),
                                ),

                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (businessImages.isEmpty)
                                        const SizedBox()
                                      else
                                        AnimatedSmoothIndicator(
                                          activeIndex: _currentIndex,
                                          count: 7,
                                          duration: const Duration(
                                              milliseconds: 1800),
                                          effect: const ScrollingDotsEffect(
                                            activeDotColor: Colors.white,
                                            dotColor: Colors.white54,
                                            dotHeight: 3,
                                            dotWidth: 12,
                                            spacing: 4,
                                            radius: 4,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.015)),
                    SliverToBoxAdapter(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              dense: true,
                              initiallyExpanded: false,
                              backgroundColor: AppColors.transparent,
                              childrenPadding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              title: Row(
                                children: [
                                  Icon(Icons.access_time_rounded,
                                      size: 18, color: AppColors.black20),
                                  const SizedBox(width: 5),
                                  Text(timingText ?? '',
                                      style:
                                          AppStyle.normal_14(AppColors.black20))
                                ],
                              ),
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: allTimings.entries.map((e) {
                                      return Card(
                                          color: AppColors.whiteColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                Text("${e.key} : ${e.value}"),
                                          ));
                                    }).toList()),
                                if (holiday != null)
                                  Card(
                                      color: AppColors.whiteColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(holiday),
                                      ))
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: size.height * 0.01,
                              left: size.width * 0.03,
                              right: size.width * 0.03),
                          child: FadeInUp(
                              from: 50,
                              duration: const Duration(milliseconds: 600),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on_outlined,
                                      size: 20),
                                  const SizedBox(width: 5),
                                  FutureBuilder<Map<String, String>>(
                                      future: getVendorAddressAndDistance(
                                          lat.toString(), lng.toString()),
                                      builder: (context, snapshot) {
                                        String distance = '';
                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.hasData) {
                                          distance =
                                              snapshot.data!['distance'] ?? '';
                                        } else if (locationCache
                                            .containsKey(key)) {
                                          distance =
                                              locationCache[key]!['distance'] ??
                                                  '';
                                        } else {
                                          distance = '...';
                                        }

                                        return Flexible(
                                            child: Text(
                                                "${vendorsData.businessDetails!.address ?? ''}  • $distance",
                                                style: AppStyle.normal_14(
                                                    AppColors.black20)));
                                      }),
                                ],
                              )),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Padding(
                            padding: EdgeInsets.only(left: size.width * 0.03),
                            child: Text("Popular Offers",
                                style:
                                    AppStyle.medium_18(AppColors.themeColor))),
                        SizedBox(height: size.height * 0.01),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(offers.length, (index) {
                            var offersData = offers[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.03,
                                  right: index == offers.length - 1
                                      ? size.width * 0.03
                                      : 0.0),
                              child: SizedBox(
                                width: size.height * 0.19,
                                child: GestureDetector(
                                    onTap: () {
                                      bool isExpired = offersData.flat != null
                                          ? (offersData.flat!.isExpired ??
                                              false)
                                          : (offersData.percentage?.isExpired ??
                                              false);
                                      if (isExpired) {
                                        showOfferExpiredDialog(context);
                                        return;
                                      }

                                      AppRouter().navigateTo(
                                        context,
                                        ViewOffersDetails(
                                            offersId: offersData.id ?? ''),
                                      );
                                    },
                                    child: FadeInRightBig(
                                      duration: Duration(
                                          milliseconds: 800 + (index * 200)),
                                      child: OffersDataCardWidget(
                                        imgHeight: size.height * 0.16,
                                        imgWidth: size.height * 0.19,
                                        isExpired: offersData.flat != null
                                            ? offersData.flat!.isExpired ??
                                                false
                                            : offersData
                                                    .percentage!.isExpired ??
                                                false,
                                        isPurchased:
                                            offersData.purchaseStatus ?? false,
                                        imageUrl: offersData.flat != null
                                            ? offersData.flat!.offerImage
                                                .toString()
                                            : offersData.percentage!.offerImage
                                                .toString(),
                                        name: offersData.flat != null
                                            ? offersData.flat!.title.toString()
                                            : offersData.percentage!.title
                                                .toString(),
                                        amount:
                                            "Offer Amount ₹${offersData.flat != null ? offersData.flat!.amount.toString() : offersData.percentage!.amount.toString()}",
                                        offerText: offersData.flat != null
                                            ? "Flat ₹${offersData.flat!.discountPercentage.toString()}"
                                            : "Flat ${offersData.percentage!.discountPercentage.toString()}%",
                                      ),
                                    )),
                              ),
                            );
                          })),
                        ),
                        businessImages.isEmpty
                            ? const SizedBox()
                            : Column(
                                children: [
                                  SizedBox(height: size.height * 0.03),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.03),
                                      child: Text("Gallery",
                                          style: AppStyle.medium_18(
                                              AppColors.black20))),
                                ],
                              ),
                        SizedBox(height: size.height * 0.01),
                      ],
                    )),
                    SliverToBoxAdapter(
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.03,
                                right: size.width * 0.03,
                                bottom: size.height * 0.02),
                            child: buildMediaMessage(context, businessImages))),
                    SliverToBoxAdapter(
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.03,
                                bottom: size.height * 0.01),
                            child: Text("Similar Vendors",
                                style:
                                    AppStyle.medium_18(AppColors.themeColor)))),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            similarVendors.length,
                            (index) {
                              final vendor = similarVendors[index];
                              final lat = vendor.vendor!.lat!;
                              final lng = vendor.vendor!.long!;
                              final key = '$lat,$lng';

                              return FutureBuilder<Map<String, String>>(
                                future: getVendorAddressAndDistance(
                                    lat.toString(), lng.toString()),
                                builder: (context, snapshot) {
                                  String distance = '';

                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    distance = snapshot.data!['distance']!;
                                  } else if (locationCache.containsKey(key)) {
                                    distance = locationCache[key]!['distance']!;
                                  }

                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.03,
                                        right:
                                            index == similarVendors.length - 1
                                                ? size.width * 0.03
                                                : size.height * 0.0),
                                    child: SizedBox(
                                      width: size.width * 0.9,
                                      child: GestureDetector(
                                          onTap: () => AppRouter().navigateTo(
                                              context,
                                              OffersDetailsPage(
                                                  vendorId:
                                                      vendor.vendor!.user!.id ??
                                                          '')),
                                          child: FadeInUp(
                                            duration: Duration(
                                                milliseconds:
                                                    300 + (index * 120)),
                                            child: NearbyRestaurantCard(
                                              carWidth: size.width * 0.9,
                                              imgHeight: size.height * 0.3,
                                              isPurchased: false,
                                              isExpired: false,
                                              imageUrl:
                                                  vendor.vendor!.businessLogo ??
                                                      '',
                                              name:
                                                  vendor.vendor!.businessName ??
                                                      '',
                                              location:
                                                  "${vendor.vendor!.area}, ${vendor.vendor!.city}" ??
                                                      '',
                                              distance: distance,
                                              cuisines: vendor
                                                      .vendor!.category!.name ??
                                                  '',
                                              flatData: vendor.maxOffer != null
                                                  ? vendor.maxOffer!.type ==
                                                          'percentage'
                                                      ? "Flat ${vendor.maxOffer!.amount}%"
                                                      : "Flat ₹${vendor.maxOffer!.amount}"
                                                  : 'FREE',
                                              offerText: vendor.maxOffer != null
                                                  ? vendor.maxOffer!.type ==
                                                          'percentage'
                                                      ? "Flat ${vendor.maxOffer!.amount}% OFF"
                                                      : "Flat ₹${vendor.maxOffer!.amount} OFF"
                                                  : '',
                                              offersCounts: vendor
                                                          .activeOffersCount! >
                                                      0
                                                  ? '${vendor.activeOffersCount}+ OFFER'
                                                  : '',
                                            ),
                                          )),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.15)),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

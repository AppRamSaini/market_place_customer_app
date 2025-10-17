import 'package:carousel_slider/carousel_slider.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_dashbaord_offers/dashboard_offers_bloc.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_dashbaord_offers/dashboard_offers_event.dart';
import 'package:market_place_customer/screens/profile/business_gallery.dart';
import 'package:market_place_customer/utils/exports.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../bloc/fetch_vendors/fetch_offers/fetch_offers_bloc.dart';
import '../../bloc/fetch_vendors/fetch_offers/fetch_offers_event.dart';

class OffersDetailsPage extends StatefulWidget {
  const OffersDetailsPage({super.key});

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
    // refreshData();
  }

  refreshData() {
    context.read<FetchOffersBloc>().add(GetOffersEvent(context: context));
    context
        .read<FetchDashboardOffersBloc>()
        .add(DashboardOffersEvent(context: context));
  }

  late BuildContext dialogContext;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteOffersBloc, DeleteOffersState>(
          listener: (context, state) {
            EasyLoading.dismiss();
            if (state is DeleteOffersLoading) {
              EasyLoading.show();
            } else if (state is DeleteOffersSuccess) {
              final data = state.offersData;
              snackBar(context, data['message'].toString(), AppColors.green);
              refreshData();
            } else if (state is DeleteOffersFailure) {
              snackBar(context, state.error.toString(), AppColors.redColor);
              refreshData();
            } else if (state is DeleteOffersInvalidResult) {
              EasyLoading.dismiss();
            } else {
              EasyLoading.dismiss();
            }
          },
        ),

        BlocListener<AddOffersBloc, AddOffersState>(
          listener: (context, state) {
            if (state is AddOffersSuccess) {
              refreshData();
            }
          },
        ),
        BlocListener<UpdateOffersBloc, UpdateOffersState>(
          listener: (context, state) {
            if (state is UpdateOffersSuccess) {
              refreshData();
            }
          },
        ),
      ],
      child: Scaffold(
          body:

              // BlocBuilder<FetchDashboardOffersBloc,
              //     FetchDashboardOffersState>(builder: (context, state) {
              //   if (state is FetchDashboardOffersLoading) {
              //     return Center(child: BurgerKingShimmer());
              //   } else if (state is FetchDashboardOffersFailure) {
              //     return
              //
              //       Padding(
              //       padding: const EdgeInsets.all(40),
              //       child: Center(
              //         child: Text(
              //           state.error.toString(),
              //           textAlign: TextAlign.center,
              //           style: AppStyle.medium_14(AppColors.redColor),
              //         ),
              //       ),
              //     );
              //   } else if (state is FetchDashboardOffersSuccess) {
              //     final offersData = state.merchantDashboardModel.data;
              //
              //     var stats = offersData!.stats;
              //     var businessImages = offersData.vendors!.businessImage;
              //
              //     List dataList = [
              //       {"icon": Assets.totalSales, "title": "Total Sales","stats":stats!.totalSales??0},
              //       {"icon": Assets.redeemOffers, "title": "Redeem Offers","stats":stats!.redeemedOfferes??0},
              //       {"icon": Assets.pendingOffers, "title": "Pending offers","stats":stats!.pendingOffers??0},
              //       {"icon": Assets.totalCustomers, "title": "Total Customers","stats":stats!.totalCustomers??0},
              //     ];
              //     return

              RefreshIndicator(
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
              title: Opacity(
                  opacity: _appBarOpacity,
                  child: Text("The Burger Farm " ?? '',
                      style: AppStyle.medium_22(AppColors.whiteColor))),
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  titlePadding: const EdgeInsets.only(left: 10, bottom: 10),
                  title: Opacity(
                      opacity: _flexTitleOpacity,
                      child: Text("The Burger Farm " ?? '',
                          style: AppStyle.medium_15(AppColors.whiteColor))),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      ...List.generate(images!.length, (index) {
                        bool isActive = index == _currentIndex;
                        return AnimatedOpacity(
                          duration: const Duration(
                              milliseconds: 2000), // Fade duration
                          opacity: isActive ? 1.0 : 0.0,
                          curve: Curves.easeInOut,
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            width: double.infinity,
                            placeholder: const AssetImage(Assets.dummy),
                            image: images![index]['url'].isNotEmpty
                                ? NetworkImage(images![index]['url'])
                                : const AssetImage(Assets.dummy) as ImageProvider,
                            imageErrorBuilder: (_, child, st) =>
                                Image.asset(Assets.dummy, fit: BoxFit.cover),
                          ),
                        );
                      }),

                      // CarouselSlider for controlling the page index
                      CarouselSlider.builder(
                        itemCount: images!.length,
                        itemBuilder: (context, index, realIndex) {
                          return const SizedBox.shrink();
                        },
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          height: double.infinity,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
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
                              AnimatedSmoothIndicator(
                                activeIndex: _currentIndex,
                                count: 7,
                                duration: const Duration(milliseconds: 1800),
                                effect: const ScrollingDotsEffect(
                                  activeDotColor: Colors.white,
                                  dotColor: Colors.white54,
                                  dotHeight: 4,
                                  dotWidth: 20,
                                  spacing: 8,
                                  radius: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            SliverToBoxAdapter(child: SizedBox(height: size.height * 0.015)),
            SliverToBoxAdapter(child: buildMediaMessage(images))
          ],
        ),
      )
          // ;
          //           } else {
          //             return SizedBox();
          //           }
          //         }),

          ),
    );
  }
}

Widget buildMediaMessage(List imageList) {
  if ((imageList == null || imageList.isEmpty)) {
    return const SizedBox(); // Nothing to show
  }

  final mediaCount = imageList.length;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (imageList.isNotEmpty)Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          ...List.generate(
            mediaCount > 8 ? 8 : mediaCount,
                (index) {
              final url = imageList[index]['url'];
              final isLastAndMore = index == 4 && mediaCount > 5;

              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      url,
                      width: index == 0 ? 220 : 110,
                      height: index == 0 ? 220 : 110,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 50),
                      color:
                      isLastAndMore ? Colors.black.withOpacity(0.4) : null,
                      colorBlendMode:
                      isLastAndMore ? BlendMode.darken : null,
                    ),
                  ),
                  if (isLastAndMore)
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          '+${mediaCount - 3}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          // 👇 Ye aapki extra image hai (burger ke pass dikhani ho)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/extra_burger.png", // ya koi bhi URL
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
        ],
      )

    ],
  );
}

String getMediaType(String ext) {
  final lowerExt = ext.toLowerCase();
  if (['jpg', 'jpeg', 'png', 'gif'].contains(lowerExt)) return 'image';
  if (['mp4', 'mov'].contains(lowerExt)) return 'video';
  if (['mp3', 'aac'].contains(lowerExt)) return 'audio';
  if (['pdf', 'doc', 'docx'].contains(lowerExt)) return 'document';
  return 'file';
}

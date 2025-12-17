import 'package:market_place_customer/screens/purchased_history/helper_widgets.dart';
import 'package:market_place_customer/utils/exports.dart';

import '../../bloc/vendors_data_bloc/used_offers_details/used_offers_bloc.dart';
import '../../bloc/vendors_data_bloc/used_offers_details/used_offers_event.dart';
import '../../bloc/vendors_data_bloc/used_offers_details/used_offers_state.dart';
import '../vendors_details_and_offers/expire_offers_timers.dart';
import '../vendors_details_and_offers/vendor_details_helper.dart';

class UsedOfferDetailsPage extends StatefulWidget {
  final String offersId;

  const UsedOfferDetailsPage({super.key, required this.offersId});

  @override
  State<UsedOfferDetailsPage> createState() => _UsedOfferDetailsPageState();
}

class _UsedOfferDetailsPageState extends State<UsedOfferDetailsPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  double _appBarOpacity = 0.0;
  double _flexTitleOpacity = 1.0;

  final double _calculatedDiscount = 0.0;
  final double _payableAmount = 0.0;
  final bool _isValidAmount = false;

  // For subtle CTA animation
  late AnimationController _ctaController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _ctaController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _onRefreshData();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double maxOffset = size.height * 0.28;

      double opacity = (offset / maxOffset).clamp(0.0, 1.0);
      setState(() {
        _appBarOpacity = opacity;
        _flexTitleOpacity = 1.0 - opacity;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _ctaController.dispose();
    super.dispose();
  }

  Future _onRefreshData() async {
    context.read<UsedOffersBloc>().add(
        UsedOffersDetailsEvent(context: context, offersId: widget.offersId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _onRefreshData),
      body: BlocBuilder<UsedOffersBloc, UsedOffersState>(
        builder: (context, state) {
          if (state is UsedOffersLoading) {
            return const BurgerKingShimmer();
          } else if (state is UsedOffersFailure) {
            return errorMessage(state.error.toString());
          } else if (state is UsedOffersSuccess) {
            final offersData = state.offersDetailModel.data;
            final singleOffer = offersData!.offer;

            final imageUrl = singleOffer == null
                ? 'null'
                : singleOffer.flat?.offerImage?.toString() ??
                    singleOffer.percentage?.offerImage?.toString();

            if (singleOffer == null) {
              return errorMessage("Offers Not Found!");
            }

            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: _onRefreshData,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          expandedHeight: size.height * 0.26,
                          floating: false,
                          pinned: true,
                          stretch: true,
                          backgroundColor: AppColors.themeColor,
                          leading: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppColors.theme10.withOpacity(0.08)),
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
                              capitalizeFirstLetter(singleOffer.flat != null
                                  ? singleOffer.flat!.title.toString()
                                  : singleOffer.percentage!.title.toString()),
                              style: AppStyle.normal_18(AppColors.whiteColor),
                            ),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Stack(
                              fit: StackFit.expand,
                              children: [
                                FadeInImage(
                                  placeholder: const AssetImage(Assets.dummy),
                                  imageErrorBuilder: (_, child, st) =>
                                      Image.asset(Assets.dummy,
                                          fit: BoxFit.cover),
                                  image: imageUrl!.isNotEmpty
                                      ? NetworkImage(imageUrl)
                                      : const AssetImage(Assets.dummy)
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                ),

                                // dark gradient for text contrast
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.35),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),

                                // bottom frosted container with title + tag
                                Positioned(
                                  left: 16,
                                  right: 16,
                                  bottom: 18,
                                  child: FadeInUp(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: AppColors.whiteColor
                                                .withOpacity(0.9),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      capitalizeFirstLetter(
                                                          singleOffer.flat !=
                                                                  null
                                                              ? singleOffer
                                                                  .flat!.title
                                                                  .toString()
                                                              : singleOffer
                                                                  .percentage!
                                                                  .title
                                                                  .toString()),
                                                      style: AppStyle.medium_16(
                                                          AppColors.blackColor),
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    singleOffer.flat != null
                                                        ? "Flat ₹${singleOffer.flat!.discountPercentage} off"
                                                        : "Flat ${singleOffer.percentage!.discountPercentage}% off",
                                                    style: AppStyle.normal_12(
                                                        AppColors.black50),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            // small pill showing validity
                                            OfferExpiryTimer(
                                              expiryDate:
                                                  singleOffer.flat != null
                                                      ? singleOffer
                                                          .flat!.expiryDate!
                                                      : singleOffer.percentage!
                                                          .expiryDate!,
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Title + subtitle
                        SliverToBoxAdapter(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.04,
                                  top: size.height * 0.02,
                                  right: size.width * 0.04),
                              child: FadeInDown(
                                duration: const Duration(milliseconds: 500),
                                child: Text(
                                  capitalizeFirstLetter(singleOffer.flat != null
                                      ? "${singleOffer.flat!.title} • Flat ₹${singleOffer.flat!.discountPercentage} Off"
                                      : "${singleOffer.percentage!.title} • ${singleOffer.percentage!.discountPercentage}% Off"),
                                  style:
                                      AppStyle.medium_20(AppColors.themeColor),
                                ),
                              )),
                        ),

                        SliverToBoxAdapter(
                            child: SizedBox(height: size.height * 0.02)),

                        // Input Card
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03),
                            child: FadeInLeftBig(
                              duration: const Duration(milliseconds: 500),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.04,
                                    vertical: size.height * 0.02),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    )
                                  ],
                                  border: Border.all(
                                      color:
                                          AppColors.theme10.withOpacity(0.4)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Amount Summary",
                                        style: AppStyle.medium_16(
                                            AppColors.blackColor)),
                                    SizedBox(height: size.height * 0.01),

                                    // Live calculation summary (animated)
                                    AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Container(
                                        key: ValueKey(
                                            'summary_${_payableAmount}_$_calculatedDiscount'),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: AppColors.themeColor
                                              .withOpacity(0.06),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.themeColor
                                                  .withOpacity(0.12)),
                                        ),
                                        child: Column(
                                          children: [
                                            _summaryRow("Total Amount",
                                                "₹${offersData.totalAmount!.toStringAsFixed(2)}"),
                                            const SizedBox(height: 6),
                                            _summaryRow("Discount",
                                                "- ₹${offersData.discount!.toStringAsFixed(2)}"),
                                            const Divider(),
                                            _summaryRow("You Pay",
                                                "₹${offersData.finalAmount!.toStringAsFixed(2)}",
                                                highlight: true),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Offer description tile
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03,
                                vertical: size.height * 0.02),
                            child: customExpansionTile(
                              subTitle: singleOffer.flat != null
                                  ? "Get flat ₹${singleOffer.flat!.maxDiscountCap} Discount on all orders above ₹${singleOffer.flat!.minBillAmount}"
                                  : "Get flat ${singleOffer.percentage!.discountPercentage}% Discount on all orders above ₹${singleOffer.percentage!.minBillAmount}",
                              context: context,
                              txt: "Offers Description",
                              children: [
                                Divider(color: AppColors.theme5),
                                // trackerData row as you have
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FadeInUp(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: trackerData(
                                            title: "Min Bill Amt.",
                                            subTitle:
                                                "₹${singleOffer.flat != null ? singleOffer.flat!.minBillAmount : singleOffer.percentage!.minBillAmount}",
                                            bgColor: AppColors.themeColor
                                                .withOpacity(0.1),
                                            txtColor: AppColors.themeColor)),
                                    FadeInUp(
                                        duration:
                                            const Duration(milliseconds: 700),
                                        child: trackerData(
                                            title: "Max. Discount",
                                            subTitle:
                                                "₹${singleOffer.flat != null ? singleOffer.flat!.maxDiscountCap : singleOffer.percentage!.maxDiscountCap}",
                                            bgColor: AppColors.themeColor
                                                .withOpacity(0.1),
                                            txtColor: AppColors.themeColor)),
                                    FadeInUp(
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        child: trackerData(
                                            title: "Validity",
                                            subTitle: singleOffer.flat != null
                                                ? formatDateAMPM(singleOffer
                                                    .flat!.expiryDate!)
                                                : formatDateAMPM(singleOffer
                                                    .percentage!.expiryDate!),
                                            bgColor: AppColors.themeColor
                                                .withOpacity(0.1),
                                            txtColor: AppColors.themeColor)),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.02),
                              ],
                            ),
                          ),
                        ),

                        // Terms & conditions
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03),
                            child: customExpansionTile(
                              subTitle:
                                  "Tap to expand and read terms & conditions",
                              context: context,
                              txt: "Terms & Conditions",
                              children: [
                                ..._buildTermsTiles(singleOffer),
                              ],
                            ),
                          ),
                        ),

                        const SliverToBoxAdapter(child: SizedBox(height: 120)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: highlight
                ? AppStyle.medium_14(AppColors.blackColor)
                : AppStyle.normal_13(AppColors.black50)),
        Text(value,
            style: highlight
                ? AppStyle.medium_14(AppColors.themeColor)
                : AppStyle.normal_13(AppColors.black50)),
      ],
    );
  }

  List<Widget> _buildTermsTiles(dynamic singleOffer) {
    List<String> termsData = [
      "Only one coupon can be applied per order or transaction.",
      singleOffer.flat != null
          ? "This coupon offers a flat ₹${singleOffer.flat!.maxDiscountCap} discount on eligible purchases."
          : "This coupon offers a flat ${singleOffer.percentage!.discountPercentage}% discount on eligible purchases.",
      "The coupon is valid only on transactions with a minimum bill amount of ₹${singleOffer.flat != null ? singleOffer.flat!.minBillAmount : singleOffer.percentage!.minBillAmount}.",
      "The maximum discount per transaction is ₹${singleOffer.flat != null ? singleOffer.flat!.maxDiscountCap : singleOffer.percentage!.maxDiscountCap}",
      "Coupons are valid only within the specified period and subject to availability.",
      "Coupons are non-transferable, non-exchangeable, and cannot be redeemed for cash or any other value.",
    ];

    return List.generate(
      termsData.length,
      (index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FadeInRight(
          duration: Duration(milliseconds: 500 + (index * 120)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 6, right: 8),
                  child:
                      Icon(Icons.check_circle, size: 14, color: Colors.grey)),
              Expanded(
                  child: Text(termsData[index].toString(),
                      style: AppStyle.normal_14(AppColors.black20))),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:market_place_customer/screens/dilogs/already_purchesed_dialog.dart';
import 'package:market_place_customer/screens/payment_section/payment_services.dart';
import 'package:market_place_customer/screens/payment_section/payment_verifications.dart';
import 'package:market_place_customer/screens/simmer_effects/offers_details_simmer.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/expire_offers_timers.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/vendor_details_helper.dart';
import 'package:market_place_customer/utils/exports.dart';

class ViewOffersDetails extends StatefulWidget {
  final String offersId;

  const ViewOffersDetails({super.key, required this.offersId});

  @override
  State<ViewOffersDetails> createState() => _ViewOffersDetailsState();
}

class _ViewOffersDetailsState extends State<ViewOffersDetails> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;
  double _flexTitleOpacity = 1.0;
  RazorpayPaymentServices razorpay = RazorpayPaymentServices();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double maxOffset = size.height * 0.3;
      double opacity = (offset / maxOffset).clamp(0.0, 1.0);
      setState(() {
        _appBarOpacity = opacity;
        _flexTitleOpacity = 1.0 - opacity;
      });
    });

    onRefreshData();
    listenSpecificOfferVerification(context: context, offerId: widget.offersId);
  }

  Future onRefreshData() async {
    context.read<ViewOffersBloc>().add(
        ViewOffersDetailsEvent(context: context, offersId: widget.offersId));
  }

  RazorpayPaymentServices razorpayServices = RazorpayPaymentServices();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentBloc, PaymentState>(
          listener: (context, state) {
            EasyLoading.dismiss();
            if (state is PaymentLoading) {
              EasyLoading.show(status: "Processing...");
            } else if (state is PaymentSuccess) {
              final data = state.paymentEvent;
              final paymentData = state.paymentModel.data;
              if (paymentData != null) {
                BuyOfferPaymentModel buyOffersModal = BuyOfferPaymentModel(
                    amount: data.amount,
                    context: context,
                    customerName: data.customerName,
                    offersId: data.offerId ?? '',
                    vendorId: data.vendorId ?? '',
                    userId: data.userId,
                    orderId: paymentData.id.toString());
                razorpay.verifyPaymentAndBuyOffers(dataModel: buyOffersModal);
              }
            } else if (state is PaymentFailure) {
              var data = state.paymentEvent;
              razorpayServices.updatePaymentDataOnFirebase(
                  data.offerId, data.vendorId, data.userId, 'failed');
              snackBar(context, state.error, AppColors.redColor);
            }
          },
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.background,
        body: BlocBuilder<ViewOffersBloc, ViewOffersState>(
          builder: (context, state) {
            if (state is ViewOffersLoading) {
              return const ViewOffersDetailsShimmer();
            } else if (state is ViewOffersFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    state.error,
                    textAlign: TextAlign.center,
                    style: AppStyle.medium_14(AppColors.redColor),
                  ),
                ),
              );
            } else if (state is ViewOffersSuccess) {
              final offersData = state.offersDetailModel.data;
              final singleOffer = offersData?.record;
              if (singleOffer == null) return const SizedBox();

              final isFlat = singleOffer.flat != null;

              final imageUrl = singleOffer.flat != null
                  ? singleOffer.flat!.offerImage.toString()
                  : singleOffer.percentage!.offerImage.toString();

              DateTime? expiredTime = isFlat
                  ? singleOffer.flat?.expiryDate! ?? DateTime.now()
                  : singleOffer.percentage!.expiryDate! ?? DateTime.now();

              final termsData = [
                "Only one coupon can be applied per transaction.",
                singleOffer.flat != null
                    ? "Flat ₹${singleOffer.flat!.discountPercentage} discount on eligible purchases."
                    : "${singleOffer.percentage!.discountPercentage}% discount on eligible purchases.",
                "Minimum bill ₹${singleOffer.flat?.minBillAmount ?? singleOffer.percentage!.minBillAmount}.",
                "Max discount ₹${singleOffer.flat?.maxDiscountCap ?? singleOffer.percentage!.maxDiscountCap}.",
                "Valid till expiry date or while supplies last.",
                "Not exchangeable or redeemable for cash.",
              ];

              return RefreshIndicator(
                onRefresh: onRefreshData,
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      expandedHeight: size.height * 0.28,
                      pinned: true,
                      stretch: true,
                      backgroundColor: AppColors.themeColor,
                      elevation: 0,
                      title: Opacity(
                        opacity: _appBarOpacity,
                        child: Text(
                          singleOffer.flat?.title ??
                              singleOffer.percentage?.title ??
                              '',
                          style: AppStyle.medium_18(AppColors.whiteColor),
                        ),
                      ),
                      leading: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white),
                          onPressed: () => Navigator.pop(context)),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Hero(
                              tag: imageUrl,
                              child: Image.network(imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Image.asset(
                                      Assets.dummy,
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.4),
                                    Colors.black.withOpacity(0.1),
                                    Colors.white.withOpacity(0.1),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Offer Title
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.034),
                        child: FadeInDown(
                          duration: const Duration(milliseconds: 600),
                          child: Text(
                            singleOffer.flat?.title ??
                                singleOffer.percentage?.title ??
                                '',
                            style: AppStyle.medium_20(AppColors.themeColor),
                          ),
                        ),
                      ),
                    ),

                    /// Offer Card
                    SliverToBoxAdapter(
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.034,
                              vertical: size.height * 0.01),
                          padding: EdgeInsets.all(size.width * 0.04),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.white.withOpacity(0.9),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.themeColor.withOpacity(0.1),
                                blurRadius: 12,
                                spreadRadius: 1,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Offer Details",
                                  style: AppStyle.semiBold_16(
                                      AppColors.blackColor)),
                              const SizedBox(height: 8),
                              Text(
                                singleOffer.flat != null
                                    ? "Flat ₹${singleOffer.flat!.discountPercentage} off on orders above ₹${singleOffer.flat!.minBillAmount}"
                                    : "${singleOffer.percentage!.discountPercentage}% off on orders above ₹${singleOffer.percentage!.minBillAmount}",
                                style: AppStyle.normal_14(AppColors.black70),
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  trackerData(
                                      title: "Min. Bill",
                                      subTitle:
                                          "₹${singleOffer.flat?.minBillAmount ?? singleOffer.percentage!.minBillAmount}",
                                      txtColor: AppColors.themeColor),
                                  trackerData(
                                      title: "Max. Discount",
                                      subTitle:
                                          "₹${singleOffer.flat?.maxDiscountCap ?? singleOffer.percentage!.maxDiscountCap}",
                                      txtColor: AppColors.themeColor),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Expires",
                                          style: AppStyle.normal_13(
                                              AppColors.black50),
                                          textAlign: TextAlign.center),
                                      const SizedBox(height: 4),
                                      OfferExpiryTimer(
                                          expiryDate: expiredTime!),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// Buy Button
                    SliverToBoxAdapter(
                      child: CustomButtons.primary(
                        onPressed: () async {
                          var userId = LocalStorage.getString(Pref.userId);
                          var customerName =
                              LocalStorage.getString(Pref.userName);
                          double amount = double.parse(
                              singleOffer.flat?.amount?.toString() ??
                                  singleOffer.percentage!.amount.toString());

                          String vendorId =
                              offersData!.record!.vendor!.id.toString();
                          String offerId = singleOffer.id.toString();

                          // bool isPurchased = offersData.purchaseStatus ?? false;
                          bool isExpired = singleOffer.flat != null
                              ? (singleOffer.flat!.isExpired ?? false)
                              : (singleOffer.percentage?.isExpired ?? false);

                          bool isLoggedIn = await checkedLogin(context);
                          if (!isLoggedIn) return;
                          if (isExpired) {
                            showOfferExpiredDialog(context);
                            return;
                          }
                          // if (isPurchased) {
                          //   showAlreadyPurchasedDialog(context);
                          //   return;
                          // }

                          context.read<PaymentBloc>().add(
                                SubmitPaymentEvent(
                                  customerName.toString(),
                                  context,
                                  amount,
                                  vendorId,
                                  offerId,
                                  userId.toString(),
                                ),
                              );
                        },
                        text: "Buy Now",
                      ),
                    ),

                    /// Terms Section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                            vertical: size.height * 0.01),
                        child: FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          child: customExpansionTile(
                            context: context,
                            txt: "Terms & Conditions",
                            subTitle: "Tap to view terms and policy",
                            children: List.generate(
                              termsData.length,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.circle,
                                        size: 6, color: Colors.grey),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        termsData[index],
                                        style: AppStyle.normal_13(
                                            AppColors.black70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: SizedBox(height: size.height * 0.15)),
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

Widget trackerData({String? title, String? subTitle, required Color txtColor}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(title ?? "",
          style: AppStyle.normal_13(AppColors.black50),
          textAlign: TextAlign.center),
      const SizedBox(height: 4),
      Text(subTitle ?? "",
          style: AppStyle.semiBold_14(txtColor), textAlign: TextAlign.center),
    ],
  );
}

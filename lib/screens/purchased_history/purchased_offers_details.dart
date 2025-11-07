import 'package:animate_do/animate_do.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/purchased_offers_details/purchased_offers_bloc.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/purchased_offers_details/purchased_offers_event.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/purchased_offers_details/purchased_offers_state.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/update_bill_amount/update_bill_amount_bloc.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/update_bill_amount/update_bill_amount_state.dart';
import 'package:market_place_customer/screens/payment_section/payment_verifications.dart';
import 'package:market_place_customer/screens/purchased_history/expired_timer.dart';
import 'package:market_place_customer/screens/qr_management/generate_qr_code.dart';
import 'package:market_place_customer/screens/vendors_details_and_offers/vendor_details_helper.dart';
import 'package:market_place_customer/utils/exports.dart';

class PurchasedOfferDetailsPage extends StatefulWidget {
  final String offersId;

  const PurchasedOfferDetailsPage({super.key, required this.offersId});

  @override
  State<PurchasedOfferDetailsPage> createState() =>
      _PurchasedOfferDetailsPageState();
}

class _PurchasedOfferDetailsPageState extends State<PurchasedOfferDetailsPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController maxAmtController = TextEditingController();

  double _appBarOpacity = 0.0;
  double _flexTitleOpacity = 1.0;

  bool _showFloatingSummary = false;
  double _calculatedDiscount = 0.0;
  double _payableAmount = 0.0;
  bool _isValidAmount = false;

  // For subtle CTA animation
  late AnimationController _ctaController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _ctaController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double maxOffset = size.height * 0.28;

      double opacity = (offset / maxOffset).clamp(0.0, 1.0);
      setState(() {
        _appBarOpacity = opacity;
        _flexTitleOpacity = 1.0 - opacity;
      });

      // Show floating summary when scrolled beyond hero
      if (offset > size.height * 0.22 &&
          !_showFloatingSummary &&
          _isValidAmount) {
        setState(() => _showFloatingSummary = true);
      } else if (offset <= size.height * 0.22 && _showFloatingSummary) {
        setState(() => _showFloatingSummary = false);
      }
    });

    // init data refresh & verifications (kept from your original)
    onRefreshData();
    listenSpecificOfferVerification(context: context, offerId: widget.offersId);

    maxAmtController.addListener(_onAmountChange);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    maxAmtController.removeListener(_onAmountChange);
    maxAmtController.dispose();
    _ctaController.dispose();
    super.dispose();
  }

  Future onRefreshData() async {
    context.read<PurchasedOffersBloc>().add(PurchasedOffersDetailsEvent(
        context: context, offersId: widget.offersId));
  }

  void _onAmountChange() {
    final text = maxAmtController.text.trim();
    final val = double.tryParse(text.isEmpty ? '0' : text);
    if (val == null) {
      setState(() {
        _isValidAmount = false;
        _calculatedDiscount = 0.0;
        _payableAmount = 0.0;
      });
      return;
    }

    // Get the currently loaded offer to compute discount dynamically.
    final state = context.read<PurchasedOffersBloc>().state;
    if (state is! PurchasedOffersSuccess) {
      // no offer yet; just set simple values
      setState(() {
        _isValidAmount = val > 0;
        _calculatedDiscount = 0.0;
        _payableAmount = val;
      });
      return;
    }

    final singleOffer = state.offersDetailModel.data!.offer!;
    double discount = 0.0;
    double payable = val;

    if (singleOffer.flat != null) {
      // flat offer: discount is min(maxDiscountCap, val - minBillAmount) if applicable
      final cap =
          double.tryParse(singleOffer.flat!.maxDiscountCap.toString()) ?? 0;
      final minBill =
          double.tryParse(singleOffer.flat!.minBillAmount.toString()) ?? 0;
      if (val >= minBill) {
        // discount equals cap but never exceed bill
        discount = cap > val ? val : cap;
      } else {
        discount = 0;
      }
    } else if (singleOffer.percentage != null) {
      final pct = double.tryParse(
              singleOffer.percentage!.discountPercentage.toString()) ??
          0;
      final minBill =
          double.tryParse(singleOffer.percentage!.minBillAmount.toString()) ??
              0;
      if (val >= minBill) {
        discount = (val * pct / 100);
        final cap = double.tryParse(
                singleOffer.percentage!.maxDiscountCap.toString()) ??
            double.infinity;
        if (discount > cap) discount = cap;
      } else {
        discount = 0;
      }
    }

    payable = (val - discount).clamp(0.0, double.infinity);

    setState(() {
      _isValidAmount = val > 0;
      _calculatedDiscount = double.parse(discount.toStringAsFixed(2));
      _payableAmount = double.parse(payable.toStringAsFixed(2));
      // update floating summary visibility only when valid
      if (_payableAmount > 0 && _scrollController.offset > size.height * 0.22) {
        _showFloatingSummary = true;
      } else if (_scrollController.offset <= size.height * 0.22) {
        _showFloatingSummary = false;
      }
    });
  }

  // When pressing CTA we play a micro animation
  Future<void> _onBuyNowPressed() async {
    FocusScope.of(context).unfocus();

    _ctaController.forward().then((_) => _ctaController.reverse());

    if (!_formKey.currentState!.validate()) return;

    final state = context.read<PurchasedOffersBloc>().state;
    if (state is! PurchasedOffersSuccess) return;

    final offersData = state.offersDetailModel.data!;
    final singleOffer = offersData.offer!;
    final isFlat = singleOffer.flat != null;

    final offerName = isFlat
        ? singleOffer.flat!.title ?? ''
        : singleOffer.percentage!.title ?? '';

    final flatData = isFlat
        ? "Flat ₹${singleOffer.flat!.discountPercentage ?? 0} OFF"
        : "Flat ${singleOffer.percentage!.discountPercentage ?? 0}% OFF";

    final vendorId = offersData.offer!.vendor.toString() ?? '';
    final offerId = offersData.id ?? '';

    final customerId = LocalStorage.getString(Pref.userId);

    final qrCodeContentModel = QrCodeContentModel(
        title: offerName,
        totalAmount: maxAmtController.text,
        vendorId: vendorId,
        flatData: flatData,
        offerId: offerId,
        customerId: customerId ?? '',
        finalAmount: _payableAmount.toString());

    // // Dispatch event
    // context.read<UpdateBillAmountBloc>().add(
    //       SubmitBillAmountEvent(
    //         context: context,
    //         offerId: offerId,
    //         amount: _payableAmount.toString(),
    //       ),
    //     );

    // ✅ Wait for BLoC update using a listener or small delay
    await Future.delayed(const Duration(milliseconds: 300));
    AppRouter().navigateTo(
      context,
      OfferQRCodeCard(qrContent: qrCodeContentModel),
    );
    // final paymentState = context.read<UpdateBillAmountBloc>().state;
    // if (paymentState is UpdateBillAmountSuccess &&
    //     paymentState.billAmountModel.status == true) {
    //   AppRouter().navigateTo(
    //     context,
    //     OfferQRCodeCard(qrContent: qrCodeContentModel),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateBillAmountBloc, UpdateBillAmountState>(
            listener: (context, state) {
          if (state is UpdateBillAmountLoading) {
          } else if (state is UpdateBillAmountSuccess) {
            final payment = state.billAmountModel.data;

            if (maxAmtController.text.isNotEmpty) {
              // Dono values numeric type me lo
              final totalAmount = payment?.totalAmount?.toDouble() ?? 0.0;
              final discount = _calculatedDiscount.toDouble();

              // Dono ko add karo
              double value = discount + totalAmount;

              // Check karo agar decimal .0 hai to integer me likho
              if (value == value.toInt()) {
                maxAmtController.text = value.toInt().toString();
              } else {
                maxAmtController.text = value.toString();
              }
            }
          } else if (state is UpdateBillAmountFailure) {
            var msg = state.error;
            snackBar(context, msg, AppColors.redColor);
          }
        })
      ],
      child: Scaffold(
        body: BlocBuilder<PurchasedOffersBloc, PurchasedOffersState>(
          builder: (context, state) {
            if (state is PurchasedOffersLoading) {
              return const BurgerKingShimmer();
            } else if (state is PurchasedOffersFailure) {
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
            } else if (state is PurchasedOffersSuccess) {
              final offersData = state.offersDetailModel.data;

              final singleOffer = offersData!.offer;

              final imageUrl = singleOffer == null
                  ? null
                  : singleOffer.flat?.offerImage?.toString() ??
                      singleOffer.percentage?.offerImage?.toString();

              if (singleOffer == null) {
                return const Center(child: Text("Offers Not Found"));
              }

              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: onRefreshData,
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
                                singleOffer!.flat != null
                                    ? singleOffer.flat!.title.toString()
                                    : singleOffer.percentage!.title.toString(),
                                style: AppStyle.normal_18(AppColors.whiteColor),
                              ),
                            ),
                            flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.parallax,
                              background: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Hero(
                                    tag: 'offerHero-${widget.offersId}',
                                    child: FadeInImage(
                                      placeholder:
                                          const AssetImage(Assets.dummy),
                                      imageErrorBuilder: (_, child, st) =>
                                          Image.asset(Assets.dummy,
                                              fit: BoxFit.cover),
                                      image: imageUrl!.isNotEmpty
                                          ? NetworkImage(imageUrl)
                                          : const AssetImage(Assets.dummy)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
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
                                                BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      singleOffer.flat != null
                                                          ? singleOffer
                                                              .flat!.title
                                                              .toString()
                                                          : singleOffer
                                                              .percentage!.title
                                                              .toString(),
                                                      style: AppStyle.medium_16(
                                                          AppColors.blackColor),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      singleOffer.flat != null
                                                          ? "Flat ₹${singleOffer.flat!.discountPercentage} off"
                                                          : "${singleOffer.percentage!.discountPercentage}% off",
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
                                                        : singleOffer
                                                            .percentage!
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
                                    singleOffer.flat != null
                                        ? "${singleOffer.flat!.title} • Flat ₹${singleOffer.flat!.maxDiscountCap} Off"
                                        : "${singleOffer.percentage!.title} • ${singleOffer.percentage!.discountPercentage}% Off",
                                    style: AppStyle.medium_20(
                                        AppColors.themeColor),
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
                                          color: AppColors.theme10
                                              .withOpacity(0.4)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Bill Amount",
                                            style: AppStyle.medium_16(
                                                AppColors.blackColor)),
                                        SizedBox(height: size.height * 0.01),
                                        customTextField(
                                          prefix: const Icon(
                                              Icons.currency_rupee,
                                              size: 18),
                                          keyboardType: TextInputType.number,
                                          maxLength: 10,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          hintText: 'Enter bill amount',
                                          controller: maxAmtController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter total bill amount';
                                            }
                                            final enteredAmount =
                                                double.tryParse(value);
                                            if (enteredAmount == null) {
                                              return 'Please enter a valid amount';
                                            }
                                            final minBillAmount =
                                                singleOffer.flat != null
                                                    ? singleOffer
                                                        .flat!.minBillAmount
                                                    : singleOffer.percentage!
                                                        .minBillAmount;

                                            if (enteredAmount <
                                                (minBillAmount ?? 0)) {
                                              return 'Bill amount must be at least ₹$minBillAmount';
                                            }
                                            return null;
                                          },
                                          onChanged: (v) => _onAmountChange(),
                                        ),

                                        const SizedBox(height: 12),

                                        // Live calculation summary (animated)
                                        AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          child: _isValidAmount
                                              ? Container(
                                                  key: ValueKey(
                                                      'summary_${_payableAmount}_$_calculatedDiscount'),
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.themeColor
                                                        .withOpacity(0.06),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .themeColor
                                                            .withOpacity(0.12)),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      _summaryRow("Bill Amount",
                                                          "₹${maxAmtController.text}"),
                                                      const SizedBox(height: 6),
                                                      _summaryRow("Discount",
                                                          "- ₹${_calculatedDiscount.toStringAsFixed(2)}"),
                                                      const Divider(),
                                                      _summaryRow("You Pay",
                                                          "₹${_payableAmount.toStringAsFixed(2)}",
                                                          highlight: true),
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ),

                                        const SizedBox(height: 14),

                                        // Inline CTA + small saving note
                                        FadeInUp(
                                          duration:
                                              const Duration(milliseconds: 800),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: _isValidAmount
                                                      ? _onBuyNowPressed
                                                      : null,
                                                  child: ScaleTransition(
                                                    scale: Tween(
                                                            begin: 1.0,
                                                            end: 0.97)
                                                        .animate(
                                                      CurvedAnimation(
                                                          parent:
                                                              _ctaController,
                                                          curve:
                                                              Curves.easeOut),
                                                    ),
                                                    child: Container(
                                                      height:
                                                          size.height * 0.055,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: _isValidAmount
                                                              ? [
                                                                  AppColors
                                                                      .themeColor,
                                                                  AppColors
                                                                      .themeColor
                                                                      .withOpacity(
                                                                          0.9)
                                                                ]
                                                              : [
                                                                  Colors.grey
                                                                      .shade300,
                                                                  Colors.grey
                                                                      .shade300
                                                                ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow:
                                                            _isValidAmount
                                                                ? [
                                                                    BoxShadow(
                                                                      color: AppColors
                                                                          .themeColor
                                                                          .withOpacity(
                                                                              0.18),
                                                                      blurRadius:
                                                                          12,
                                                                      offset:
                                                                          const Offset(
                                                                              0,
                                                                              6),
                                                                    )
                                                                  ]
                                                                : null,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Redeem Now",
                                                        style:
                                                            AppStyle.medium_16(
                                                          _isValidAmount
                                                              ? AppColors
                                                                  .whiteColor
                                                              : AppColors
                                                                  .black50,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              AnimatedOpacity(
                                                opacity:
                                                    _isValidAmount ? 1.0 : 0.35,
                                                duration: const Duration(
                                                    milliseconds: 250),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.green
                                                          .withOpacity(0.08),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                    children: [
                                                      Text("Save",
                                                          style: AppStyle
                                                              .normal_12(
                                                                  AppColors
                                                                      .green)),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                          "₹${_calculatedDiscount.toStringAsFixed(0)}",
                                                          style: AppStyle
                                                              .medium_14(
                                                                  AppColors
                                                                      .green)),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
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
                                          duration: const Duration(
                                              milliseconds: 1000),
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

                          const SliverToBoxAdapter(
                              child: SizedBox(height: 120)),
                        ],
                      ),
                    ),
                  ),

                  // Floating "You Pay" summary: appears when scrolled or on small screens
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 18,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity:
                          _showFloatingSummary && _isValidAmount ? 0.8 : 0.0,
                      child: IgnorePointer(
                        ignoring: !_showFloatingSummary,
                        child: Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("You pay",
                                          style: AppStyle.normal_12(
                                              AppColors.black50)),
                                      Text(
                                          "₹${_payableAmount.toStringAsFixed(2)}",
                                          style: AppStyle.medium_18(
                                              AppColors.themeColor)),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.themeColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onPressed: _onBuyNowPressed,
                                  child: Text("Redeem Now",
                                      style: AppStyle.medium_14(
                                          AppColors.whiteColor)),
                                ),
                              ],
                            ),
                          ),
                        ),
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

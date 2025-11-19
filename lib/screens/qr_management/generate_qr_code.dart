import 'package:market_place_customer/bloc/vendors_data_bloc/purchased_offers_details/purchased_offers_event.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/update_bill_amount/update_bill_amount_event.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/update_bill_amount/update_bill_amount_state.dart';
import 'package:market_place_customer/screens/payment_section/qr_payment_management.dart';
import 'package:market_place_customer/screens/qr_management/update_bil_amount.dart';
import 'package:market_place_customer/utils/exports.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeContentModel {
  final String title;
  final String flatData;
  final String finalAmount;
  final String offerId;
  final String vendorId;
  final String totalAmount;
  final String customerId;

  const QrCodeContentModel({
    required this.title,
    required this.flatData,
    required this.totalAmount,
    required this.offerId,
    required this.vendorId,
    required this.finalAmount,
    required this.customerId,
  });
}

class OfferQRCodeCard extends StatefulWidget {
  final QrCodeContentModel qrContent;

  const OfferQRCodeCard({super.key, required this.qrContent});

  @override
  State<OfferQRCodeCard> createState() => _OfferQRCodeCardState();
}

class _OfferQRCodeCardState extends State<OfferQRCodeCard> {
  final TextEditingController amountController = TextEditingController();

  Future onRefreshData() async {
    context.read<PurchasedOffersBloc>().add(PurchasedOffersDetailsEvent(
        context: context, offersId: widget.qrContent.offerId));
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ///  Firebase me verifying status create/update
      verifyPaymentForUsedOffers(offers: widget.qrContent, context: context);

      ///  Real-time listener activate
      listenSpecificOfferVerificationForUsedOffers(
          context: context, offerId: widget.qrContent.offerId);

      ///  Fetch UI updates
      onRefreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> customerInfo = {
      'offer_id': widget.qrContent.offerId.toString()
    };
    String jsonDetails = jsonEncode(customerInfo);

    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateBillAmountBloc, UpdateBillAmountState>(
          listener: (context, state) {
            EasyLoading.dismiss();
            if (state is UpdateBillAmountLoading) {
              EasyLoading.show();
            } else if (state is UpdateBillAmountSuccess) {
              onRefreshData();
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppbar(title: "Redeem offers", context: context),
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
              final offersData = state.offersDetailModel.data!;
              final singleOffer = offersData.offer!;
              final flat = singleOffer.flat != null;
              final minimumBillAmt = flat
                  ? singleOffer.flat!.minBillAmount ?? 0
                  : singleOffer.percentage!.minBillAmount ?? 0;

              final finalBill =
                  double.parse(offersData.finalAmount.toString() ?? '') ?? 0.0;

              final totalAmount =
                  double.parse(offersData.totalAmount.toString() ?? '') ?? 0.0;
              amountController.text = totalAmount.toString();

              return RefreshIndicator(
                onRefresh: onRefreshData,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.1),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: FadeInDownBig(
                          delay: const Duration(milliseconds: 100),
                          duration: const Duration(milliseconds: 600),
                          child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE9F0FF),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(height: 40),
                                  FadeInDown(
                                      delay: const Duration(milliseconds: 200),
                                      duration:
                                          const Duration(milliseconds: 800),
                                      child: Text(
                                          capitalizeFirstLetter(
                                              widget.qrContent.title),
                                          textAlign: TextAlign.center,
                                          style: AppStyle.bold_22(
                                              AppColors.themeColor))),
                                  const SizedBox(height: 6),
                                  FadeInRight(
                                    delay: const Duration(milliseconds: 400),
                                    duration: const Duration(milliseconds: 800),
                                    child: Text(
                                      widget.qrContent.flatData,
                                      style: AppStyle.medium_20(
                                              AppColors.blackColor)
                                          .copyWith(letterSpacing: 2),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 600),
                                    duration: const Duration(milliseconds: 900),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 1),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.08),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: QrImageView(
                                        data: jsonDetails,
                                        version: QrVersions.auto,
                                        size: size.width * 0.55,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 800),
                                    duration: const Duration(milliseconds: 700),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      decoration: BoxDecoration(
                                        color: AppColors.indigo,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(16)),
                                      ),
                                      child: Text(
                                        "Total Amount: ₹${finalBill.toStringAsFixed(2).toString()}",
                                        textAlign: TextAlign.center,
                                        style: AppStyle.medium_16(
                                            AppColors.white10),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FadeInLeft(
                            delay: const Duration(milliseconds: 1000),
                            duration: const Duration(milliseconds: 600),
                            child: CustomButtons.rounded(
                              width: size.width * 0.42,
                              height: size.height * 0.048,
                              onPressed: () => Navigator.pop(context),
                              text: "Back",
                              bgColor: AppColors.greyColor,
                            ),
                          ),
                          FadeInRight(
                            delay: const Duration(milliseconds: 1100),
                            duration: const Duration(milliseconds: 600),
                            child: CustomButtons.rounded(
                              width: size.width * 0.42,
                              height: size.height * 0.048,
                              onPressed: () => updateBillAmount(
                                context: context,
                                amountController: amountController,
                                minBillAmount: minimumBillAmt,
                                onPressed: () {
                                  context.read<UpdateBillAmountBloc>().add(
                                        SubmitBillAmountEvent(
                                            context: context,
                                            offerId: widget.qrContent.offerId,
                                            pageSource: PageSource.fromQrPage,
                                            amount: double.parse(
                                                amountController.text)),
                                      );
                                },
                              ),
                              text: "Update Bill Amount",
                              bgColor: AppColors.themeColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
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

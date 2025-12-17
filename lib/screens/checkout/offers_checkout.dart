import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_place_customer/bloc/payment_bloc/payment_event.dart';
import 'package:market_place_customer/data/storage/sharedpreferenc.dart';
import 'package:market_place_customer/utils/app_colors.dart';
import 'package:market_place_customer/utils/app_styles.dart';
import 'package:market_place_customer/utils/custom_appbar.dart';
import 'package:market_place_customer/utils/custom_buttons.dart';

import '../../bloc/payment_bloc/payment_bloc.dart';
import '../../data/models/offers_detail_model.dart';
import '../dilogs/already_purchesed_dialog.dart';
import '../purchased_history/expired_timer.dart';

class CheckoutPage extends StatelessWidget {
  final Data? offersData;

  const CheckoutPage({super.key, required this.offersData});

  @override
  Widget build(BuildContext context) {
    final singleOffer = offersData?.record;
    if (singleOffer == null) return const SizedBox();
    final isFlat = singleOffer.flat != null;

    DateTime? expiredTime = isFlat
        ? singleOffer.flat?.expiryDate! ?? DateTime.now()
        : singleOffer.percentage!.expiryDate! ?? DateTime.now();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: customAppbar(title: "Checkout", context: context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Offer Details Card
            _card(
              child: Row(
                children: [
                  Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.local_offer,
                          color: Colors.blue, size: 30)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          singleOffer.flat != null
                              ? singleOffer.flat!.title.toString()
                              : singleOffer.percentage!.title.toString(),
                          style: AppStyle.medium_16(AppColors.blackColor),
                        ),
                        const SizedBox(height: 4),
                        OfferExpiryTimer(expiryDate: expiredTime!),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Price Breakdown
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Price Details",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _row("Offer Price",
                      "₹${isFlat ? singleOffer.flat!.amount : singleOffer.percentage!.amount}"),
                  _row("GST (0%)", "₹0"),
                  const Divider(height: 24),
                  _row(
                    "Total Amount",
                    "₹${isFlat ? singleOffer.flat!.amount?.toStringAsFixed(2) : singleOffer.percentage!.amount?.toStringAsFixed(2)}",
                    isBold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Pay Now Button
            CustomButtons.primary(
              onPressed: () async {
                var userId = LocalStorage.getString(Pref.userId);
                var customerName = LocalStorage.getString(Pref.userName);
                double amount = double.parse(
                    singleOffer.flat?.amount?.toString() ??
                        singleOffer.percentage!.amount.toString());

                String vendorId = offersData!.record!.vendor!.id.toString();
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
          ],
        ),
      ),
    );
  }

  /// Card Wrapper
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: child,
    );
  }

  /// Row for price values
  Widget _row(String title, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.w400)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: color ?? Colors.black,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

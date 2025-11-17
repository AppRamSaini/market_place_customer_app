import 'dart:ui';

import 'package:market_place_customer/bloc/order_history_bloc/save_bill_bloc/upload_gallery_bloc.dart';
import 'package:market_place_customer/bloc/order_history_bloc/save_bill_bloc/upload_gallery_event.dart';
import 'package:market_place_customer/data/models/order_history_%20model.dart';
import 'package:market_place_customer/utils/exports.dart';

class OrderHistoryCard extends StatefulWidget {
  final RedeemedOffer orderData;
  final int index;

  const OrderHistoryCard(
      {super.key, required this.orderData, required this.index});

  @override
  State<OrderHistoryCard> createState() => _OrderHistoryCardState();
}

class _OrderHistoryCardState extends State<OrderHistoryCard> {
  bool expanded = false;

  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    final order = widget.orderData;
    final vendor = order.vendor!;
    final offers = order.offer;

    final bool hasFlat = offers != null && offers.flat != null;

    final dateTime = order.usedTime ?? order.createdAt.toString();

    final payment = order.paymentId!;
    final savedBill = order.bill != null;
    return FadeInUp(
      duration: Duration(milliseconds: 300 + (widget.index * 100)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          vendor.businessLogo ?? '',
                          width: 54,
                          height: 54,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 54,
                            height: 54,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.person,
                                color: Colors.grey, size: 26),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Vendor Name and Offer
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vendor.name ?? "Unknown Vendor",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.5,
                                color: Color(0xFF111827),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              hasFlat
                                  ? order.offer!.flat!.title ?? ''
                                  : order.offer!.percentage!.title ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Order Date & Time
                      SizedBox(
                        width: size.width * 0.28,
                        child: Text(formatToLocalDateTime(dateTime),
                            textAlign: TextAlign.right,
                            style: AppStyle.normal_13(AppColors.black50)),
                      ),
                    ],
                  ),
                ),

                Divider(color: AppColors.greyColor.withOpacity(0.1), height: 1),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              if (!savedBill) {
                                _pickedImage = await pickImageSheet(context);
                                if (_pickedImage == null) return;
                                context.read<SaveBillBloc>().add(AddBillEvent(
                                    File(_pickedImage!.path),
                                    order.id.toString(),
                                    context));
                              } else {
                                snackBar(
                                    context,
                                    "You have already saved this bill.",
                                    AppColors.red600);
                              }
                            },
                            icon: !savedBill
                                ? const Icon(Icons.save_alt, size: 18)
                                : null,
                            label: Text(savedBill ? "Saved" : "Save Bill"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffEEF4FF),
                              foregroundColor: AppColors.indigo,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(width: 10),
                          savedBill
                              ? GestureDetector(
                                  onTap: () => AppRouter().navigateTo(
                                      context,
                                      FullImageView(
                                          imageList: [order.bill.toString()])),
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.themeColor
                                              .withOpacity(0.4)),
                                      child: const Icon(
                                          Icons.photo_library_outlined,
                                          color: AppColors.whiteColor,
                                          size: 22)))
                              : const SizedBox()
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          AppRouter()
                              .navigateTo(context, const HelpSupportPage());
                        },
                        child: Row(
                          children: [
                            Text("Need help?",
                                style: AppStyle.normal_13(AppColors.greyColor)),
                            const SizedBox(width: 6),
                            const Icon(Icons.help_outline,
                                color: AppColors.greyColor, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 🔹 EXPANDABLE SECTION
                customAnimatedExpansionTile(
                  context: context,
                  expanded: expanded,
                  onTap: () => setState(() => expanded = !expanded),
                  title:
                      "Paid ₹${order.finalAmount?.toStringAsFixed(0)} | Order ID: ${order.id!.substring(0, 8).toUpperCase()}",
                  children: [
                    _infoRow("Vendor Email", vendor.email ?? ''),
                    _infoRow(
                        "Offer",
                        hasFlat
                            ? order.offer!.flat!.description ?? ''
                            : order.offer!.percentage!.description ?? ''),
                    _infoRow("Total Amount", "₹${order.totalAmount}"),
                    _infoRow("Discount", "₹${order.discount}"),
                    _infoRow("Final Paid Amount", "₹${order.finalAmount}"),
                    _infoRow("Payment ID", payment.paymentId ?? ''),
                    _infoRow(
                        "Payment Method", payment.paymentMethod.toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child:
                  Text(title, style: AppStyle.normal_15(AppColors.greyColor))),
          const SizedBox(width: 5),
          Expanded(
            flex: 5,
            child: Text(value.isNotEmpty ? value : "-",
                style: AppStyle.normal_15(AppColors.greyColor)),
          ),
        ],
      ),
    );
  }
}

/// 🔹 Custom Animated Expansion Tile
Widget customAnimatedExpansionTile({
  required BuildContext context,
  required bool expanded,
  required VoidCallback onTap,
  required String title,
  List<Widget> children = const <Widget>[],
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: const Color(0xFFF9FAFB),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(title,
                        style: AppStyle.medium_14(AppColors.themeColor))),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 250),
                  turns: expanded ? 0.5 : 0.0,
                  child: const Icon(Icons.expand_more_rounded,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState:
              expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: const SizedBox(),
          secondChild: Column(
            children: [
              const Divider(height: 1, color: Color(0xFFE5E7EB)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(children: children),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

import '../../data/models/offers_detail_model.dart';

/// discount system

double fetchDiscount(PurchasedOffers? record, String enterValue) {
  if (record == null || enterValue.isEmpty) return 0.0;

  final enteredAmount = double.tryParse(enterValue);
  if (enteredAmount == null || enteredAmount <= 0) return 0.0;

  double discountAmount = 0.0;

  // 🟩 Case 1: Flat discount offer
  if (record.flat != null) {
    final flatDiscount =
        double.tryParse(record.flat!.maxDiscountCap.toString()) ?? 0.0;
    discountAmount = flatDiscount;

    // Apply only if minimum bill amount condition satisfied
    final minBillAmount =
        double.tryParse(record.flat!.minBillAmount.toString()) ?? 0.0;
    if (enteredAmount < minBillAmount) {
      discountAmount = 0.0; // Not eligible
    }

    // Ensure discount not greater than entered amount
    if (discountAmount > enteredAmount) {
      discountAmount = enteredAmount;
    }
  }

  // 🟦 Case 2: Percentage discount offer
  else if (record.percentage != null) {
    final discountPercent =
        double.tryParse(record.percentage!.discountPercentage.toString()) ??
            0.0;
    final minBillAmount =
        double.tryParse(record.percentage!.minBillAmount.toString()) ?? 0.0;
    final maxDiscountCap =
        double.tryParse(record.percentage!.maxDiscountCap.toString()) ?? 0.0;

    if (enteredAmount >= minBillAmount) {
      discountAmount = (enteredAmount * discountPercent) / 100;
      // Cap the discount if it exceeds max allowed
      if (discountAmount > maxDiscountCap) {
        discountAmount = maxDiscountCap;
      }
    } else {
      discountAmount = 0.0; // Not eligible
    }
  }

  return discountAmount;
}

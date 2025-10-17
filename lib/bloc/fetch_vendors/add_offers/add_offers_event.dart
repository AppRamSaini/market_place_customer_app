import 'package:flutter/cupertino.dart';

abstract class AddOffersEvent {}

class SubmitOffersEvent extends AddOffersEvent {
  final AddOffersModel merchant;
  final BuildContext context;
  SubmitOffersEvent(this.merchant, this.context);
}


class AddOffersModel {
  final String? title;
  final String? description;
  final String? expiryDate;
  final int? discountPercentage;
  final String? maxDiscountCap;
  final String? minBillAmount;
  final String? amount;
  final String? image;  final String? type;

  AddOffersModel(
    this.title,
    this.description,
    this.expiryDate,
    this.discountPercentage,
    this.maxDiscountCap,
    this.minBillAmount,
    this.amount,
    this.image,  this.type,
  );
}

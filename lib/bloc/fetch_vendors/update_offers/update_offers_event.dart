import 'package:flutter/cupertino.dart';
import 'package:market_place_customer/bloc/fetch_vendors/add_offers/add_offers_event.dart';

abstract class UpdateOffersEvent {}

class SubmitUpdateOffersEvent extends UpdateOffersEvent {
  final AddOffersModel merchant;
  final String offersId;
  final BuildContext context;
  SubmitUpdateOffersEvent(this.merchant, this.context, this.offersId);
}




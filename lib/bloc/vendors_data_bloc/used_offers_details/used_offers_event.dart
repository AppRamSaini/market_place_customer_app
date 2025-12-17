import 'package:flutter/cupertino.dart';

abstract class UsedOffersEvent {}

class UsedOffersDetailsEvent extends UsedOffersEvent {
  final BuildContext context;
  final String? offersId;

  UsedOffersDetailsEvent({required this.context, this.offersId});
}

class ResetOffersEvent extends UsedOffersEvent {}

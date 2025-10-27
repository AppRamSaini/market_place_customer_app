import 'package:flutter/cupertino.dart';

abstract class ViewOffersEvent {}

class ViewOffersDetailsEvent extends ViewOffersEvent {
  final BuildContext context;
  final String? offersId;
  ViewOffersDetailsEvent({required this.context,this.offersId});
}

class ResetOffersEvent extends ViewOffersEvent {}

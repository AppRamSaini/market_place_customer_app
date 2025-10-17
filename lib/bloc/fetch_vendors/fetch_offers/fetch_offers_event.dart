import 'package:flutter/cupertino.dart';

abstract class FetchOffersEvent {}

class GetOffersEvent extends FetchOffersEvent {
  final BuildContext context;
  GetOffersEvent({required this.context});
}

class ResetOffersEvent extends FetchOffersEvent {}

import 'package:flutter/cupertino.dart';

abstract class FetchProfileDetailsEvent {}

class FetchProfileEvent extends FetchProfileDetailsEvent {
  final BuildContext context;
  FetchProfileEvent({required this.context});
}

class ResetOffersEvent extends FetchProfileDetailsEvent {}

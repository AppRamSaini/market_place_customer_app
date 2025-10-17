import 'package:flutter/cupertino.dart';

abstract class FetchDashboardOffersEvent {}

class DashboardOffersEvent extends FetchDashboardOffersEvent {
  final BuildContext context;
  DashboardOffersEvent({required this.context});
}

class ResetOffersEvent extends FetchDashboardOffersEvent {}

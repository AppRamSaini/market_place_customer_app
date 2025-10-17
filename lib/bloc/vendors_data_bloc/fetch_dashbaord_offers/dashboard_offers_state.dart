import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';

abstract class FetchDashboardOffersState {}

class FetchDashboardOffersInitial extends FetchDashboardOffersState {}

class FetchDashboardOffersLoading extends FetchDashboardOffersState {}

class FetchDashboardOffersSuccess extends FetchDashboardOffersState {
  final DashboardOffersModel dashboardOffersModel;
  FetchDashboardOffersSuccess({required this.dashboardOffersModel});
}

class FetchDashboardOffersFailure extends FetchDashboardOffersState {
  final String error;
  FetchDashboardOffersFailure({required this.error});
}

class FetchDashboardOffersInvalidResult extends FetchDashboardOffersState {}

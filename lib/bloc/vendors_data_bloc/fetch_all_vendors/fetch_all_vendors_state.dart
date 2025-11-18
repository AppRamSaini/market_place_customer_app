import 'package:market_place_customer/data/models/fetch_vendors_model.dart';

abstract class FetchVendorsState {}

class FetchVendorsInitial extends FetchVendorsState {}

class FetchVendorsLoading extends FetchVendorsState {}

class FetchVendorsSuccess extends FetchVendorsState {
  final FetchAllVendorsModel model;

  final bool hasReachedMax;
  final bool isPaginating;

  FetchVendorsSuccess({
    required this.model,
    this.hasReachedMax = false,
    this.isPaginating = false,
  });

  FetchVendorsSuccess copyWith({
    FetchAllVendorsModel? vendorsModel,
    bool? hasReachedMax,
    bool? isPaginating,
  }) {
    return FetchVendorsSuccess(
      model: vendorsModel ?? model,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isPaginating: isPaginating ?? this.isPaginating,
    );
  }
}

class FetchVendorsFailure extends FetchVendorsState {
  final String error;

  FetchVendorsFailure({required this.error});
}

class FetchVendorsInvalidResult extends FetchVendorsState {}

import 'package:market_place_customer/data/models/order_history_%20model.dart';

abstract class OrderHistoryState {}

class OrderHistoryInitial extends OrderHistoryState {}

class OrderHistoryLoading extends OrderHistoryState {}

class OrderHistorySuccess extends OrderHistoryState {
  final OrderHistoryModel model;

  final bool hasReachedMax;
  final bool isPaginating;

  OrderHistorySuccess({
    required this.model,
    this.hasReachedMax = false,
    this.isPaginating = false,
  });

  OrderHistorySuccess copyWith({
    OrderHistoryModel? customersModel,
    bool? hasReachedMax,
    bool? isPaginating,
  }) {
    return OrderHistorySuccess(
      model: customersModel ?? this.model,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isPaginating: isPaginating ?? this.isPaginating,
    );
  }
}

class OrderHistoryFailure extends OrderHistoryState {
  final String error;

  OrderHistoryFailure({required this.error});
}

import 'package:flutter/cupertino.dart';

abstract class OrderHistoryEvent {}

class GetOrderHistoryEvent extends OrderHistoryEvent {
  final BuildContext context;
  final int page;
  final bool isLoadMore;

  GetOrderHistoryEvent({
    required this.context,
    this.page = 1,
    this.isLoadMore = false,
  });
}

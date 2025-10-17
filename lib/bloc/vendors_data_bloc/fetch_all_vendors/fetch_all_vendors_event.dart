import 'package:flutter/cupertino.dart';

abstract class FetchVendorsEvent {}

class GetVendorsEvent extends FetchVendorsEvent {
  final BuildContext context;
  final String? type;
  final String? search;
  final String? category;
  GetVendorsEvent(
      {required this.context, this.type, this.search, this.category});
}

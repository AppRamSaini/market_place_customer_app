import 'package:flutter/cupertino.dart';

abstract class VendorDetailsEvent {}

class ViewVendorDetailsEvent extends VendorDetailsEvent {
  final BuildContext context;
  final String? vendorId;
  ViewVendorDetailsEvent({required this.context,this.vendorId});
}


import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class SaveBillEvent {}

class AddBillEvent extends SaveBillEvent {
  final File billImage;
  final String offerId;
  final BuildContext context;

  AddBillEvent(this.billImage, this.offerId, this.context);
}

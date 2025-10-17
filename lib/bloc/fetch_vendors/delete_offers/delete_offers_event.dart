import 'package:flutter/cupertino.dart';

abstract class DeleteOffersEvent {}

class DeleteOffersSubmit extends DeleteOffersEvent {
  final BuildContext context;
  final String? offersId;
  DeleteOffersSubmit({required this.context,this.offersId});
}

class ResetOffersEvent extends DeleteOffersEvent {}

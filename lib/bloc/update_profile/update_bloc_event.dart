import 'package:market_place_customer/utils/exports.dart';

abstract class UpdateProfileEvent {}

class UpdateProfileSubmitted extends UpdateProfileEvent {
  final String? name;
  final String? email;
  final String? picUrl;
  final String? address;
  final String? licenseNo;
  final File?imageFile;
  final BuildContext context;
  UpdateProfileSubmitted(
      {this.email, this.name, this.address, this.licenseNo, this.picUrl,required this.context,this
      .imageFile});
}

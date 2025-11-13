import 'package:market_place_customer/utils/exports.dart';

abstract class UpdateProfileEvent {}

class UpdateProfileSubmitted extends UpdateProfileEvent {
  final String? name;
  final String? email;
  final String? picUrl;
  final String? phone;
  final File imageFile;
  final BuildContext context;

  UpdateProfileSubmitted(
      {this.email,
      this.name,
      this.picUrl,
      this.phone,
      required this.context,
      required this.imageFile});
}

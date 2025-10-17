import 'package:flutter/cupertino.dart';

/// Base Event
abstract class CustomerRegistrationEvent {}

class CustomerSignupEvent extends CustomerRegistrationEvent {
  final CustomerRegistrationModel customer;
  final BuildContext context;

  CustomerSignupEvent(this.customer, this.context);
}

/// Customer Registration Model
class CustomerRegistrationModel {
  String? name;
  String? mobile;
  String? email;
  String? img;

  CustomerRegistrationModel({this.name, this.mobile, this.email, this.img});

  CustomerRegistrationModel copyWith(
      {String? name, String? mobile, String? email}) {
    return CustomerRegistrationModel(
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      img: img ?? this.img,
    );
  }
}

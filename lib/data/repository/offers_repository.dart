import 'package:market_place_customer/bloc/fetch_vendors/add_offers/add_offers_event.dart';
import 'package:market_place_customer/bloc/fetch_vendors/delete_offers/delete_offers_event.dart';
import 'package:market_place_customer/bloc/fetch_vendors/update_offers/update_offers_event.dart';
import 'package:market_place_customer/bloc/fetch_vendors/view_offers_details/view_offers_event.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_all_vendors/fetch_all_vendors_event.dart';
import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/data/models/fetch_vendors_model.dart';
import 'package:market_place_customer/data/models/offers_detail_model.dart';
import 'package:market_place_customer/utils/exports.dart';

class OffersRepository {
  final api = ApiManager();

  /// fetch vendors dashboard data and offers
  Future fetchVendorsOffers(BuildContext context) async {
    final result = await api.get(url: ApiEndPoints.dashboard, context: context);
    print('===>>$result');
    if (result is String) {
      return result;
    } else {
      return DashboardOffersModel.fromJson(result);
    }
  }

  /// fetch vendors list data
  Future fetchVendorsApi(BuildContext context,GetVendorsEvent event) async {
    final result =
        await api.get(url: ApiEndPoints.getVendors(event.category??'',event.type??'',event.search??''), context: context);
    print('===>>$result');
    if (result is String) {
      return result;
    } else {
      return FetchVendorsModel.fromJson(result);
    }
  }

  /// fetch offers list data
  Future fetchOffersDetailsApi(ViewOffersDetailsEvent event) async {
    final result = await api.get(
        url: "${ApiEndPoints.viewOffers}/${event.offersId}",
        context: event.context);
    if (result is String) {
      return result;
    } else {
      return OffersDetailModel.fromJson(result);
    }
  }

  ///  create offers api
  Future createOffersApi(SubmitOffersEvent event) async {
    var data = {
      "title": event.merchant.title,
      "description": event.merchant.description,
      "expiryDate": event.merchant.expiryDate.toString(),
      "discountPercentage": event.merchant.discountPercentage,
      "maxDiscountCap": event.merchant.maxDiscountCap,
      "minBillAmount": event.merchant.minBillAmount,
      "amount": event.merchant.amount,
      // if (event.merchant.image != null) 'image': event.merchant.image!,
      "image": event.merchant.image,
      "type": event.merchant.type
    };
    final result = await api.post(
        url: ApiEndPoints.addOffers, data: data, context: event.context);
    print('---->>>$result');
    if (result is String) {
      return result;
    } else {
      // return SubmitOffersModel.fromJson(result);
    }
  }

  ///  create offers api
  Future updateOffersApi(SubmitUpdateOffersEvent event) async {
    var data = {
      "title": event.merchant.title,
      "description": event.merchant.description,
      "expiryDate": event.merchant.expiryDate.toString(),
      "discountPercentage": event.merchant.discountPercentage,
      "maxDiscountCap": event.merchant.maxDiscountCap,
      "minBillAmount": event.merchant.minBillAmount,
      "amount": event.merchant.amount,
      // if (event.merchant.image != null) 'image': event.merchant.image!,
      "image": event.merchant.image,
      "type": event.merchant.type
    };

    print('JSON-------->>>>>$data');
    final result = await api.post(
        url: "${ApiEndPoints.updateOffers}/${event.offersId}",
        data: data,
        context: event.context);
    print('---------->>>>>$result');
    if (result is String) {
      return result;
    } else {
      // return SubmitOffersModel.fromJson(result);
    }
  }

  ///  delete offers api
  Future deleteOffersApi(DeleteOffersSubmit event) async {
    print("${ApiEndPoints.deleteOffers}/${event.offersId}");
    final result = await api.post(
        url: "${ApiEndPoints.deleteOffers}/${event.offersId}",
        data: {},
        context: event.context);
    print('---------->>>>>$result');
    return result;
  }
}

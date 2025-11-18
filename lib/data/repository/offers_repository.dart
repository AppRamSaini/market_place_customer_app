import 'package:market_place_customer/bloc/vendors_data_bloc/purchased_offers_details/purchased_offers_event.dart';
import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';
import 'package:market_place_customer/data/models/fetch_vendors_model.dart';
import 'package:market_place_customer/data/models/offers_detail_model.dart';
import 'package:market_place_customer/data/models/purchased_offers_details_model.dart';
import 'package:market_place_customer/data/models/vendor_details_model.dart';
import 'package:market_place_customer/utils/exports.dart';

import '../models/purchased_offers_history_model.dart';

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
  Future<FetchAllVendorsModel> fetchVendorsApi(
    BuildContext context,
    GetVendorsEvent event,
  ) async {
    final result = await api.get(
        url: ApiEndPoints.getVendors(event.category ?? '', event.type ?? '',
            event.search ?? '', event.page),
        context: context);
    print('===>>$result');
    if (result is String) {
      return throw Exception(result.toString());
    } else {
      return FetchAllVendorsModel.fromJson(result);
    }
  }

  /// fetch vendors details data
  Future fetchVendorDetailsApi(ViewVendorDetailsEvent event) async {
    var userId = LocalStorage.getString(Pref.userId);
    final result = await api.get(
        url:
            ApiEndPoints.vendorDetails(event.vendorId.toString(), userId ?? ''),
        context: event.context);
    if (result is String) {
      return result;
    } else {
      return VendorsDetailsModel.fromJson(result);
    }
  }

  /// fetch offers details data
  Future fetchOffersDetailsApi(ViewOffersDetailsEvent event) async {
    var userId = LocalStorage.getString(Pref.userId);
    final result = await api.get(
        url:
            ApiEndPoints.offersDetails(event.offersId.toString(), userId ?? ''),
        context: event.context);
    if (result is String) {
      return result;
    } else {
      return OffersDetailModel.fromJson(result);
    }
  }

  /// fetch purchased offers list
  Future fetchPurchasedOffersApi() async {
    final result = await api.get(url: ApiEndPoints.fetchPurchasedOffers);
    if (result is String) {
      return result;
    } else {
      return PurchasedOffersHistoryModel.fromJson(result);
    }
  }

  /// fetch purchased offers details api
  Future fetchPurchasedOffersDetailsApi(
      PurchasedOffersDetailsEvent event) async {
    final result = await api.get(
        url:
            "${ApiEndPoints.purchasedOffersDetails}/${event.offersId.toString()}",
        context: event.context);
    if (result is String) {
      return result;
    } else {
      return PurchasedOffersDetailModel.fromJson(result);
    }
  }
}

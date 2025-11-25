import 'package:market_place_customer/data/models/order_history_%20model.dart';
import 'package:market_place_customer/data/models/saved_bill_model.dart';
import 'package:market_place_customer/utils/exports.dart';

class OrderHistoryRepo {
  final api = ApiManager();

  /// fetch vendors dashboard data and offers
  Future<OrderHistoryModel> fetchOrdersApi(
      BuildContext context, int page) async {
    final result = await api.get(
        url: "${ApiEndPoints.orderHistory}$page", context: context);
    print('===>>$result');
    if (result is String) {
      throw Exception(result);
    } else {
      return OrderHistoryModel.fromJson(result);
    }
  }

  ///  update profile api
  Future saveBill(BuildContext context, String offerId, var data) async {
    final result =
        await api.post(url: "${ApiEndPoints.saveBill}/$offerId", data: data);

    if (result is String) {
      return result;
    } else {
      return SavedBillModel.fromJson(result);
    }
  }
}

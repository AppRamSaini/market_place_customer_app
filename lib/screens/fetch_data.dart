import 'package:jwt_decode/jwt_decode.dart';
import 'package:market_place_customer/bloc/customer_registration/fetch_profile_bloc/fetch_profile_event.dart';
import 'package:market_place_customer/bloc/order_history_bloc/order_history/order_history_event.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_dashbaord_offers/dashboard_offers_event.dart';
import 'package:market_place_customer/utils/exports.dart';

fetchApiData(BuildContext context) {
  var token = LocalStorage.getString(Pref.token);

  if (token != null) {
    final isExpired = Jwt.isExpired(token);

    if (!isExpired) {
      /// fetch customer purchased offer history
      context
          .read<PurchasedOffersHistoryBloc>()
          .add(GetPurchasedOffersHistoryEvent(context: context, page: 1));

      /// fetch customer profile
      context
          .read<FetchProfileDetailsBloc>()
          .add(FetchProfileEvent(context: context));

      /// fetched purchased orders
      context.read<OrderHistoryBloc>().add(
          GetOrderHistoryEvent(context: context, page: 1, isLoadMore: false));

      /// fetch vendors data
      context
          .read<FetchVendorsBloc>()
          .add(GetVendorsEvent(context: context, page: 1, isLoadMore: false));
      context.read<FetchVendorsBloc>().add(GetVendorsEvent(
          context: context, type: 'popular', page: 1, isLoadMore: false));
      context.read<FetchVendorsBloc>().add(GetVendorsEvent(
          context: context, type: 'nearby', page: 1, isLoadMore: false));
    }
  }
}

/// fetch data
fetchApiDataInSplash(BuildContext context) {
  var token = LocalStorage.getString(Pref.token);

  /// Fetch business categories
  context.read<BusinessCategoryCubit>().fetchBusinessCategory();

  /// vendors data in home page
  context
      .read<FetchDashboardOffersBloc>()
      .add(DashboardOffersEvent(context: context));

  if (token != null) {
    final isExpired = Jwt.isExpired(token);

    if (!isExpired) {
      /// fetch customer purchased offer history
      context
          .read<PurchasedOffersHistoryBloc>()
          .add(GetPurchasedOffersHistoryEvent(context: context, page: 1));

      /// fetch customer profile
      context
          .read<FetchProfileDetailsBloc>()
          .add(FetchProfileEvent(context: context));

      /// fetched purchased orders
      context.read<OrderHistoryBloc>().add(
          GetOrderHistoryEvent(context: context, page: 1, isLoadMore: false));

      /// fetch vendors data
      context
          .read<FetchVendorsBloc>()
          .add(GetVendorsEvent(context: context, page: 1, isLoadMore: false));

      context.read<FetchVendorsBloc>().add(GetVendorsEvent(
          context: context, type: 'nearby', page: 1, isLoadMore: false));

      context.read<FetchVendorsBloc>().add(GetVendorsEvent(
          context: context, type: 'popular', page: 1, isLoadMore: false));
    }
  }
}

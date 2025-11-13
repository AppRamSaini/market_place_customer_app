import 'package:market_place_customer/bloc/order_history_bloc/order_history/order_history_bloc.dart';
import 'package:market_place_customer/bloc/order_history_bloc/save_bill_bloc/upload_gallery_bloc.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/purchased_offers_details/purchased_offers_bloc.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/update_bill_amount/update_bill_amount_bloc.dart';

import '../utils/exports.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<VerifyOtpBloc>(create: (context) => VerifyOtpBloc()),
        BlocProvider<CustomerSignupBloc>(
            create: (context) => CustomerSignupBloc()),
        BlocProvider<FetchDashboardOffersBloc>(
            create: (context) => FetchDashboardOffersBloc()),
        BlocProvider<FetchVendorsBloc>(create: (context) => FetchVendorsBloc()),
        BlocProvider<VendorDetailsBloc>(
            create: (context) => VendorDetailsBloc()),
        BlocProvider<ViewOffersBloc>(create: (context) => ViewOffersBloc()),
        BlocProvider<BusinessCategoryCubit>(
            create: (context) => BusinessCategoryCubit()),
        BlocProvider<PaymentBloc>(create: (context) => PaymentBloc()),
        BlocProvider<PurchasedOffersHistoryBloc>(
            create: (context) => PurchasedOffersHistoryBloc()),
        BlocProvider<UpdateBillAmountBloc>(
            create: (context) => UpdateBillAmountBloc()),
        BlocProvider<PurchasedOffersBloc>(
            create: (context) => PurchasedOffersBloc()),
        BlocProvider<OrderHistoryBloc>(create: (context) => OrderHistoryBloc()),
        BlocProvider<SaveBillBloc>(create: (context) => SaveBillBloc()),

        ///====>>>>
        BlocProvider<FetchProfileDetailsBloc>(
            create: (context) => FetchProfileDetailsBloc()),
        BlocProvider<UpdateProfileBloc>(
            create: (context) => UpdateProfileBloc()),
        BlocProvider<SupportBloc>(create: (context) => SupportBloc()),
      ],
      child: child,
    );
  }
}

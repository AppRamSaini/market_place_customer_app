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
        BlocProvider<FetchProfileDetailsBloc>(
            create: (context) => FetchProfileDetailsBloc()),
        BlocProvider<UpdateProfileBloc>(
            create: (context) => UpdateProfileBloc()),
        BlocProvider<UpdateMobileBloc>(create: (context) => UpdateMobileBloc()),
      ],
      child: child,
    );
  }
}

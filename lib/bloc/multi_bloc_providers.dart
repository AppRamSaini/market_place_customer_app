


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

        BlocProvider<FetchVendorsBloc>(
            create: (context) => FetchVendorsBloc()),


        BlocProvider<BusinessCategoryCubit>(
            create: (context) => BusinessCategoryCubit()),
        BlocProvider<AddOffersBloc>(create: (context) => AddOffersBloc()),
        BlocProvider<FetchOffersBloc>(create: (context) => FetchOffersBloc()),
        BlocProvider<DeleteOffersBloc>(create: (context) => DeleteOffersBloc()),
        BlocProvider<UpdateOffersBloc>(create: (context) => UpdateOffersBloc()),
        BlocProvider<ViewOffersBloc>(create: (context) => ViewOffersBloc()),
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

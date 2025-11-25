import 'package:market_place_customer/bloc/customer_registration/fetch_profile_bloc/fetch_profile_event.dart';
import 'package:market_place_customer/utils/exports.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  CustomerRegistrationModel? customerRegistrationModel;
  late List settingTitles;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool isLoggedIn = await checkedLogin(context);
      if (!isLoggedIn) return;
    });
  }

  Future _reFetchData() async => context
      .read<FetchProfileDetailsBloc>()
      .add(FetchProfileEvent(context: context));

  /// new code
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateProfileBloc, UpdateProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileSuccess) _reFetchData();
          },
        )
      ],
      child: BlocBuilder<FetchProfileDetailsBloc, FetchProfileDetailsState>(
        builder: (context, state) {
          if (state is FetchProfileDetailsLoading) {
            return profileSimmerHeader();
          } else if (state is FetchProfileDetailsFailure) {
            return SliverToBoxAdapter(
                child: Center(
                    child: Text(state.error.toString(),
                        style: AppStyle.medium_14(AppColors.redColor))));
          } else if (state is FetchProfileDetailsSuccess) {
            final profile = state.profileModel.customerProfileData;

            return customAppHeader(profile);
          }

          return const SliverToBoxAdapter(child: SizedBox());
        },
      ),
    );
  }
}

/// Modern App Header
SliverAppBar customAppHeader(CustomerProfileData? profileData) {
  return SliverAppBar(
    pinned: true,
    expandedHeight: size.height * 0.12,
    backgroundColor: Colors.indigo,
    flexibleSpace: FlexibleSpaceBar(
      background: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff3949ab), Color(0xff5c6bc0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(profileData!.avatar ?? '',
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) => Image.asset(
                            Assets.dummy,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profileData.name ?? "Hi ",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("+91 ${profileData.phone}",
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.white70)),
                          const Text(
                            "App Version : 1.0.1",
                            style:
                                TextStyle(fontSize: 13, color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

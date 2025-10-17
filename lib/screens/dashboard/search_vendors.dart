import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_all_vendors/fetch_all_vendors_event.dart';
import 'package:market_place_customer/screens/location/search_location.dart';
import '../../utils/exports.dart';

class SearchVendorsPage extends StatefulWidget {
  const SearchVendorsPage({super.key});

  @override
  State<SearchVendorsPage> createState() => _SearchVendorsPageState();
}

class _SearchVendorsPageState extends State<SearchVendorsPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  double _flexTitleOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    fetchVendors();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double maxOffset = size.height * 0.3;
      double opacity = (offset / maxOffset).clamp(0.0, 1.0);
      setState(() {
        _flexTitleOpacity = 1.0 - opacity;
      });
    });
  }

  bool searchValue = false;

  Future fetchVendors() async {
    context.read<FetchVendorsBloc>().add(GetVendorsEvent(context: context));
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      controller: _scrollController,
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.whiteColor,
          floating: true,
          pinned: true,
          snap: true,
          stretch: true,
          leadingWidth: size.width * 0.12,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.theme10.withOpacity(0.1)),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_new,
                    size: 22,
                    color: _flexTitleOpacity == 1.0
                        ? AppColors.blackColor
                        : AppColors.blackColor),
              ),
            ),
          ),
          title: AnimatedHintSearchField1(
            controller: controller,
            suffix: searchValue
                ? IconButton(
                    icon:
                        Icon(Icons.cancel, color: AppColors.black20, size: 25),
                    onPressed: () {
                      setState(() => searchValue = false);
                      controller.clear();
                    })
                : null,
            fillColor: AppColors.theme10.withOpacity(0.1),
            onChanged: (value) {
              context
                  .read<FetchVendorsBloc>()
                  .add(GetVendorsEvent(context: context, search: value));
              setState(() => searchValue = value.length > 2);
            },
          ),
        ),
        SliverToBoxAdapter(
          child: RefreshIndicator(
            onRefresh: fetchVendors,
            child: BlocBuilder<FetchVendorsBloc, FetchVendorsState>(
              builder: (context, state) {
                if (state is FetchVendorsLoading) {
                  return const BurgerKingShimmer();
                } else if (state is FetchVendorsFailure) {
                  return Center(
                      child: Text(state.error,
                          style: AppStyle.medium_14(AppColors.redColor)));
                } else if (state is FetchVendorsSuccess) {
                  final vendorsList = state.model.data ?? [];

                  return ListView.builder(
                    itemCount: vendorsList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final vendor = vendorsList[index];

                      return FutureBuilder<Map<String, String>>(
                        future: getAddressAndDistance(
                            vendor.vendor!.lat!, vendor.vendor!.long!),
                        builder: (context, snapshot) {
                          String location = 'Loading...';
                          String distance = '';

                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            location = snapshot.data!['address']!;
                            distance = snapshot.data!['distance']!;
                          }

                          return Padding(
                            padding: EdgeInsets.only(
                                top: size.height * 0.015,
                                left: size.width * 0.03,
                                right: size.width * 0.03,
                                bottom: index == vendorsList.length - 1
                                    ? size.height * 0.1
                                    : 0.0),
                            child: searchVendorWidget(
                              imgUrl: vendor.vendor!.businessLogo ?? '',
                              businessName: vendor.vendor!.businessName ?? '',
                              location: location,
                              distance: distance,
                              category: vendor.vendor!.category!.name ?? '',
                              offers: vendor.maxOffer != null
                                  ? vendor.maxOffer!.type == 'percentage'
                                      ? "Flat ${vendor.maxOffer!.amount}% OFF"
                                      : "Flat ₹${vendor.maxOffer!.amount} OFF"
                                  : '',
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ],
    ));
  }
}

Widget searchVendorWidget({
  String? imgUrl,
  String? businessName,
  String? category,
  String? location,
  String? distance,
  String? offers,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
            height: size.height * 0.09,
            width: size.height * 0.08,
            fit: BoxFit.cover,
            placeholder: const AssetImage(Assets.dummy),
            image: imgUrl!.isNotEmpty
                ? NetworkImage(imgUrl!)
                : const AssetImage(Assets.dummy) as ImageProvider,
            imageErrorBuilder: (_, __, ___) => Image.asset(
              Assets.dummy,
              height: size.height * 0.09,
              width: size.height * 0.08,
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(width: 10),

        /// Center: Vendor Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Business Name + Category
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: businessName ?? '',
                        style: AppStyle.semiBold_15(AppColors.blackColor)),
                    TextSpan(
                        text: "  (${category ?? ''})",
                        style: AppStyle.medium_13(AppColors.themeColor)),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              /// Location + Distance
              Text(
                "${location ?? ''} • ${distance ?? ''}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyle.medium_12(AppColors.black70),
              ),

              /// offers
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(Assets.offersIcon,
                      color: Colors.green, height: 18),
                  const SizedBox(width: 5),
                  Text(
                    "Flat 30% Off",
                    style: AppStyle.medium_14(AppColors.green),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),

        /// Right: Offer Section
        CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.theme10,
            child: const Icon(Icons.arrow_forward_ios,
                size: 17, color: AppColors.themeColor))
      ],
    ),
  );
}

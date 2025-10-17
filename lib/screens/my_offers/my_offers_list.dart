import 'package:market_place_customer/bloc/fetch_vendors/delete_offers/delete_offers_event.dart';
import '../../bloc/fetch_vendors/fetch_offers/fetch_offers_bloc.dart';
import '../../bloc/fetch_vendors/fetch_offers/fetch_offers_event.dart';
import '../../bloc/fetch_vendors/fetch_offers/fetch_offers_state.dart';
import '../../bloc/fetch_vendors/view_offers_details/view_offers_event.dart';
import '../../utils/exports.dart';

class MyOffersList extends StatefulWidget {
  const MyOffersList({super.key});

  @override
  State<MyOffersList> createState() => _MyOffersListState();
}

class _MyOffersListState extends State<MyOffersList> {
  @override
  void initState() {
    super.initState();
    refreshData(context);
  }

  Future refreshData(BuildContext context) async {
    context.read<FetchOffersBloc>().add(GetOffersEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<DeleteOffersBloc, DeleteOffersState>(
            listener: (context, state) {
              EasyLoading.dismiss();
              if (state is DeleteOffersLoading) {
                EasyLoading.show();
              } else if (state is DeleteOffersSuccess) {
                final data = state.offersData;
                snackBar(context, data['message'].toString(), AppColors.green);
                refreshData(context);
              } else if (state is DeleteOffersFailure) {
                snackBar(context, state.error.toString(), AppColors.redColor);
                refreshData(context);
              } else if (state is DeleteOffersInvalidResult) {
                EasyLoading.dismiss();
              } else {
                EasyLoading.dismiss();
              }
            },
          ),
          BlocListener<AddOffersBloc, AddOffersState>(
            listener: (context, state) {
              if (state is AddOffersSuccess) {
                refreshData(context);
              }
            },
          ),
          BlocListener<UpdateOffersBloc, UpdateOffersState>(
            listener: (context, state) {
              if (state is UpdateOffersSuccess) {
                refreshData(context);
              }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: () => refreshData(context),
          child: CustomScrollView(
            slivers: [
              customSliverAppbar(
                  expandedHeight: size.height * 0,
                  title: Text("My Offers",
                      style: AppStyle.medium_18(AppColors.themeColor))),
              BlocBuilder<FetchOffersBloc, FetchOffersState>(
                builder: (context, state) {
                  if (state is FetchOffersLoading) {
                    return SliverToBoxAdapter(
                        child: Center(child: notificationShimmerLoading()));
                  } else if (state is FetchOffersFailure) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          state.error.toString(),
                          style: AppStyle.medium_14(AppColors.redColor),
                        ),
                      ),
                    );
                  } else if (state is FetchOffersSuccess) {
                    final offersList = state.fetchOffersListModel.data;

                    if (offersList!.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height / 2.5),
                            child: Text(
                              "Offers Not Found",
                              style: AppStyle.medium_14(AppColors.themeColor),
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: offersList!.length,
                        (context, index) => Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.03,
                                right: size.width * 0.03,
                                top: size.width * 0.03),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: TicketWidget(
                                width: size.width,
                                height: size.height * 0.16,
                                color: AppColors.theme5,
                                isCornerRounded: false,
                                padding: EdgeInsets.only(
                                    top: size.height * 0.02,
                                    right: size.width * 0.03,
                                    left: size.width * 0.03),
                                child: TicketData(data: offersList[index]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SliverToBoxAdapter(child: SizedBox());
                  }
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: size.height * 0.1))
            ],
          ),
        ),
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  OffersList? data;
  TicketData({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...[
                if (data?.flat != null) data!.flat!,
                if (data?.percentage != null) data!.percentage!,
              ].map((offer) => offerItem(size, offer, data!.status)),
            ],
          ),
        ),
        popMenusForOffers(context: context, data: data),
      ],
    );
  }
}

Widget offerItem(Size size, dynamic offer, String? status) {
  return Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: FadeInImage(
            height: size.height * 0.08,
            width: size.height * 0.08,
            fit: BoxFit.cover,
            placeholder: const AssetImage(Assets.redeemOffers),
            image: offer.offerImage.isNotEmpty
                ? NetworkImage(offer.offerImage ?? '')
                : const AssetImage(Assets.dummy) as ImageProvider,
            imageErrorBuilder: (_, __, ___) =>
                Image.asset(Assets.dummy, fit: BoxFit.cover)),
      ),
      SizedBox(width: size.width * 0.03),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Flat ${offer.discountPercentage ?? ''}% OFF",
                style: AppStyle.semiBold_18(AppColors.blackColor),
              ),
              if (status != 'active')
                Icon(Icons.do_disturb_alt_outlined, color: AppColors.redColor),
            ],
          ),
          Text(
            'on orders above ₹${offer.minBillAmount ?? ''}',
            style: AppStyle.normal_14(AppColors.black20),
          ),
          Text(
            offer.title ?? '',
            style: AppStyle.medium_16(AppColors.blackColor),
          ),
          Text(
            'Max. Dis. ₹${offer.maxDiscountCap ?? ''}  Min. Bill ₹${offer.minBillAmount ?? ''}',
            style: AppStyle.normal_12(AppColors.black20),
          ),
        ],
      ),
    ],
  );
}

Widget popMenusForOffers(
    {required OffersList? data, required BuildContext context}) {
  // Decide options based on status
  List<Map<String, dynamic>> options = data!.status == 'active'
      ? [
          {"icon": Icons.visibility, "menu": "View Details", "menu_id": 1},
          {"icon": Icons.edit, "menu": "Update", "menu_id": 2},
          {"icon": Icons.delete, "menu": "Delete", "menu_id": 3},
          {"icon": Icons.visibility_off, "menu": "Disabled", "menu_id": 4},
        ]
      : [
          {"icon": Icons.visibility, "menu": "View Details", "menu_id": 1},
          {"icon": Icons.edit, "menu": "Update", "menu_id": 2},
          {"icon": Icons.delete, "menu": "Delete", "menu_id": 3},
          {"icon": Icons.local_offer_sharp, "menu": "Enabled", "menu_id": 4},
        ];

  return CircleAvatar(
    backgroundColor: AppColors.theme10,
    child: PopupMenuButton(
      elevation: 10,
      padding: EdgeInsets.zero,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          color: AppColors.black20, size: 25.0),
      offset: const Offset(0, 50),
      itemBuilder: (BuildContext bc) {
        return options
            .map(
              (selectedOption) => PopupMenuItem(
                padding: EdgeInsets.zero,
                value: selectedOption,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 30),
                  child: Row(
                    children: [
                      Icon(selectedOption['icon'], color: AppColors.black20),
                      const SizedBox(width: 10),
                      Text(selectedOption['menu'] ?? "",
                          style: AppStyle.medium_14(AppColors.black20))
                    ],
                  ),
                ),
              ),
            )
            .toList();
      },
      onSelected: (value) async {
        if (value['menu_id'] == 1) {
          context.read<ViewOffersBloc>().add(ViewOffersDetailsEvent(
              context: context, offersId: data!.id.toString()));

          AppRouter().navigateTo(context, ViewOffersDetails());
        } else if (value['menu_id'] == 2) {
          // AppRouter()
          //     .navigateTo(context, CreateOffers(data: data, forUpdate: true));
        } else if (value['menu_id'] == 3) {
          deleteOffersDialog(
              context: context,
              onPressed: () {
                Navigator.pop(context);

                context.read<DeleteOffersBloc>().add(DeleteOffersSubmit(
                    context: context, offersId: data.id.toString()));
              },
              deleteText: "offer");
        }
      },
    ),
  );
}

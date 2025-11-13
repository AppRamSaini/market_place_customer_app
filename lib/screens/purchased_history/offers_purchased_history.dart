import 'package:animate_do/animate_do.dart';
import 'package:market_place_customer/screens/purchased_history/purchased_offers_details.dart';
import 'package:market_place_customer/utils/exports.dart';

import '../../data/models/purchased_offers_history_model.dart';
import 'helper_widgets.dart';

class PurchasedOffersHistory extends StatefulWidget {
  const PurchasedOffersHistory({super.key});

  @override
  State<PurchasedOffersHistory> createState() => _PurchasedOffersHistoryState();
}

class _PurchasedOffersHistoryState extends State<PurchasedOffersHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future fetchOffersHistory() async {
    context
        .read<PurchasedOffersHistoryBloc>()
        .add(GetPurchasedOffersHistoryEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "My Offers", showLeading: true),
      body:
          BlocBuilder<PurchasedOffersHistoryBloc, PurchasedOffersHistoryState>(
        builder: (context, state) {
          if (state is PurchasedOffersHistoryLoading) {
            return const Center(child: BurgerKingShimmer());
          } else if (state is PurchasedOffersHistoryFailure) {
            print(
              state.error.toString(),
            );
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  state.error.toString(),
                  textAlign: TextAlign.center,
                  style: AppStyle.medium_14(AppColors.redColor),
                ),
              ),
            );
          } else if (state is PurchasedOffersHistorySuccess) {
            final offersData = state.model.data ?? [];

            // 🔹 Separate by Status
            final activeOffers = offersData.where((offer) {
              bool isExpired = offer.offer?.flat?.isExpired ??
                  offer.offer?.percentage?.isExpired ??
                  false;
              return offer.status == 'active' &&
                  !isExpired &&
                  offer.vendorBillStatus == false;
            }).toList();

            final expiredOffers = offersData.where((offer) {
              bool isExpired = offer.offer?.flat?.isExpired ??
                  offer.offer?.percentage?.isExpired ??
                  false;
              return isExpired;
            }).toList();

            final usedOffers = offersData.where((offer) {
              bool isExpired = offer.offer?.flat?.isExpired ??
                  offer.offer?.percentage?.isExpired ??
                  false;
              return !isExpired && offer.vendorBillStatus == true;
            }).toList();

            final tabs = [
              "Active (${activeOffers.length})",
              "Expired (${expiredOffers.length})",
              "Used (${usedOffers.length})",
            ];

            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.4))),
                  child: TabBar(
                    controller: _tabController,
                    indicator: const UnderlineTabIndicator(
                        borderSide:
                            BorderSide(width: 2, color: AppColors.themeColor)),
                    labelColor: AppColors.themeColor,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                    unselectedLabelStyle:
                        const TextStyle(fontWeight: FontWeight.w400),
                    tabs: tabs.map((e) => Tab(text: e)).toList(),
                  ),
                ),

                /// 🔹 Tab Views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOfferList(activeOffers, size, "Active"),
                      _buildOfferList(expiredOffers, size, "Expired"),
                      _buildOfferList(usedOffers, size, "Used"),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  /// 🔹 Common Offer List Builder
  Widget _buildOfferList(
      List<PurchasedOffersHistoryList> offers, Size size, String label) {
    if (offers.isEmpty) {
      return Center(
        child: Text(
          "No $label Offers Found",
          style: AppStyle.medium_14(AppColors.greyColor),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: fetchOffersHistory,
      child: ListView.builder(
        itemCount: offers.length,
        padding: EdgeInsets.only(top: size.height * 0.01),
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          final offer = offers[index];
          final isFlat = offer.offer?.flat != null;
          bool isExpired = offer.offer?.flat?.isExpired ??
              offer.offer?.percentage?.isExpired ??
              false;
          bool isPurchased = offer.vendorBillStatus == true;

          print('=====$isFlat');
          DateTime? expiredTime = isFlat
              ? offer.offer?.flat?.expiryDate! ?? DateTime.now()
              : offer.offer?.percentage!.expiryDate! ?? DateTime.now();

          final title = isFlat
              ? offer.offer?.flat?.title ?? ""
              : offer.offer?.percentage?.title ?? "";
          final minBill = isFlat
              ? offer.offer?.flat?.minBillAmount ?? ""
              : offer.offer?.percentage?.minBillAmount ?? "";

          final flatData = isFlat
              ? "Flat ₹${offer.offer?.flat?.discountPercentage ?? ''}"
              : "Flat ${offer.offer?.percentage?.discountPercentage ?? ''}%";

          final amount = isFlat
              ? offer.offer?.flat?.amount ?? ""
              : offer.offer?.percentage?.amount ?? "";
          final discounts = isFlat
              ? offer.offer?.flat?.maxDiscountCap ?? ""
              : offer.offer?.percentage?.maxDiscountCap ?? "";

          final imgUrl = isFlat
              ? offer.offer?.flat?.offerImage ?? ""
              : offer.offer?.percentage?.offerImage ?? "";

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.005),
            child: GestureDetector(
                onTap: () {
                  AppRouter().navigateTo(context,
                      PurchasedOfferDetailsPage(offersId: offer.id ?? ''));
                },
                child: FadeInRightBig(
                  duration: Duration(milliseconds: 300 + (index * 120)),
                  child: PurchasedOffersHistoryCardWidget(
                    carWidth: size.width * 0.9,
                    imgHeight: size.height * 0.25,
                    isExpired: isExpired,
                    isPurchased: isPurchased,
                    imageUrl: imgUrl,
                    name: title,
                    purchasedPrice: amount.toString(),
                    discount: discounts.toString(),
                    expireIn:
                        !isPurchased && !isExpired ? expiredTime : expiredTime,
                    flatData: flatData,
                    offerText: "On Order Above ₹$minBill",
                    offersCounts: offer.finalAmount?.toString() ?? "0",
                  ),
                )),
          );
        },
      ),
    );
  }
}

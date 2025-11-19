import 'package:market_place_customer/data/models/purchased_offers_history_model.dart';
import 'package:market_place_customer/screens/dilogs/already_used_this_offers.dart';
import 'package:market_place_customer/screens/purchased_history/purchased_offers_details.dart';
import 'package:market_place_customer/utils/exports.dart';

import 'helper_widgets.dart';

class PurchasedOffersHistory extends StatefulWidget {
  const PurchasedOffersHistory({super.key});

  @override
  State<PurchasedOffersHistory> createState() => _PurchasedOffersHistoryState();
}

class _PurchasedOffersHistoryState extends State<PurchasedOffersHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final ScrollController _scrollController = ScrollController();

  int _page = 1;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchData({bool isLoadMore = false}) async {
    context.read<PurchasedOffersHistoryBloc>().add(
        GetPurchasedOffersHistoryEvent(
            context: context, page: _page, isLoadMore: isLoadMore));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _loadMore();
    }
  }

  int totalPages = 1;

  void _loadMore() async {
    final bloc = context.read<FetchVendorsBloc>();
    final state = bloc.state;

    if (state is FetchVendorsSuccess) {
      totalPages = state.model.data!.totalPages ?? 1;
      if (_page >= totalPages) return;

      if (state.hasReachedMax) return;
      if (state.isPaginating) return;
      if (_isFetchingMore) return;

      _isFetchingMore = true;
      _page++;

      await _fetchData(isLoadMore: true);

      _isFetchingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "My Offers", hideLeading: true),
      body:
          BlocBuilder<PurchasedOffersHistoryBloc, PurchasedOffersHistoryState>(
        builder: (context, state) {
          if (state is PurchasedOffersHistoryLoading) {
            return const Center(child: BurgerKingShimmer());
          } else if (state is PurchasedOffersHistoryFailure) {
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
            final offersData = state.model.data!.purchasedCustomers ?? [];

            final paginate = state.isPaginating;

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
                      _buildOfferList(activeOffers, size, paginate, "Active"),
                      _buildOfferList(expiredOffers, size, paginate, "Expired"),
                      _buildOfferList(usedOffers, size, paginate, "Used"),
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
      List<PurchasedCustomer> offers, Size size, var paginate, String label) {
    if (offers.isEmpty) {
      return Center(
        child: Text(
          "No $label Offers Found",
          style: AppStyle.medium_14(AppColors.greyColor),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        _fetchData(isLoadMore: false);
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.only(top: size.height * 0.01),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: offers.length + (paginate ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == offers.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: AppColors.themeColor,
                ),
              ),
            );
          }

          final offer = offers[index];
          final isFlat = offer.offer?.flat != null;
          bool isExpired = offer.offer?.flat?.isExpired ??
              offer.offer?.percentage?.isExpired ??
              false;
          bool isPurchased = offer.vendorBillStatus == true;

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
                  if (isExpired) {
                    showOfferExpiredDialog(context);
                    return;
                  }

                  if (isPurchased) {
                    showAlreadyUsedOfferDialog(context);
                    return;
                  }

                  /// mmm

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

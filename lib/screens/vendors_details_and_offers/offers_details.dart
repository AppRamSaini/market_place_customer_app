import 'package:market_place_customer/screens/vendors_details_and_offers/vendor_details_helper.dart';

import '../../utils/exports.dart';

class ViewOffersDetails extends StatefulWidget {
  final String offersId;
  const ViewOffersDetails({super.key, required this.offersId});
  @override
  State<ViewOffersDetails> createState() => _ViewOffersDetailsState();
}

class _ViewOffersDetailsState extends State<ViewOffersDetails> {
  final ScrollController _scrollController = ScrollController();

  double _appBarOpacity = 0.0;
  double _flexTitleOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double maxOffset = size.height * 0.3;

      double opacity = (offset / maxOffset).clamp(0.0, 1.0);
      setState(() {
        _appBarOpacity = opacity;
        _flexTitleOpacity = 1.0 - opacity;
      });
    });
    onRefreshData();
  }

  Future onRefreshData() async {
    context.read<ViewOffersBloc>().add(ViewOffersDetailsEvent(
        context: context, offersId: widget.offersId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<ViewOffersBloc, ViewOffersState>(builder: (context, state) {
      if (state is ViewOffersLoading) {
        return const BurgerKingShimmer();
      } else if (state is ViewOffersFailure) {
        return Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: Text(
              state.error.toString(),
              textAlign: TextAlign.center,
              style: AppStyle.medium_14(AppColors.redColor),
            ),
          ),
        );
      } else if (state is ViewOffersSuccess) {
        final offersData = state.offersDetailModel.data;

        final singleOffer = offersData!.record;

        var imageUrl = singleOffer!.flat != null
            ? singleOffer.flat!.offerImage
            : singleOffer.percentage!.offerImage.toString();

        List termsData = [
          "Only one coupon can be applied per order or transaction.",
          singleOffer.flat != null
              ? "This coupon offers a flat ₹${singleOffer.flat!.maxDiscountCap} discount on eligible purchases."
              : "This coupon offers a flat ${singleOffer.percentage!.discountPercentage}% discount on eligible purchases.",
          "The coupon is valid only on transactions with a minimum bill amount of ₹${singleOffer.flat != null ? singleOffer.flat!.minBillAmount : singleOffer.percentage!.minBillAmount}.",
          "The maximum discount per transaction is ₹${singleOffer.flat != null ? singleOffer.flat!.maxDiscountCap : singleOffer.percentage!.maxDiscountCap}",
          "Coupons are valid only within the specified period and subject to availability.",
          "Coupons are non-transferable, non-exchangeable, and cannot be redeemed for cash or any other value.",
        ];

        return CustomScrollView(
          controller: _scrollController,

          slivers: [
            SliverAppBar(
              expandedHeight: size.height * 0.24,
              floating: false,
              pinned: true,
              snap: false,
              stretch: true,
              backgroundColor: AppColors.themeColor,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.theme10.withOpacity(0.1)),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios_new,
                        size: 20,
                        color: _flexTitleOpacity == 1.0
                            ? AppColors.blackColor
                            : AppColors.whiteColor),
                  ),
                ),
              ),
              title: Opacity(
                  opacity: _appBarOpacity,
                  child: Text(
                      singleOffer.flat != null
                          ? singleOffer.flat!.title.toString()
                          : singleOffer.percentage!.title.toString(),
                      style: AppStyle.medium_15(AppColors.whiteColor))),
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  titlePadding: EdgeInsets.zero,
                  background: FadeInImage(
                    height: size.height * 0.25,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: const AssetImage(Assets.dummy),
                    image: imageUrl!.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : const AssetImage(Assets.dummy) as ImageProvider,
                    imageErrorBuilder: (_, child, st) => Image.asset(
                        Assets.dummy,
                        height: size.height * 0.17,
                        fit: BoxFit.cover,
                        width: double.infinity),
                  )),
            ),
            SliverToBoxAdapter(
                child: Padding(
                  padding:  EdgeInsets.only(left: size.width*0.03,top: size.height*0.02),
                  child: Text(
                      singleOffer.flat != null
                          ? singleOffer.flat!.title.toString()
                          : singleOffer.percentage!.title.toString(),
                      style: AppStyle.medium_18(AppColors.themeColor)),
                )),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.014),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.theme10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Offers Description",
                        style: AppStyle.normal_16(AppColors.blackColor)),
                    Text(
                        singleOffer.flat != null
                            ? "Get flat ₹${singleOffer.flat!.maxDiscountCap} Discount on all orders above ₹${singleOffer.flat!.minBillAmount}"
                            : "Get flat ${singleOffer.percentage!.discountPercentage}% Discount on all orders above ₹${singleOffer.percentage!.minBillAmount}",
                        style: AppStyle.normal_13(AppColors.black20)),
                    Divider(color: AppColors.theme5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        trackerData(
                            title: "Min Bill Amt.",
                            subTitle:
                                "₹${singleOffer.flat != null ? singleOffer.flat!.minBillAmount : singleOffer.percentage!.minBillAmount}",
                            bgColor: AppColors.themeColor.withOpacity(0.1),
                            txtColor: AppColors.themeColor),
                        trackerData(
                            title: "Max. Discount",
                            subTitle:
                                "₹${singleOffer.flat != null ? singleOffer.flat!.maxDiscountCap : singleOffer.percentage!.maxDiscountCap}",
                            bgColor: AppColors.themeColor.withOpacity(0.1),
                            txtColor: AppColors.themeColor),
                        trackerData(
                            title: "Validity",
                            subTitle: singleOffer.flat != null
                                ? formatDateAMPM(singleOffer.flat!.expiryDate!)
                                : formatDateAMPM(
                                    singleOffer.percentage!.expiryDate!),
                            bgColor: AppColors.themeColor.withOpacity(0.1),
                            txtColor: AppColors.themeColor),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                          vertical: size.height * 0.011),
                      decoration: BoxDecoration(
                          color: AppColors.themeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.themeColor.withOpacity(0.2))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Total Amount",
                                    style: AppStyle.medium_16(
                                        AppColors.blackColor),
                                    overflow: TextOverflow.ellipsis),
                                Text(
                                  singleOffer.flat != null
                                      ? "You’ll save ₹${singleOffer.flat!.maxDiscountCap} on this purchase"
                                      : "You’ll save ${singleOffer.percentage!.discountPercentage}% on this purchase",
                                  style: AppStyle.normal_12(AppColors.black20),
                                ),
                              ],
                            ),
                          ),
                          Text(
                              "₹ ${singleOffer.flat != null ? singleOffer.flat!.amount : singleOffer.percentage!.amount}",
                              style: AppStyle.semiBold_18(AppColors.green),
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    CustomButton(
                        onPressed: () {}, txt: "Buy Now", minWidth: size.width)
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: customExpansionTile(
                  subTitle: "Tap to expand and read terms & conditions",
                  context: context,
                  txt: "Terms & Conditions",
                  children: List.generate(
                      termsData.length,
                      (index) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, right: 5),
                                  child: CircleAvatar(
                                      radius: 3,
                                      backgroundColor: AppColors.black20)),
                              Flexible(
                                child: Text(termsData[index].toString(),
                                    style:
                                        AppStyle.normal_14(AppColors.black20)),
                              ),
                            ],
                          )),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(child: SizedBox(height: size.height * 0.2)),
          ],
        );
      } else {
        return const SizedBox();
      }
    }));
  }
}

Widget trackerData(
        {String? title,
        String? subTitle,
        Color? bgColor = Colors.grey,
        required Color txtColor}) =>
    Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.01),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.grey50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title.toString(),
              style: AppStyle.normal_14(AppColors.greyColor)),
          Text(
            subTitle.toString(),
            textAlign: TextAlign.center,
            style: AppStyle.medium_13(AppColors.black20),
          ),
        ],
      ),
    );

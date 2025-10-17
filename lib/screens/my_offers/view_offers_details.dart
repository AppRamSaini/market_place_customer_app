import '../../utils/exports.dart';

class ViewOffersDetails extends StatefulWidget {
  const ViewOffersDetails({super.key});
  @override
  State<ViewOffersDetails> createState() => _ViewOffersDetailsState();
}

class _ViewOffersDetailsState extends State<ViewOffersDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<ViewOffersBloc, ViewOffersState>(builder: (context, state) {
      if (state is ViewOffersLoading) {
        return Center(child: BurgerKingShimmer());
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
        return CustomScrollView(
          slivers: [
            customSliverAppbar(
              expandedHeight: size.height * .25,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        size: 20, color: AppColors.themeColor),
                    onPressed: () => Navigator.pop(context!),
                    color: AppColors.themeColor,
                  ),
                  Row(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          height: size.height * 0.04,
                          width: size.height * 0.040,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.black20),
                          child: IconButton(
                              icon: const Icon(Icons.edit,
                                  size: 20, color: AppColors.whiteColor),
                              onPressed: () {
                                OffersList? data = OffersList(
                                    id: offersData!.record!.id.toString(),
                                    flat: offersData.record!.flat,
                                    percentage: offersData.record!.flat,
                                    type: offersData.record!.type,
                                    status: offersData.record!.status,
                                    v: offersData.record!.v,
                                    vendor:
                                        offersData.record!.vendor.toString());
                                // AppRouter().navigateTo(context,
                                //     CreateOffers(data: data, forUpdate: true));
                              })),
                      SizedBox(width: size.width * 0.03),
                      Container(
                        alignment: Alignment.center,
                        height: size.height * 0.04,
                        width: size.height * 0.040,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.black20),
                        child: IconButton(
                            icon: const Icon(Icons.share,
                                size: 20, color: AppColors.whiteColor),
                            onPressed: () => Navigator.pop(context!)),
                      ),
                    ],
                  )
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                background: Image.network(
                  "https://picsum.photos/400/200",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03,
                    vertical: size.height * 0.02),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03,
                    vertical: size.height * 0.014),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.theme10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        profilePickImage(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Burger_King_logo_%281999%E2%80%932020%29.svg/1012px-Burger_King_logo_%281999%E2%80%932020%29.svg.png'),
                        SizedBox(width: 5),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Burger King Farm",
                                    style: AppStyle.medium_18(
                                        AppColors.blackColor)),
                                Text(
                                  "Flat 30% OFF on orders above ₹1000",
                                  style: AppStyle.normal_13(AppColors.black20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        CustomButton3(
                            onPressed: () {},
                            bgColor: AppColors.theme10,
                            txtColor: AppColors.themeColor,
                            txt: "Disable")
                      ],
                    ),
                    Divider(color: AppColors.theme5),
                    Text("Details",
                        style: AppStyle.medium_16(AppColors.blackColor)),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: CircleAvatar(
                                          radius: 3,
                                          backgroundColor: AppColors.black20)),
                                  SizedBox(width: 5),
                                  Flexible(
                                    child: Text(
                                        "Flat 30% OFF on orders above ₹1000 dsfns jbfdjb djbnmvb dnfbv n",
                                        style: AppStyle.normal_14(
                                            AppColors.black20)),
                                  ),
                                ],
                              ),
                            ))
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03, vertical: size.height * 0.02),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03, vertical: size.height * 0.02),
              decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.green.withOpacity(0.2))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Total Amount",
                            style: AppStyle.medium_16(AppColors.blackColor),
                            overflow: TextOverflow.ellipsis),
                        Text(
                          "You’ll save ₹30 on this purchase",
                          style: AppStyle.normal_12(AppColors.black20),
                        ),
                      ],
                    ),
                  ),
                  Text("₹70",
                      style: AppStyle.semiBold_18(AppColors.green),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            )),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: trackerData(
                          title: "213",
                          subTitle: "Total Redeem",
                          bgColor: AppColors.whiteColor,
                          txtColor: AppColors.themeColor),
                    )),
                    Expanded(
                        child: trackerData(
                            title: "343",
                            subTitle: "Total Purchase",
                            bgColor: AppColors.green.withOpacity(0.1),
                            txtColor: AppColors.green)),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: trackerData(
                          title: "454",
                          subTitle: "Pending",
                          bgColor: AppColors.yellowColor.withOpacity(0.1),
                          txtColor: AppColors.yellowColor),
                    )),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: size.height * 0.2)),
          ],
        );
      } else {
        return SizedBox();
      }
    }));
  }
}

Widget trackerData(
        {String? title,
        String? subTitle,
        Color? bgColor,
        required Color txtColor}) =>
    Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.025),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.grey50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title.toString(), style: AppStyle.semiBold_20(txtColor!)),
          Text(
            subTitle.toString(),
            textAlign: TextAlign.center,
            style: AppStyle.normal_12(AppColors.black20),
          ),
        ],
      ),
    );

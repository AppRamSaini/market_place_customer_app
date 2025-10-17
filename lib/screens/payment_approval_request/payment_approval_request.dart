import '../../utils/exports.dart';

class ViewPaymentApprovalRequest extends StatefulWidget {
  const ViewPaymentApprovalRequest({super.key});

  @override
  State<ViewPaymentApprovalRequest> createState() =>
      ViewPaymentApprovalRequestState();
}

class ViewPaymentApprovalRequestState
    extends State<ViewPaymentApprovalRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "Payment Approval Request"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.02),
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.04),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.theme10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: profilePickImage(
                        'https://e7.pngegg.com/pngimages/312/283/png-clipart-man-s-face-avatar-computer-icons-user-profile-business-user-avatar-blue-face-thumbnail.png')),
                SizedBox(height: 5),
                Text("Rahul sharma ",
                    style: AppStyle.medium_18(AppColors.blackColor)),
                Text("Rahul Sharma is trying to pay ₹1930. ",
                    style: AppStyle.normal_14(AppColors.black20)),
                Text(
                    "Please collect the payment offline and mark it as received here.",
                    textAlign: TextAlign.center,
                    style: AppStyle.normal_14(AppColors.black20)),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.02),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.02),
                  decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.green.withOpacity(0.2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Bill Amount : ",
                              style: AppStyle.medium_16(AppColors.blackColor),
                              overflow: TextOverflow.ellipsis),
                          Text("₹70",
                              style: AppStyle.medium_16(AppColors.green),
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Discount(30%):",
                              style: AppStyle.normal_14(AppColors.black20),
                              overflow: TextOverflow.ellipsis),
                          Text(" - ₹70",
                              style: AppStyle.normal_14(AppColors.black20),
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                      Divider(color: AppColors.theme10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Payable Amount : ",
                              style: AppStyle.medium_16(AppColors.blackColor),
                              overflow: TextOverflow.ellipsis),
                          Text("₹70",
                              style: AppStyle.medium_16(AppColors.green),
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),


                    ],
                  ),
                ),

                SizedBox(height: size.height*0.01),

                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton3(onPressed: (){},txt: "Reject",bgColor: AppColors.redColor.withOpacity(0.8)),
                    CustomButton3(onPressed: (){},txt: "Approve",bgColor: AppColors.green)
                  ],)
              ],
            ),
          ),
        ],
      ),
    );
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

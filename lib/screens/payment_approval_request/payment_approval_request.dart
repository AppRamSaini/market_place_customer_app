import '../../utils/exports.dart';

Widget trackerData(
        {String? title,
        String? subTitle,
        Color? bgColor,
        required Color txtColor}) =>
    Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.018),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.grey50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title.toString(), style: AppStyle.normal_15(txtColor!)),
          const SizedBox(height: 5),
          Text(
            subTitle.toString(),
            textAlign: TextAlign.center,
            style: AppStyle.medium_12(AppColors.black20),
          ),
        ],
      ),
    );

import '../../utils/exports.dart';

Widget settingsWidget(
        {IconData? icon,
        Widget? trailingIcon,
        String? title,
        void Function()? onTap}) =>
    Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      color: AppColors.theme5,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.theme5.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5)),
            child: Icon(icon, color: AppColors.theme5.withOpacity(0.6))),
        title: Text(title.toString(),
            style: AppStyle.medium_16(AppColors.black20)),
        trailing: Icon(Icons.arrow_forward_ios_sharp,
            color: AppColors.black20.withOpacity(0.5), size: 20),
      ),
    );

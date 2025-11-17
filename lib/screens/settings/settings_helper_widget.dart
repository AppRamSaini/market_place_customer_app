import '../../utils/exports.dart';

/// Modern Settings Tile
Widget settingsTile({
  required String title,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: size.width * 0.022),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3))
      ],
    ),
    child: ListTile(
      onTap: onTap,
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
      leading: CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.themeColor.withOpacity(0.1),
          child: Icon(icon, color: AppColors.themeColor)),
      title: Text(title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded,
          color: Colors.black38, size: 18),
    ),
  );
}

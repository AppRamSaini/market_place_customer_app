import 'package:animate_do/animate_do.dart';

import '../../utils/exports.dart';

Future<bool?> showExitConfirmationSheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (ctx) {
      return SafeArea(
        child: GestureDetector(
          // tap outside to dismiss
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(ctx).pop(false),
          child: DraggableScrollableSheet(
            initialChildSize: 0.28,
            minChildSize: 0.18,
            maxChildSize: 0.6,
            builder: (_, controller) {
              return SlideInUp(
                duration: const Duration(milliseconds: 420),
                from: 60,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  // margin:
                  //     const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.whiteColor,
                        AppColors.background,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 15),
                      Container(
                          width: 48,
                          height: 4,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(6))),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Pulse(
                            infinite: false,
                            duration: const Duration(seconds: 2),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .error
                                    .withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.exit_to_app_rounded,
                                  size: 30, color: AppColors.red600),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Exit App",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Are you sure you want to exit? You can reopen the app anytime.",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(ctx).pop(false),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.whiteColor,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  elevation: 6,
                                  shadowColor: AppColors.background),
                              child: Text("Cancel",
                                  style:
                                      AppStyle.normal_16(AppColors.redColor)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(ctx).pop(true),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.whiteColor,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  elevation: 6,
                                  shadowColor: AppColors.background),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.exit_to_app_rounded,
                                      size: 18, color: AppColors.themeColor),
                                  const SizedBox(width: 8),
                                  Text("Exit",
                                      style: AppStyle.normal_16(
                                          AppColors.themeColor))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),
                      // small "swipe down" hint
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Swipe down to dismiss",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

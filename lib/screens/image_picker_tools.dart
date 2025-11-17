import 'package:market_place_customer/utils/exports.dart';

/// image picker bottom sheet
Future<File?> pickImageSheet(BuildContext context) async {
  final picker = ImagePicker();
  File? selectedImage;

  await showModalBottomSheet(
    context: context,
    barrierColor: Colors.black.withOpacity(0.4),
    backgroundColor: AppColors.whiteColor,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
    builder: (_) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Top Handle
            Container(
              width: 45,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 10),

            /// Title + Close
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Choose Image",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.close, size: 22),
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            /// Main options container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  /// Camera
                  InkWell(
                    onTap: () async {
                      final pickedFile = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 70);
                      if (pickedFile != null) {
                        selectedImage = File(pickedFile.path);
                      }
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Row(
                        children: [
                          _modernIcon(
                              Icons.camera_alt_rounded, Colors.blueAccent),
                          const SizedBox(width: 14),
                          const Text(
                            "Take Photo",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Divider(
                        indent: 16,
                        endIndent: 16,
                        height: 6,
                        color: Colors.grey.shade300),
                  ),

                  /// Gallery
                  InkWell(
                    onTap: () async {
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 75,
                      );
                      if (pickedFile != null) {
                        selectedImage = File(pickedFile.path);
                      }
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Row(
                        children: [
                          _modernIcon(
                            Icons.photo_library_rounded,
                            Colors.deepPurpleAccent,
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            "Choose from Gallery",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// Cancel Button
            Padding(
              padding: globalBottomPadding(context),
              child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CustomButtons.primary(
                      onPressed: () => Navigator.pop(context), text: "Cancel")),
            ),

            const SizedBox(height: 12),
          ],
        ),
      );
    },
  );

  return selectedImage;
}

/// Modern circular icon box
Widget _modernIcon(IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration:
        BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
    child: Icon(icon, color: color, size: 26),
  );
}

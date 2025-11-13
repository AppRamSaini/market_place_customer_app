import 'package:market_place_customer/utils/exports.dart';

/// UPLOAD DOCUMENTS UI
Widget uploadDocumentsWidget(
        {void Function()? onTap,
        void Function()? onRemove,
        String? txt,
        XFile? file,
        String? docImage}) =>
    DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      dashPattern: const [8, 2],
      color: AppColors.themeColor,
      strokeWidth: 1,
      child: SizedBox(
        width: size.width,
        height: size.height * 0.2,
        child: docImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                    fit: BoxFit.fill,
                    placeholder: const AssetImage(Assets.dummy),
                    image: docImage.isNotEmpty
                        ? NetworkImage(docImage)
                        : const AssetImage(Assets.dummy) as ImageProvider,
                    imageErrorBuilder: (_, child, st) =>
                        Image.asset(Assets.dummy, fit: BoxFit.cover)))
            : file != null
                ? Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(File(file.path),
                              fit: BoxFit.cover, width: size.width)),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: GestureDetector(
                                onTap: onRemove,
                                child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor:
                                        AppColors.redColor.withOpacity(0.5),
                                    child: Icon(Icons.clear,
                                        size: 20, color: AppColors.black20)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(txt.toString(),
                          style: AppStyle.normal_15(AppColors.black20)),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.theme10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(Assets.uploadIcon,
                                  height: 32, width: 32),
                              SizedBox(width: 10),
                              Text("Upload",
                                  style:
                                      AppStyle.semiBold_16(AppColors.themeColor)
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
      ),
    );

Future<XFile?> pickDocumentsWidget(BuildContext context) async {
  final Completer<XFile?> completer = Completer<XFile?>();

  final editProfileOptionList = ['Upload By Gallery', 'Take By Camera'];
  final editProfileOptionIconsList = [Icons.image_outlined, Icons.camera_alt];

  await showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    enableDrag: false,
    builder: (BuildContext context) {
      return Padding(
        padding: globalBottomPadding(context),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: editProfileOptionList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            XFile? pickedImage;
                            if (index == 0) {
                              pickedImage = await picker.pickImage(
                                  source: ImageSource.gallery);
                            } else {
                              pickedImage = await picker.pickImage(
                                  source: ImageSource.camera);
                            }

                            Navigator.pop(context);
                            completer.complete(pickedImage);
                          },
                          leading: Icon(
                            editProfileOptionIconsList[index],
                            color: AppColors.themeColor,
                          ),
                          title: Text(
                            editProfileOptionList[index],
                            style: AppStyle.medium_16(AppColors.black20),
                          ),
                        ),
                        index == editProfileOptionIconsList.length - 1
                            ? const SizedBox()
                            : Divider(color: Colors.grey[300]),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * 0.02),
              CustomButton3(
                onPressed: () {
                  Navigator.of(context).pop();
                  completer.complete(null); // cancel pressed → return null
                },
                txt: "CANCEL",
                minWidth: size.width,
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      );
    },
  );

  return completer.future;
}

/// IMAGE CROPER
// Future<CroppedFile?> cropAndCompressImage(File pickedImage) async {
//   final croppedFile = await ImageCropper().cropImage(
//     sourcePath: pickedImage.path,
//     compressFormat: ImageCompressFormat.jpg,
//     compressQuality: 100,
//     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//     uiSettings: [
//       AndroidUiSettings(
//           toolbarTitle: 'Cropper',
//           toolbarColor: AppColors.theme5,
//           toolbarWidgetColor: Colors.white,
//           aspectRatioPresets: [
//             CropAspectRatioPreset.original,
//             CropAspectRatioPreset.square,
//             CropAspectRatioPreset.ratio4x3
//           ],
//           lockAspectRatio: false,
//           hideBottomControls: true),
//       IOSUiSettings(
//           title: 'Cropper',
//           aspectRatioPresets: [
//             CropAspectRatioPreset.original,
//             CropAspectRatioPreset.square,
//             CropAspectRatioPreset.ratio4x3,
//           ],
//           aspectRatioLockEnabled: true,
//           resetButtonHidden: true)
//     ],
//   );
//
//   return croppedFile;
// }

/// image picker

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
                  child: CustomButton(
                      onPressed: () => Navigator.pop(context), txt: "Cancel")),
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

/// img url
Widget profilePickImage(String url) => FadeInImage(
      placeholder: AssetImage(Assets.dummy),
      image: NetworkImage(url ?? ''),
      imageErrorBuilder: (_, child, stack) => Image.asset(Assets.dummy,
          width: size.height * 0.1,
          height: size.height * 0.1,
          fit: BoxFit.cover),
      width: size.height * 0.1,
      height: size.height * 0.1,
      fit: BoxFit.cover,
    );

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
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
    builder: (_) => Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Select Option",
                  style: AppStyle.medium_18(AppColors.blackColor)),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.clear, color: AppColors.blackColor))
            ],
          ),
          customDivider(),
          const SizedBox(height: 10),
          Container(
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.grey30)),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      selectedImage = File(pickedFile.path);
                    }
                    Navigator.pop(context); // close sheet
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.camera_alt_outlined,
                          color: AppColors.blackColor),
                      const SizedBox(width: 10),
                      Text("Take By Camera",
                          style: AppStyle.normal_16(AppColors.blackColor)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Divider(color: AppColors.grey30),
                ),
                GestureDetector(
                  onTap: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      selectedImage = File(pickedFile.path);
                    }
                    Navigator.pop(context); // close sheet
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.image_outlined,
                          color: AppColors.blackColor),
                      const SizedBox(width: 10),
                      Text("Select From Gallery",
                          style: AppStyle.normal_16(AppColors.blackColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: CustomButton3(
              minWidth: size.width,
              onPressed: () => Navigator.pop(context),
              txt: "Cancel",
            ),
          ),
        ],
      ),
    ),
  );

  return selectedImage;
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

import 'package:market_place_customer/utils/exports.dart';
import 'package:image/image.dart' as img;
import 'dart:io';


Future<File?> compressUsingImagePackage(File file) async {
  EasyLoading.show(status: 'Loading...');
  final image = img.decodeImage(await file.readAsBytes());
  if (image == null) return null;
  final compressed = img.encodeJpg(image, quality: 50); // quality: 0-100
  final newPath =
      '${file.parent.path}/compressed_${file.uri.pathSegments.last}';
  final compressedFile = File(newPath)..writeAsBytesSync(compressed);
  EasyLoading.dismiss();
  return compressedFile;
}


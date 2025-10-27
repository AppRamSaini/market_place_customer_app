// import 'package:photo_view/photo_view.dart';
//
// import '../../utils/exports.dart';
//
// /// GALLERY VIEW
// class FullImageView extends StatelessWidget {
//  final  List imageList;
//   const FullImageView({super.key, required this.imageList});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//           leading: GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: SizedBox(
//               height: 20,
//               child: CircleAvatar(
//                   radius: 0,
//                   backgroundColor: AppColors.black20.withOpacity(0.1),
//                   child: const Icon(Icons.arrow_back_ios_new,
//                       size: 20, color: AppColors.whiteColor)),
//             ),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           iconTheme: const IconThemeData(color: Colors.white)),
//       body: Center(
//         child: PhotoView(
//           imageProvider: NetworkImage(imageUrl),
//           loadingBuilder: (_, event) => const Center(
//             child: CircularProgressIndicator(),
//           ),
//         ),
//       ),
//     );
//   }
// }

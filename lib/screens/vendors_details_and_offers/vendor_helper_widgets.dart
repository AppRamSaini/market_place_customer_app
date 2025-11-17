import '../../utils/exports.dart';

Widget buildMediaMessage(BuildContext context, List<String> imageList) {
  if ((imageList == null || imageList.isEmpty)) {
    return const SizedBox(); // Nothing to show
  }

  final mediaCount = imageList.length;

  return GridView.builder(
    shrinkWrap: true,
    padding: EdgeInsets.zero,
    physics: const BouncingScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 0),
    itemCount: mediaCount > 6 ? 6 : mediaCount,
    itemBuilder: (_, index) {
      final url = imageList[index] ?? '';
      final isLastAndMore = index == 5 && mediaCount > 6;
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              onTap: () => AppRouter().navigateTo(
                  context,
                  FullImageView(
                      imageList: imageList ?? [], initialIndex: index)),
              child: FadeInUp(
                duration: Duration(milliseconds: 300 + (index * 120)),
                child: FadeInImage(
                  height: size.height * 0.12,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  color: isLastAndMore ? Colors.black.withOpacity(0.4) : null,
                  colorBlendMode: isLastAndMore ? BlendMode.darken : null,
                  placeholder: const AssetImage(Assets.dummy),
                  image: url!.isNotEmpty
                      ? NetworkImage(url)
                      : const AssetImage(Assets.dummy) as ImageProvider,
                  imageErrorBuilder: (_, child, st) => Image.asset(
                    Assets.dummy,
                    height: size.height * 0.12,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ),
          if (isLastAndMore)
            Positioned.fill(
              child: Center(
                child: Text(
                  '+${mediaCount - 3}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      );
    },
  );
}

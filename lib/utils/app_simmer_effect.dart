import 'package:flutter_animate/flutter_animate.dart';
import 'package:market_place_customer/utils/exports.dart';

/// profile simmer effects
Widget profileSimmerLoading() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.03),
          Container(
              width: size.width,
              height: size.height * 0.12,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10))),
          SizedBox(height: size.height * 0.02),
          ...List.generate(15, (index) => shimmerListTile(size)),
        ],
      ),
    ),
  );
}

Widget shimmerListTile(Size size) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8))),
        SizedBox(width: 16),
        Expanded(
            child: Container(
                height: size.height * 0.05,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)))),
        SizedBox(width: 16),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ],
    ),
  );
}

/// dashboard page simmer effects\
class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

/// dashboard page simmer effects\
Widget dashboardSimmerLoading(BuildContext context,
    {bool forHomePage = false}) {
  final size = MediaQuery.of(context).size;

  return Scaffold(
    appBar: forHomePage
        ? MyCustomAppBar()
        : AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: CircleAvatar(radius: 20),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                shimmerText(width: 100, height: 16),
                SizedBox(height: 5),
                shimmerText(width: 80, height: 12),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: CircleAvatar(radius: 20),
                ),
              )
            ],
          ),
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.01),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(5),
              itemCount: 4,
              itemBuilder: (context, index) {
                double height =
                    index % 2 == 0 ? size.height * 0.12 : size.height * 0.08;
                return shimmerCard(height: height);
              },
            ),
            SizedBox(height: size.height * 0.02),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemBuilder: (_, __) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerButton(width: size.width * 0.8, height: 45),
                  SizedBox(height: size.height * 0.02),
                  shimmerText(width: 150, height: 16),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// notifications simmer

Widget notificationShimmerLoading() => ListView.separated(
    shrinkWrap: true,
    padding: const EdgeInsets.all(5),
    physics: NeverScrollableScrollPhysics(),
    itemCount: 10,
    separatorBuilder: (_, __) => SizedBox(height: 10),
    itemBuilder: (_, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmerButton(width: size.width * 0.9, height: 45),
            SizedBox(height: size.height * 0.02),
            shimmerText(width: 150, height: 16),
            SizedBox(height: 8),
          ],
        ));
Widget shimmerText({required double width, required double height}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}

Widget shimmerCard({required double height}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey,
      ),
    ),
  );
}

Widget shimmerButton({required double width, required double height}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

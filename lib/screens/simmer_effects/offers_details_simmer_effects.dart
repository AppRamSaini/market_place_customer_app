import '../../utils/exports.dart';

class BurgerKingShimmer extends StatelessWidget {
  const BurgerKingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                    height: size.height * 0.2,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                        shape: BoxShape.rectangle)),
                const SizedBox(height: 20),

                // Logo + Text
                Row(
                  children: [
                    Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                            color: Colors.grey, shape: BoxShape.circle)),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 16,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 14,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Repeated text rows
                for (int i = 0; i < 5; i++) ...[
                  Container(
                    height: 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  const SizedBox(height: 10),
                ],

                const SizedBox(height: 15),

                // Total amount card
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                // Bottom 3 stats boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    return Expanded(
                      child: Container(
                        height: 70,
                        margin: index == 1
                            ? EdgeInsets.symmetric(horizontal: 12)
                            : null,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),

                // Repeated text rows
                for (int i = 0; i < 5; i++) ...[
                  Container(
                      height: 12, width: double.infinity, color: Colors.grey),
                  const SizedBox(height: 10),
                ],

                const SizedBox(height: 10),

                // Bottom 3 stats boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    return Flexible(
                      child: Container(
                        height: 70,
                        margin: index == 1
                            ? const EdgeInsets.symmetric(horizontal: 8)
                            : null,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

      ),
    );
  }
}

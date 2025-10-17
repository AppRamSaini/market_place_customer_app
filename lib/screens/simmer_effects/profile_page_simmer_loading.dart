import '../../utils/exports.dart';

class ShimmerScreen extends StatelessWidget {
  const ShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade900,
        highlightColor: Colors.grey.shade800,
        direction: ShimmerDirection.ttb,
        period: const Duration(milliseconds: 2000),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Placeholder
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 20),

              // Title line
              Container(
                height: 20,
                width: 220,
                color: Colors.grey[900],
              ),
              const SizedBox(height: 10),

              // Subtitle line
              Container(
                height: 16,
                width: 120,
                color: Colors.grey[900],
              ),
              const SizedBox(height: 10),

              // Long text
              Container(
                height: 16,
                width: double.infinity,
                color: Colors.grey[900],
              ),
              const SizedBox(height: 10),
              // Small line
              Container(
                height: 16,
                width: 100,
                color: Colors.grey[900],
              ),
              const SizedBox(height: 20),
              // 4 Rounded Buttons Row
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(4, (index) {
                  return Container(
                    height: 60,
                    width: (MediaQuery.of(context).size.width - 52) / 2,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Divider
              Container(
                  height: 1, width: double.infinity, color: Colors.grey[900]),
              const SizedBox(height: 20),

              // Small lines row
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 40,
                    color: Colors.grey[900],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 40,
                    color: Colors.grey[900],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 40,
                    color: Colors.grey[900],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Another text line
              Container(height: 20, width: 180, color: Colors.grey[900]),
              const SizedBox(height: 10),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey[900],
              ),
              const SizedBox(height: 20),

              // Small lines row
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 40,
                    color: Colors.grey[900],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 40,
                    color: Colors.grey[900],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 40,
                    color: Colors.grey[900],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Another text line
              Container(height: 20, width: 180, color: Colors.grey[900]),
              const SizedBox(height: 10),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey[900],
              ),
              const SizedBox(height: 20),

              // Small lines row
              Container(height: 20, width: 120, color: Colors.grey[900]),
              const SizedBox(height: 10),
              Container(height: 20, width: 180, color: Colors.grey[900]),
              const SizedBox(height: 10),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey[900],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
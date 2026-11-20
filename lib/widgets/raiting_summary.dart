import 'package:material_ui/material_ui.dart';

import '../providers/reviews_provider.dart';
import 'star_rating.dart';

class RaitingSummary extends StatelessWidget {
  final ReviewsProvider provider;
  final int productId;

  const RaitingSummary({
    super.key,
    required this.provider,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final average = provider.average(productId);
    final total = provider.totalFor(productId);
    final distribution = provider.distribution(productId);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Text(
                average.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StarRating(rating: average),
              const SizedBox(height: 4),
              Text('$total reseñas'),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Column(
            children: List.generate(5, (index) {
              final stars = 5 - index;
              final count = distribution[stars] ?? 0;
              final fraction = total == 0 ? 0.0 : count / total;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    SizedBox(width: 18, child: Text('$stars')),
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 6),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: fraction,
                        minHeight: 7,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(width: 24, child: Text('$count')),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

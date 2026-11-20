import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

import '../models/review.dart';
import 'star_rating.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  final VoidCallback onUseful;

  const ReviewCard({super.key, required this.review, required this.onUseful});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMd('es').format(review.fecha);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(
                    review.autor.isEmpty
                        ? '?'
                        : review.autor.trim()[0].toUpperCase(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.autor,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(date, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                StarRating(rating: review.rating.toDouble(), size: 16),
              ],
            ),
            if (review.titulo.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                review.titulo,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
            if (review.comentario.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(review.comentario),
            ],
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: onUseful,
              icon: const Icon(Icons.thumb_up_outlined, size: 18),
              label: Text('Útil (${review.utiles})'),
            ),
          ],
        ),
      ),
    );
  }
}

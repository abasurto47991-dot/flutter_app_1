import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/reviews_provider.dart';
import '../widgets/raiting_summary.dart';
import '../widgets/review_card.dart';
import '../widgets/review_form.dart';

class ReviewsScreen extends StatelessWidget {
  final Product product;

  const ReviewsScreen({super.key, required this.product});

  void _openForm(BuildContext context) {
    final reviews = context.read<ReviewsProvider>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => ReviewForm(
        productId: product.id,
        onSubmit: (review) async {
          await reviews.addReview(review);
          if (sheetContext.mounted) Navigator.pop(sheetContext);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewsProvider>(
      builder: (context, reviews, _) {
        final productReviews = reviews.reviewsFor(product.id);
        return Scaffold(
          appBar: AppBar(title: const Text('Reseñas')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              RaitingSummary(provider: reviews, productId: product.id),
              const SizedBox(height: 16),
              if (productReviews.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Todavía no hay reseñas. ¡Sé el primero en escribir una!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                ...productReviews.map(
                  (review) => ReviewCard(
                    review: review,
                    onUseful: () => reviews.toggleUseful(product.id, review.id),
                  ),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openForm(context),
            icon: const Icon(Icons.rate_review),
            label: const Text('Escribir reseña'),
          ),
        );
      },
    );
  }
}

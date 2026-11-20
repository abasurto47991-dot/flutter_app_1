import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/reviews_provider.dart';
import '../widgets/star_rating.dart';
import 'reviews_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final reviews = context.watch<ReviewsProvider>();
    final promedio = reviews.promedio(product.id);
    final total = reviews.totalDe(product.id);

    return Scaffold(
      appBar: AppBar(title: Text(product.category)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 220,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                StarRating(rating: promedio),
                const SizedBox(width: 6),
                Text(
                  total == 0
                      ? 'Aún sin reseñas'
                      : '${promedio.toStringAsFixed(1)} ($total reseñas)',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(product.description),
            const Divider(height: 32),
            const Text(
              'Reseñas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReviewsScreen(product: product),
                  ),
                ),
                icon: const Icon(Icons.rate_review),
                label: Text(
                  total == 0
                      ? 'Escribir la primera reseña'
                      : 'Ver y escribir reseñas',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

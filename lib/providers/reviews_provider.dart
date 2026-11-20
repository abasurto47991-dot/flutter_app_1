import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/review.dart';

class ReviewsProvider extends ChangeNotifier {
  static const _key = 'resenas';

  final Map<int, List<Review>> _reviews = {};

  List<Review> reviewsFor(int productId) =>
      List<Review>.unmodifiable(_reviews[productId] ?? const []);

  int totalFor(int productId) => reviewsFor(productId).length;

  double average(int productId) {
    final reviews = reviewsFor(productId);
    if (reviews.isEmpty) return 0;
    final sum = reviews.fold<int>(0, (total, review) => total + review.rating);
    return sum / reviews.length;
  }

  Map<int, int> distribution(int productId) {
    final result = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (final review in reviewsFor(productId)) {
      if (review.rating >= 1 && review.rating <= 5) {
        result[review.rating] = result[review.rating]! + 1;
      }
    }
    return result;
  }

  List<Review> resenasDe(int productId) => reviewsFor(productId);
  int totalDe(int productId) => totalFor(productId);
  double promedio(int productId) => average(productId);
  Map<int, int> distribucion(int productId) => distribution(productId);

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString(_key);
    if (text == null) return;

    try {
      final decoded = jsonDecode(text);
      if (decoded is! Map) return;
      _reviews.clear();
      for (final entry in decoded.entries) {
        final productId = int.tryParse(entry.key.toString());
        if (productId == null || entry.value is! List) continue;
        _reviews[productId] = (entry.value as List)
            .whereType<Map>()
            .map((review) => Review.fromJson(Map<String, dynamic>.from(review)))
            .toList();
      }
      notifyListeners();
    } on FormatException {
      await prefs.remove(_key);
    }
  }

  Future<void> addReview(Review review) async {
    _reviews.putIfAbsent(review.productId, () => []);
    _reviews[review.productId]!.insert(0, review);
    notifyListeners();
    await _save();
  }

  Future<void> agregarResena(Review review) => addReview(review);

  Future<void> toggleUseful(int productId, String reviewId) async {
    final reviews = _reviews[productId];
    if (reviews == null) return;
    final index = reviews.indexWhere((review) => review.id == reviewId);
    if (index == -1) return;
    reviews[index] = reviews[index].copyWith(utiles: reviews[index].utiles + 1);
    notifyListeners();
    await _save();
  }

  Future<void> toggleUtil(int productId, String reviewId) =>
      toggleUseful(productId, reviewId);

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _reviews.map(
      (id, reviews) => MapEntry(
        id.toString(),
        reviews.map((review) => review.toJson()).toList(),
      ),
    );
    await prefs.setString(_key, jsonEncode(data));
  }
}

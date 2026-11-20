import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService {
  static const _url = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode != 200) {
      throw Exception('Error ${response.statusCode} al cargar productos');
    }
    final List data = jsonDecode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  }
}

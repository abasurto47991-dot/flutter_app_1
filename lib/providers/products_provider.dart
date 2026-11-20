import 'package:material_ui/material_ui.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class ProductsProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<Product> _productos = [];
  bool _cargando = false;
  String? _error;

  List<Product> get productos => _productos;
  bool get cargando => _cargando;
  String? get error => _error;

  Future<void> cargarProductos() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      _productos = await _service.fetchProducts();
    } catch (e) {
      _error = 'No se pudieron cargar los productos. Revisa tu conexión.';
    }

    _cargando = false;
    notifyListeners();
  }
}

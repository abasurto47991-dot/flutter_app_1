import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'providers/products_provider.dart';
import 'providers/reviews_provider.dart';
import 'screens/products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsProvider()..cargarProductos(),
        ),
        ChangeNotifierProvider(create: (_) => ReviewsProvider()..init()),
      ],
      child: MaterialApp(
        title: 'Reseñas de productos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
        home: const ProductsScreen(),
      ),
    );
  }
}

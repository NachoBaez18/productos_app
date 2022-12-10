import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productServices = Provider.of<ProductService>(context);
    final authServices = Provider.of<AuthService>(context, listen: false);

    final products = productServices.products;

    if (productServices.isLoading) return LoadingScreenn();
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        leading: IconButton(
          onPressed: () {
            authServices.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: const Icon(Icons.login_outlined),
        ),
      ),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int i) => GestureDetector(
              onTap: () {
                productServices.selectedProduct =
                    productServices.products[i].copy();
                Navigator.pushNamed(context, 'productEdit');
              },
              child: ProductCard(
                product: products[i],
              ))),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            productServices.selectedProduct =
                new Product(available: false, name: '', price: 0);
            Navigator.pushNamed(context, 'productEdit');
          }),
    );
  }
}

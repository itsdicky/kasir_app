import 'package:flutter/material.dart';
import 'package:kasir_app/features/product/model/product.dart';
import 'package:kasir_app/features/product/view_model/cart_view_model.dart';
import 'package:kasir_app/features/product/view_model/list_product_view_model.dart';
import 'package:provider/provider.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget(this.product, {super.key});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100, child: Image.network(product.pictureUrl!)),
          SizedBox(height: 10),
          Text(product.name),
          SizedBox(height: 5),
          Text('\Rp.${product.price}'),
          FilledButton(
            onPressed: () {
              Provider.of<CartViewModel>(
                context,
                listen: false,
              ).addToCart(product);
            },
            child: Text('Tambah'),
          ),
          OutlinedButton(
            onPressed: () {
              Provider.of<ListProductViewModel>(
                context,
                listen: false,
              ).deleteProduct(product);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}

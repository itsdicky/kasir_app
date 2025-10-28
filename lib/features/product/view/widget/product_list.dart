import 'package:flutter/material.dart';
import 'package:kasir_app/features/product/view/widget/product_item_widget.dart';
import 'package:kasir_app/features/product/view_model/list_product_view_model.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ListProductViewModel>(
        builder: (_, model, __) {
          final products = model.filteredProduct;
          if (products.isEmpty) {
            return Center(child: Text('Tidak ada produk tersedia'));
          }
          if (model.status == Status.loading) {
            return Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductItemWidget(product);
              },
            ),
            onRefresh: () async {
              await model.fetchProducts();
            },
          );
        },
      ),
    );
  }
}

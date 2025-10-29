import 'package:flutter/material.dart';
import 'package:kasir_app/core/utils/string_utils.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(8),
                  child: Image.network(
                    product.pictureUrl!,
                    fit: BoxFit.cover,
                    height: 120,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton.filledTonal(
                    onPressed: () {
                      _showDeleteConfirmation(context);
                    },
                    icon: Icon(Icons.delete_outline),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(StringUtils.priceFormatter(product.price)),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Provider.of<CartViewModel>(
                    context,
                    listen: false,
                  ).addToCart(product);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
                child: Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.add), Text('Tambah')],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Yakin ingin menghapus "${product.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      Provider.of<ListProductViewModel>(
        context,
        listen: false,
      ).deleteProduct(product);
    }
  }
}

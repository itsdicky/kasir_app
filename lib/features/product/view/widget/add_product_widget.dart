import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';
import 'package:kasir_app/features/product/service/product/product_service.dart';
import 'package:kasir_app/features/product/view_model/add_product_view_model.dart';
import 'package:provider/provider.dart';

class AddProductWidget extends StatelessWidget {
  AddProductWidget({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddProductViewModel>(
      create: (_) => AddProductViewModel(
        Provider.of<ProductService>(context, listen: false),
        Provider.of<CategoryService>(context, listen: false),
      ),
      child: Consumer<AddProductViewModel>(
        builder: (context, model, child) {
          switch (model.status) {
            case Status.undefined:
              return Column(
                children: [
                  TextField(controller: controller),
                  FilledButton(
                    onPressed: () {
                      model.addProduct(
                        'name',
                        200,
                        Category(name: 'cat'),
                        File(''),
                      );
                    },
                    child: Text('Tambah'),
                  ),
                ],
              );
            case Status.success:
              return _success();
            case Status.failed:
              return _failed();
          }
        },
      ),
    );
  }

  Widget _success() {
    return Column(
      children: [
        Icon(Icons.check_box),
        Text('Selamat, tambah produk telah berhasil'),
      ],
    );
  }

  Widget _failed() {
    return Column(
      children: [
        Icon(Icons.check_box),
        Text('Terjadi kesalahan saat menambahkan produk'),
      ],
    );
  }
}

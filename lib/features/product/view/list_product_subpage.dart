import 'package:flutter/material.dart';
import 'package:kasir_app/core/common/widget/search_textfield.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';
import 'package:kasir_app/features/product/service/product/product_service.dart';
import 'package:kasir_app/features/product/view/widget/category_tab.dart';
import 'package:kasir_app/features/product/view/widget/product_list.dart';
import 'package:kasir_app/features/product/view_model/list_product_view_model.dart';
import 'package:provider/provider.dart';

class ListProductSubpage extends StatelessWidget {
  const ListProductSubpage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListProductViewModel>(
      create: (_) => ListProductViewModel(
        Provider.of<ProductService>(context, listen: false),
        Provider.of<CategoryService>(context, listen: false),
      ),
      child: Column(
        children: [
          SearchTextfield(action: (text) {}),
          CategoryTab(),
          ProductList(),
        ],
      ),
    );
  }
}

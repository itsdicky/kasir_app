import 'package:flutter/material.dart';
import 'package:kasir_app/core/common/widget/search_textfield.dart';
import 'package:kasir_app/features/product/view/widget/product_list.dart';
import 'package:kasir_app/features/user/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class ListProductSubpage extends StatelessWidget {
  const ListProductSubpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchTextfield(action: (text) {}),
        ProductList(),
      ],
    );
  }
}

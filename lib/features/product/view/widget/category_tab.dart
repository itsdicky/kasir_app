import 'package:flutter/material.dart';
import 'package:kasir_app/core/common/widget/tab_chips_widget.dart';
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/view_model/list_product_view_model.dart';
import 'package:provider/provider.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Consumer<ListProductViewModel>(
        builder: (_, model, __) {
          final categories = model.categories;
          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              TabChipsWidget(
                title: 'Semua',
                action: () {
                  model.setCategory(null);
                  print(model.selectedCategory.toString());
                },
              ),
              ...categories.map((category) {
                return TabChipsWidget(
                  title: category.name,
                  action: () {
                    model.setCategory(category);
                    print(model.selectedCategory.toString());
                  },
                );
              }),
            ],
          );
        },
      ),
    );
  }

  // Widget test() {
  //   return ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemBuilder: (context, index) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //         child: ActionChip(
  //           label: Text(categories[index].name),
  //           onPressed: () {
  //             model.setCategory(categories[index]);
  //             print(model.selectedCategory.toString());
  //           },
  //         ),
  //       );
  //     },
  //     itemCount: categories.length,
  //   );
  // }
}

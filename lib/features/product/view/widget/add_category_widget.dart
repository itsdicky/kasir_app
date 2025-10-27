import 'package:flutter/material.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';
import 'package:kasir_app/features/product/view_model/add_category_view_model.dart';
import 'package:provider/provider.dart';

class AddCategoryWidget extends StatelessWidget {
  AddCategoryWidget({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddCategoryViewModel>(
      create: (_) => AddCategoryViewModel(
        Provider.of<CategoryService>(context, listen: false),
      ),
      child: Consumer<AddCategoryViewModel>(
        builder: (context, model, child) {
          switch (model.status) {
            case Status.undefined:
              return Column(
                spacing: 16,
                children: [
                  TextField(controller: controller),
                  FilledButton(
                    onPressed: () {
                      model.addCategory(controller.text);
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
        Text('Selamat, tambah kategori telah berhasil'),
      ],
    );
  }

  Widget _failed() {
    return Column(
      children: [
        Icon(Icons.check_box),
        Text('Terjadi kesalahan saat menambahkan kategori'),
      ],
    );
  }
}

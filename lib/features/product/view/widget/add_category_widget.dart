import 'package:flutter/material.dart';
import 'package:kasir_app/core/common/widget/textfield_widget.dart';
import 'package:kasir_app/core/config/theme/widget_style.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';
import 'package:kasir_app/features/product/view_model/add_category_view_model.dart';
import 'package:provider/provider.dart';

class AddCategoryWidget extends StatelessWidget {
  AddCategoryWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tambah Kategori',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextfieldWidget(
                      title: 'Nama',
                      hintText: 'Masukan nama kategori',
                      controller: controller,
                    ),
                    Row(
                      spacing: 16,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: WidgetStyle.outlinedButtonStyle(),
                            child: Text('Batal'),
                          ),
                        ),
                        Flexible(
                          child: FilledButton(
                            onPressed: () {
                              model.addCategory(controller.text);
                            },
                            style: WidgetStyle.filledButtonStyle(),
                            child: Text('Tambah'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            case Status.loading:
              return Center(child: CircularProgressIndicator());
            case Status.success:
              return _success(context);
            case Status.failed:
              return _failed(context);
          }
        },
      ),
    );
  }

  Widget _success(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        spacing: 16,
        children: [
          Image.asset('assets/images/success.png', height: 120),
          Column(
            children: [
              Text(
                'Yeay, Berhasil!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                'Produk kamu sudah masuk daftar! Yuk, tambahin lagi.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            spacing: 16,
            children: [
              Flexible(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: WidgetStyle.outlinedButtonStyle(),
                  child: Text('Kembali'),
                ),
              ),
              Flexible(
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: WidgetStyle.filledButtonStyle(),
                  child: Text('Tambah'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _failed(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        spacing: 16,
        children: [
          Image.asset('assets/images/success.png', height: 120),
          Column(
            children: [
              Text(
                'Gagal!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                'Terjadi kesalahan saat menambahkan kategori.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            spacing: 16,
            children: [
              Flexible(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: WidgetStyle.outlinedButtonStyle(),
                  child: Text('Kembali'),
                ),
              ),
              Flexible(
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: WidgetStyle.filledButtonStyle(),
                  child: Text('Tambah'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

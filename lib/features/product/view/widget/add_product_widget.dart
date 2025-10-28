import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasir_app/core/common/widget/dropdown_widget.dart';
import 'package:kasir_app/core/common/widget/image_picker_widget.dart';
import 'package:kasir_app/core/common/widget/textfield_widget.dart';
import 'package:kasir_app/core/config/theme/widget_style.dart';
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';
import 'package:kasir_app/features/product/service/product/product_service.dart';
import 'package:kasir_app/features/product/view_model/add_product_view_model.dart';
import 'package:kasir_app/features/product/view_model/list_product_view_model.dart'
    hide Status;
import 'package:provider/provider.dart';

class AddProductWidget extends StatefulWidget {
  const AddProductWidget({super.key});

  @override
  State<AddProductWidget> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  Category? _selectedCategory;
  File? _productImage;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddProductViewModel>(
      create: (_) => AddProductViewModel(
        Provider.of<ProductService>(context, listen: false),
        Provider.of<CategoryService>(context, listen: false),
        Provider.of<ListProductViewModel>(context, listen: false),
      ),
      child: Consumer<AddProductViewModel>(
        builder: (context, model, child) {
          switch (model.status) {
            case Status.undefined:
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tambah Produk',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),
                      ImagePickerWidget(
                        title: 'Gambar Produk',
                        documentImage: _productImage,
                        onTap: () {
                          picker.pickImage(source: ImageSource.gallery).then((
                            value,
                          ) {
                            if (value != null) {
                              setState(() {
                                _productImage = File(value.path);
                              });
                            }
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      TextfieldWidget(
                        title: 'Nama',
                        hintText: 'Masukkan nama produk',
                        controller: _nameController,
                        isRequired: true,
                      ),
                      TextfieldWidget(
                        title: 'Harga',
                        hintText: 'Masukkan harga produk',
                        keyboardType: TextInputType.number,
                        controller: _priceController,
                        isRequired: true,
                      ),
                      DropdownWidget(
                        title: 'Kategori',
                        items: model.categories,
                        textBuilder: (category) => category!.name,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      SizedBox(height: 48),
                      Row(
                        spacing: 16,
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
                                if (_formKey.currentState!.validate() &&
                                    _selectedCategory != null &&
                                    _productImage != null) {
                                  model.addProduct(
                                    _nameController.text,
                                    int.parse(_priceController.text),
                                    _selectedCategory!,
                                    _productImage!,
                                  );
                                }
                              },
                              style: WidgetStyle.filledButtonStyle(),
                              child: Text('Tambah'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasir_app/core/common/widget/image_picker_widget.dart';
import 'package:kasir_app/features/product/model/category.dart';
import 'package:kasir_app/features/product/service/category/category_service.dart';
import 'package:kasir_app/features/product/service/product/product_service.dart';
import 'package:kasir_app/features/product/view_model/add_product_view_model.dart';
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
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tambah Produk'),
                      ImagePickerWidget(
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
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama produk harus diisi';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _priceController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harga produk harus diisi';
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField<Category>(
                        style: Theme.of(context).textTheme.bodyLarge,
                        items: List.generate(model.categories.length, (index) {
                          return DropdownMenuItem<Category>(
                            value: model.categories[index],
                            child: Text(
                              model.categories[index].name,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        dropdownColor: Colors.white,
                        validator: (value) {
                          if (value == null) {
                            return 'Kategori harus diisi';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Batal'),
                          ),
                          FilledButton(
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
                            child: Text('Tambah'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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

import 'package:flutter/material.dart';
import 'package:kasir_app/core/config/routes.dart';
import 'package:kasir_app/core/config/theme/widget_style.dart';
import 'package:kasir_app/features/product/view/list_product_subpage.dart';
import 'package:kasir_app/features/product/view/widget/add_category_widget.dart';
import 'package:kasir_app/features/product/view/widget/add_product_widget.dart';
import 'package:kasir_app/features/product/view_model/cart_view_model.dart';
import 'package:kasir_app/features/user/view/profile_subpage.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_selectedIndex == 0)
          ? AppBar(
              scrolledUnderElevation: 0.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                'MASPOS',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  icon: Consumer<CartViewModel>(
                    builder: (_, model, child) {
                      if (model.cartList.isEmpty) {
                        return child!;
                      }
                      return Badge(
                        isLabelVisible: true,
                        label: Text(model.cartList.length.toString()),
                        offset: const Offset(8, 8),
                        backgroundColor: Theme.of(context).colorScheme.error,
                        child: child!,
                      );
                    },
                    child: Icon(Icons.shopping_cart_outlined),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/profile_placeholder.png',
                  ),
                ),
                SizedBox(width: 16),
              ],
            )
          : null,
      body: Builder(
        builder: (context) {
          switch (_selectedIndex) {
            case 0:
              return ListProductSubpage();
            case 2:
              return ProfileSubpage();
            default:
              return ErrorPage();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onTap: (index) {
          if (index == 1) {
            _showMyBottomSheet(context);
            return;
          }
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
            tooltip: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_outlined),
            activeIcon: Icon(Icons.add),
            label: 'Tambah',
            tooltip: 'Tambah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
            tooltip: 'Profil',
          ),
        ],
      ),
    );
  }

  void _showMyBottomSheet(BuildContext context) {
    AddType addType = AddType.undefined;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 28,
            ),
            child: SingleChildScrollView(
              child: StatefulBuilder(
                builder: (context, setSheetState) {
                  switch (addType) {
                    case AddType.category:
                      return AddCategoryWidget();
                    case AddType.product:
                      return AddProductWidget();
                    default:
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Row(
                          spacing: 16,
                          children: [
                            Flexible(
                              child: OutlinedButton(
                                onPressed: () {
                                  setSheetState(() {
                                    addType = AddType.category;
                                  });
                                },
                                style: WidgetStyle.outlinedButtonStyle(
                                  height: 100,
                                ),
                                child: Column(
                                  spacing: 8,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.add_outlined, size: 28),
                                        SizedBox(width: 8),
                                        Text(
                                          'Kategori',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Buat menu produk lebih rapi',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: OutlinedButton(
                                onPressed: () {
                                  setSheetState(() {
                                    addType = AddType.product;
                                  });
                                },
                                style: WidgetStyle.outlinedButtonStyle(
                                  height: 100,
                                ),
                                child: Column(
                                  spacing: 8,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.add_outlined, size: 28),
                                        SizedBox(width: 8),
                                        Text(
                                          'Produk',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Tambahin makanan atau minuman baru',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

enum AddType { product, category, undefined }

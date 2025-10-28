import 'package:flutter/material.dart';
import 'package:kasir_app/core/utils/string_utils.dart';
import 'package:kasir_app/features/product/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Pesanan')),
      body: Consumer<CartViewModel>(
        builder: (context, cartViewModel, child) {
          final cartItems = cartViewModel.cartList;
          return Column(
            children: [
              Expanded(
                child: (cartItems.isEmpty)
                    ? Center(child: Text('Keranjang kosong'))
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems.keys.elementAt(index);
                          final quantity = cartItems.values.elementAt(index);
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.pictureUrl!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              item.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              'Total: ${StringUtils.priceFormatter(item.price * quantity)}',
                            ),
                            trailing: SizedBox(
                              width: 120, // make the trailing area larger
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,

                                        icon: Icon(
                                          (cartViewModel.cartList[item]! > 1)
                                              ? Icons.remove
                                              : Icons.delete_outline,
                                          size: 20,
                                        ), // smaller icon
                                        onPressed: () {
                                          cartViewModel.removeFromCart(item);
                                        },
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        quantity.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      IconButton(
                                        padding: EdgeInsets.zero,

                                        icon: Icon(
                                          Icons.add,
                                          size: 20,
                                        ), // smaller icon
                                        onPressed: () {
                                          cartViewModel.addToCart(item);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () => _showMyBottomSheet(context),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, -4), // shadow on top
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (cartViewModel.paymentMethod ==
                                    PaymentMethod.undefined)
                                ? 'Pilih Metode Pembayaran'
                                : (cartViewModel.paymentMethod ==
                                      PaymentMethod.cash)
                                ? 'Tunai'
                                : 'QRIS',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.chevron_right_outlined),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 0),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Icon(Icons.shopping_cart_outlined),
                                ),
                                VerticalDivider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total tagihan',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      StringUtils.priceFormatter(
                                        cartViewModel.totalPrice,
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        FilledButton(
                          onPressed: () {
                            if (cartViewModel.paymentMethod ==
                                PaymentMethod.undefined) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Pilih metode pembayaran terlebih dahulu',
                                  ),
                                ),
                              );
                              return;
                            }
                            Navigator.of(context).pushNamed('/payment');
                          },
                          style: FilledButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 32,
                            ),
                          ),
                          child: Text('Bayar'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _showMyBottomSheet(BuildContext context) {
    final model = Provider.of<CartViewModel>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: ListView(
              padding: EdgeInsets.only(top: 20),
              children: [
                RadioListTile<PaymentMethod>(
                  value: PaymentMethod.cash,
                  groupValue: model.paymentMethod,
                  title: Text('Tunai'),
                  onChanged: (value) {
                    model.changePaymentMethod(value!);
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile<PaymentMethod>(
                  value: PaymentMethod.qris,
                  groupValue: model.paymentMethod,
                  title: Text('QRIS'),
                  onChanged: (value) {
                    model.changePaymentMethod(value!);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

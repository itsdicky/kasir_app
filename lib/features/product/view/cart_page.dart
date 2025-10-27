import 'package:flutter/material.dart';
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
                            title: Text(item.name),
                            subtitle: Text('Jumlah: ${quantity}'),
                            trailing: Text('Total: \$${item.price * quantity}'),
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
                      decoration: BoxDecoration(color: Colors.blue),
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.payment, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.shopping_cart_outlined),
                                Column(
                                  children: [
                                    Text('Total tagihan'),
                                    Text(cartViewModel.totalPrice.toString()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/payment');
                          },
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

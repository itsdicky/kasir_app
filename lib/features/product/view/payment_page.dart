import 'package:flutter/material.dart';
import 'package:kasir_app/core/utils/datetime_utils.dart';
import 'package:kasir_app/core/utils/string_utils.dart';
import 'package:kasir_app/features/product/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: const Text('Pembayaran'),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Consumer<CartViewModel>(
        builder: (_, model, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/qr_code.png'),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(vertical: 24, horizontal: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(DatetimeUtils.fromDateTimeToString(DateTime.now())!),
                    Divider(),
                    Text(
                      'Total Pembayaran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      StringUtils.priceFormatter(model.totalPrice),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

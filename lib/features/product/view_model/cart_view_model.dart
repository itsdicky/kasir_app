import 'package:flutter/foundation.dart';
import 'package:kasir_app/features/product/model/product.dart';

enum PaymentMethod { cash, qris, undefined }

class CartViewModel extends ChangeNotifier {
  CartViewModel();

  final Map<Product, int> _cartList = {};
  Map<Product, int> get cartList => _cartList;

  PaymentMethod _paymentMethod = PaymentMethod.undefined;
  PaymentMethod get paymentMethod => _paymentMethod;

  //TODO: test
  int get totalPrice => {
    for (var entry in _cartList.entries) entry.key.price * entry.value,
  }.fold(0, (prev, element) => prev + element);

  void addToCart(Product product) {
    if (_cartList.containsKey(product)) {
      _cartList[product] = _cartList[product]! + 1;
    } else {
      _cartList[product] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (_cartList.containsKey(product)) {
      if (_cartList[product]! > 1) {
        _cartList[product] = _cartList[product]! - 1;
      } else {
        _cartList.remove(product);
      }
      notifyListeners();
    }
  }

  void changePaymentMethod(PaymentMethod method) {
    _paymentMethod = method;
    notifyListeners();
  }
}

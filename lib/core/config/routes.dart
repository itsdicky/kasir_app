import 'package:flutter/material.dart';
import 'package:kasir_app/features/dashboard/view/main_page.dart';
import 'package:kasir_app/features/product/view/cart_page.dart';
import 'package:kasir_app/features/product/view/payment_page.dart';
import 'package:kasir_app/features/user/view/login_page.dart';

class Routes {
  static Route<dynamic> generate(RouteSettings settings) {
    final List<dynamic> args = ((settings.arguments ?? []) as List<dynamic>);
    switch (settings.name) {
      case '/main':
        return materialBuilder(widget: const MainPage());
      case '/login':
        return materialBuilder(widget: const LoginPage());
      case '/cart':
        return materialBuilder(widget: const CartPage());
      case '/payment':
        return materialBuilder(widget: const PaymentPage());
      default:
        return materialBuilder(widget: const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("error")),
      body: const Center(child: Text("error")),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}

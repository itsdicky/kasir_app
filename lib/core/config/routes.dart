import 'package:flutter/material.dart';
import 'package:kasir_app/features/dashboard/view/main_page.dart';
import 'package:kasir_app/features/user/view/login_page.dart';

class Routes {
  static Route<dynamic> generate(RouteSettings settings) {
    final List<dynamic> args = ((settings.arguments ?? []) as List<dynamic>);
    switch (settings.name) {
      case '/main':
        return materialBuilder(widget: const MainPage());
      case '/login':
        return materialBuilder(widget: const LoginPage());
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

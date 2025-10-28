import 'package:flutter/material.dart';
import 'package:kasir_app/core/common/page/loading_page.dart';
import 'package:kasir_app/core/config/providers_di.dart';
import 'package:kasir_app/core/config/routes.dart';
import 'package:kasir_app/core/config/theme/theme_style.dart';
import 'package:kasir_app/features/dashboard/view/main_page.dart';
import 'package:kasir_app/features/user/view/login_page.dart';
import 'package:kasir_app/features/user/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProvidersDi.init();
  await Future.delayed(const Duration(seconds: 2));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProvidersDi.providers,
      child: MaterialApp(
        title: 'Mas.POS',
        debugShowCheckedModeBanner: false,
        theme: ThemeStyle.lightTheme,
        themeMode: ThemeMode.light,
        onGenerateRoute: Routes.generate,
        initialRoute: '/',
        routes: {'/': (context) => _initialPage(context)},
      ),
    );
  }

  Widget _initialPage(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, model, _) {
        if (model.isLoggedIn == null) {
          return LoadingPage();
        }
        if (model.isLoggedIn!) {
          return MainPage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}

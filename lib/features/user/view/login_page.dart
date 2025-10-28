import 'package:flutter/material.dart';
import 'package:kasir_app/core/common/widget/textfield_widget.dart';
import 'package:kasir_app/core/config/theme/widget_style.dart';
import 'package:kasir_app/features/user/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Image.asset(
        'assets/images/display_background.png',
        fit: BoxFit.fitHeight,
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
      ),
      bottomSheet: _buildStaticBottomSheetContent(context),
    );
  }

  Widget _buildStaticBottomSheetContent(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        height: MediaQuery.of(context).size.height / 1.3,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  'Selamat Datang di MASPOS',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Masuk untuk klola bisnis kamu dengan mudah dan efisien. MASPOS hadirkan solusi point-of-sale terbaik untuk kemudahan operasional sehari-hari.',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 32),
            Column(
              children: [
                TextfieldWidget(
                  title: 'Username',
                  hintText: 'Masukan username',
                  controller: _usernameController,
                  isRequired: true,
                ),
                TextfieldWidget(
                  title: 'Password',
                  hintText: 'Masukan password',
                  controller: _passwordController,
                  obsecureText: true,
                  isRequired: true,
                ),
              ],
            ),
            SizedBox(height: 32),
            FilledButton(
              onPressed: () async {
                await Provider.of<AuthViewModel>(
                  context,
                  listen: false,
                ).login(_usernameController.text, _passwordController.text);
              },
              style: WidgetStyle.filledButtonStyle(),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kasir_app/features/user/view_model/auth_view_model.dart';
import 'package:kasir_app/features/user/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class ProfileSubpage extends StatelessWidget {
  const ProfileSubpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Column(
        spacing: 84,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<UserViewModel>(
            builder: (context, model, child) {
              final user = model.currentUser;
              return Column(
                children: [
                  Image.asset(
                    './assets/images/profile_placeholder.png',
                    height: 100,
                  ),
                  SizedBox(height: 16),
                  Text(
                    user?.name ?? 'Nama Pengguna',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(user?.email ?? '-'),
                ],
              );
            },
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.logout),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Text('Logout'),
                  onTap: () => _showDeleteConfirmation(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: Text('Yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      Provider.of<AuthViewModel>(context, listen: false).logout();
    }
  }
}

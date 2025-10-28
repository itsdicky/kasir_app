import 'package:flutter/material.dart';
import 'package:kasir_app/features/user/view_model/auth_view_model.dart';
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
          Image.asset('./assets/images/profile_placeholder.png', height: 100),
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.logout_outlined),
                trailing: Icon(Icons.chevron_right_outlined),
                onTap: () {},
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
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      Provider.of<AuthViewModel>(context, listen: false).logout();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:kasir_app/core/config/theme/widget_style.dart';

class SearchTextfield extends StatelessWidget {
  SearchTextfield({super.key, required this.action});

  final Function(String) action;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: WidgetStyle.searchFieldDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Cari produk...',
        ),
        onSubmitted: action,
      ),
    );
  }
}

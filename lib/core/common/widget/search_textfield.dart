import 'package:flutter/material.dart';

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
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onSubmitted: action,
      ),
    );
  }
}

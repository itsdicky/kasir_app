import 'package:flutter/material.dart';

class TabChipsWidget extends StatelessWidget {
  const TabChipsWidget({super.key, required this.title, required this.action});

  final String title;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ActionChip(label: Text(title), onPressed: action),
    );
  }
}

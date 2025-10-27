import 'package:flutter/material.dart';

class TabChipsWidget extends StatelessWidget {
  const TabChipsWidget({
    super.key,
    required this.title,
    required this.action,
    required this.active,
  });

  final String title;
  final Function() action;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ActionChip(
        label: Text(title),
        onPressed: action,
        side: active
            ? BorderSide(color: Theme.of(context).primaryColorDark, width: 2.0)
            : null,
      ),
    );
  }
}

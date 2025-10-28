import 'package:flutter/material.dart';
import 'package:kasir_app/core/config/theme/widget_style.dart';

class DropdownWidget<T> extends StatelessWidget {
  const DropdownWidget({
    super.key,
    required this.title,
    required this.items,
    required this.textBuilder,
    this.onChanged,
  });

  final String title;
  final List<T> items;
  final String Function(T?) textBuilder;
  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<T>(
            hint: Text('Pilih Kategori'),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            items: List.generate(items.length, (index) {
              return DropdownMenuItem<T>(
                value: items[index],
                child: Text(
                  textBuilder(items[index]),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              );
            }),
            onChanged: onChanged,
            dropdownColor: Colors.white,
            validator: (value) {
              if (value == null) {
                return 'Kategori harus diisi';
              }
              return null;
            },
            menuMaxHeight: 240,
            decoration: WidgetStyle.dropdownButtonDecoration(),
          ),
        ],
      ),
    );
  }
}

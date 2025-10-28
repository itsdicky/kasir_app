import 'dart:io';

import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    super.key,
    required this.title,
    this.documentImage,
    this.onTap,
    this.isInvalid = false,
  });

  final String title;
  final File? documentImage;
  final Function()? onTap;
  final bool isInvalid;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: onTap,
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: (!isInvalid)
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.error,
              ),
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).canvasColor,
            ),
            child: Builder(
              builder: (context) {
                if (documentImage != null) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Builder(
                            builder: (context) {
                              if (documentImage != null) {
                                return Image.file(
                                  documentImage!,
                                  fit: BoxFit.cover,
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black45,
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 12,
                              top: 4,
                              bottom: 4,
                            ),
                          ),
                          onPressed: onTap,
                          child: Row(
                            children: [
                              Text(
                                'Pilih ulang gambar',
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.add_a_photo_outlined,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 52,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Pilih file yang akan diunggah',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (isInvalid)
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              'Lampirkan hasil scan dokumen',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w100,
                height: 0.5,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          )
        else
          const SizedBox(height: 7),
      ],
    );
  }
}

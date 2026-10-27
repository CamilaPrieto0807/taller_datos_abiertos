import 'package:flutter/material.dart';

class EntityImage extends StatelessWidget {
  final String? url;
  final double size;
  final double? height;
  const EntityImage({super.key, this.url, this.size = 56, this.height});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: size,
      height: height ?? size,
      color: Colors.grey.shade300,
      child: const Icon(Icons.image_not_supported, color: Colors.grey),
    );
    if (url == null || url!.isEmpty) return placeholder;
    return Image.network(
      url!,
      width: size,
      height: height ?? size,
      fit: BoxFit.cover,
      webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
      errorBuilder: (_, _, _) => placeholder,
      loadingBuilder: (_, child, progress) => progress == null
          ? child
          : SizedBox(
              width: size,
              height: height ?? size,
              child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2)),
            ),
    );
  }
}
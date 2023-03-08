import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViewer extends StatelessWidget {
  final String url;
  const PdfViewer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return const PDF().cachedFromUrl(
      url,
      placeholder: (progress) => Center(child: Text('$progress %')),
      errorWidget: (error) => Center(child: Text(error.toString())),
    );
  }
}

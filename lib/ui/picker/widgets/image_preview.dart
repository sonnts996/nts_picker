import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:nts_picker/ui/picker/widgets/image_error_view.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(path),
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) {
        if(kDebugMode) {
          log('image error', error: error);
        }
        return const ErrorView();
      },
    );
  }
}

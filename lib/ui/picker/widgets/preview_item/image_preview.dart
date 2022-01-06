import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nts_picker/data/model/data/preview_data.model.dart';
import 'package:nts_picker/ui/picker/widgets/image_error_view.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({Key? key, required this.data}) : super(key: key);

  final UIPreviewData data;

  @override
  Widget build(BuildContext context) {
    if (data.checker) {
      return Stack(fit: StackFit.expand, children: [
        Image.file(
          data.file.fileSystemEntity as File,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            if (kDebugMode) {
              log('image error', error: error);
            }
            return const ErrorView();
          },
        ),
        Visibility(
          visible: data.file.selected,
          child: Container(color: Colors.black45),
        ),
        Center(
          child: Visibility(
              visible: data.file.selected,
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 32,
              )),
        )
      ]);
    } else {
      return Image.file(
        data.file.fileSystemEntity as File,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          if (kDebugMode) {
            log('image error', error: error);
          }
          return const ErrorView();
        },
      );
    }
  }
}

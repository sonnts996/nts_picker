/*
 Created by Thanh Son on 28/12/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:nts_picker/data/model/file/media_file.model.dart';

abstract class PreviewItemBase extends StatelessWidget {
  const PreviewItemBase({
    Key? key,
    required this.file,
    this.checker = false,
  }) : super(key: key);

  final MediaFile file;
  final bool checker;
}

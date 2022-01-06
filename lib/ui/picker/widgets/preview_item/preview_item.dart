import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nts_picker/data/model/file/media_file.model.dart';

class PreviewItem extends StatelessWidget {
  const PreviewItem({
    Key? key,
    required this.file,
    required this.previewItem,
    required this.onSelect,
  }) : super(key: key);

  final MediaFile file;
  final Widget previewItem;
  final Function(MediaFile file) onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
            onTap: () => onSelect(file),
            child: Ink(
              color: Theme.of(context).backgroundColor,
              child: previewItem,
            )));
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreviewItem extends StatelessWidget {
  const PreviewItem({
    Key? key,
    required this.path,
    required this.previewItem,
    this.checker = false,
    this.check = false,
    required this.onSelect,
  }) : super(key: key);

  final String path;
  final Widget previewItem;
  final bool checker;
  final bool check;
  final Function(String file) onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(child:  InkWell(
        onTap: () => onSelect(path),
        child: Ink(
          color: Theme.of(context).backgroundColor,
          child: Stack(
            fit: StackFit.expand,
            children: [
              previewItem,
              Visibility(
                visible: check && checker,
                child: Container(color: Colors.black45),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Visibility(
                    visible: checker,
                    child: Checkbox(
                      value: check,
                      onChanged: (value) => onSelect(path),
                    )),
              )
            ],
          ),
        )));
  }
}

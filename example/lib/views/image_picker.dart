/*
 Created by Thanh Son on 04/01/2022.
 Copyright (c) 2022 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:nts_picker/data/model/file/selector.model.dart';
import 'package:nts_picker/manager/picker_controller.dart';
import 'package:nts_picker/nts_picker.dart';
import 'package:nts_picker/ui/picker/views/picker.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ImagePickerState();
  }
}

class ImagePickerState extends State<ImagePicker> {
  bool _multiChoose = false;
  final NTSPickerController _controller = NTSPickerController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            NTSFolderPicker(
              controller: _controller,
              underline: const SizedBox(),
            )
          ],
        ),
        SizedBox(
          height: 300,
          child: NTSPicker(
            controller: _controller,
            multiChoose: _multiChoose,
            numberColumn: 3,
            selector: const Selector(mediaType: MediaType.all),
          ),
        )
      ],
    );
  }
}

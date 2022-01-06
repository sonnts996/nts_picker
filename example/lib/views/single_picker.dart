import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nts_picker/data/model/file/media_file.model.dart';
import 'package:nts_picker/data/model/file/selector.model.dart';
import 'package:nts_picker/manager/picker_controller.dart';
import 'package:nts_picker/nts_picker.dart';
import 'package:nts_picker/ui/picker/views/picker.dart';

class SinglePicker extends StatefulWidget {
  const SinglePicker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SinglePickerState();
  }
}

class SinglePickerState extends State<SinglePicker> {
  final NTSPickerController controller = NTSPickerController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 300,
            child: StreamBuilder<List<MediaFile>>(
              stream: controller.selectedStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  if (snapshot.data![0].mediaType == MediaType.image) {
                    return Image.file(
                      snapshot.data![0].fileSystemEntity as File,
                      height: 300,
                    );
                  } else {
                    return Center(
                      child: Text(snapshot.data![0].path),
                    );
                  }
                }
                return Container();
              },
            )),
        Expanded(
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 10,
                    )
                  ]),
              child: NTSPicker(
                selector: const Selector(mediaType: MediaType.all),
                multiChoose: false,
                controller: controller,
              )),
        )
      ],
    );
  }
}

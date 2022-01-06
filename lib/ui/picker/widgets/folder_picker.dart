/*
 Created by Thanh Son on 27/12/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:nts_picker/data/model/file/folder_item.model.dart';
import 'package:nts_picker/manager/data_manager.dart';
import 'package:nts_picker/manager/picker_controller.dart';

class NTSFolderPicker extends StatelessWidget {
  const NTSFolderPicker({Key? key, required this.controller}) : super(key: key);

  final NTSPickerController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Folder>>(
        stream: DataManager.instance.folderStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<Folder?>(
                stream: controller.currentFolderStream,
                builder: (context, currentFolderSnapshot) {
                  return DropdownButton<Folder>(
                    items: snapshot.data!
                        .map((e) => DropdownMenuItem<Folder>(
                              child: Text(e.name),
                              value: e,
                            ))
                        .toList(),
                    value: currentFolderSnapshot.data ?? snapshot.data!.first,
                    onChanged: (value) {
                      controller.currentFolder = value ?? Folder.all();
                    },
                  );
                });
          } else {
            return Container();
          }
        });
  }
}

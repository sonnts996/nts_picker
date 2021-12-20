import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nts_picker/data/model/file/folder_item.dart';
import 'package:nts_picker/ui/picker/bloc/picker_bloc.dart';
import 'package:nts_picker/ui/picker/widgets/image_preview.dart';
import 'package:nts_picker/ui/picker/widgets/item.dart';
import 'package:nts_picker/ui/picker/widgets/permission_denied.dart';
import 'package:permission_handler/permission_handler.dart';

class PickerContent extends StatefulWidget {
  const PickerContent({
    Key? key,
    this.numberColumn = 4,
    this.closeWidget,
    this.summitWidget,
  }) : super(key: key);

  final int numberColumn;
  final Widget? summitWidget;
  final Widget? closeWidget;

  @override
  State<StatefulWidget> createState() {
    return PickerContentState();
  }
}

class PickerContentState extends State<PickerContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickerBloc, PickerState>(
      buildWhen: (previous, current) => previous.time != current.time,
      builder: (BuildContext context, state) {
        if (!state.permission) {
          return PermissionDenied(onRequirePermission: () {
            context
                .read<PickerBloc>()
                .add(const RequestPermissionEvent(Permission.storage));
          });
        }
        return Column(
          children: [
            Row(
              children: [
                widget.closeWidget ??
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                Expanded(
                    child: DropdownButton<FolderItem>(
                  items: state.listFolder
                      .map((e) => DropdownMenuItem<FolderItem>(
                            child: Text(e.name),
                            value: e,
                          ))
                      .toList(),
                  value: state.listFolder.first,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<PickerBloc>().add(FolderFilterEvent(value));
                    }
                  },
                )),
                Visibility(
                    visible: state.multiChoose,
                    child: widget.summitWidget ??
                        ElevatedButton(
                            onPressed: () {}, child: const Text('Summit')))
              ],
            ),
            Expanded(
                child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.numberColumn,
                childAspectRatio: 1,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              padding: const EdgeInsets.all(2),
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return PreviewItem(
                  path: state.list[index],
                  previewItem: ImagePreview(path: state.list[index]),
                  checker: state.multiChoose,
                  check: state.selected.contains(state.list[index]),
                  onSelect: (path) {
                    context.read<PickerBloc>().add(SelectEvent(path));
                  },
                );
              },
            ))
          ],
        );
      },
    );
  }
}

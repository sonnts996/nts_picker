import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nts_picker/data/model/data/preview_data.model.dart';
import 'package:nts_picker/data/model/file/media_type.dart';
import 'package:nts_picker/ui/picker/bloc/picker_bloc.dart';
import 'package:nts_picker/ui/picker/widgets/permission_denied.dart';
import 'package:nts_picker/ui/picker/widgets/preview_item/image_preview.dart';
import 'package:nts_picker/ui/picker/widgets/preview_item/preview_item.dart';
import 'package:nts_picker/ui/picker/widgets/preview_item/video_preview.dart';

class PickerContent extends StatefulWidget {
  const PickerContent({
    Key? key,
    this.numberColumn = 4,
  }) : super(key: key);

  final int numberColumn;

  @override
  State<StatefulWidget> createState() {
    return PickerContentState();
  }
}

class PickerContentState extends State<PickerContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickerBloc, PickerState>(
        buildWhen: (previous, current) => previous.time != current.time,
        builder: (BuildContext context, state) {
          if (!state.permission) {
            return PermissionDenied(onRequirePermission: () {
              context.read<PickerBloc>().add(const RequestPermissionEvent());
            });
          }
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.numberColumn,
                childAspectRatio: 1,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              padding: const EdgeInsets.all(2),
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                var file = state.list[index];

                return PreviewItem(
                  file: file,
                  previewItem: file.mediaType == MediaType.video
                      ? VideoPreview(
                          data: UIPreviewData(
                          file: file,
                          checker: state.multiChoose,
                        ))
                      : ImagePreview(
                          data: UIPreviewData(
                          file: file,
                          checker: state.multiChoose,
                        )),
                  onSelect: (p0) {
                    context.read<PickerBloc>().add(SelectEvent(file));
                  },
                );
              });
        });
  }
}

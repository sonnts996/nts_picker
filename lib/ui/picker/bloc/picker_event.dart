part of 'picker_bloc.dart';

class PickerEvent {
  const PickerEvent();
}

class LoadDataEvent extends PickerEvent {
  const LoadDataEvent(this.selector);

  final Selector selector;
}

class RequestPermissionEvent extends PickerEvent {
  const RequestPermissionEvent();
}

class SelectEvent extends PickerEvent {
  const SelectEvent(this.file);

  final MediaFile file;
}

class OnDataEvent extends PickerEvent {
  const OnDataEvent(this.data);

  final List<MediaFile> data;
}

class FolderFilterEvent extends PickerEvent {
  const FolderFilterEvent(this.folder);

  final Folder? folder;
}

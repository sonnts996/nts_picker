part of 'picker_bloc.dart';

class PickerEvent {
  const PickerEvent();
}

class LoadFilesEvent extends PickerEvent {
  const LoadFilesEvent(this.selector);

  final Selector selector;
}

class RequestPermissionEvent extends PickerEvent {
  const RequestPermissionEvent(this.permission);

  final Permission permission;
}

class SelectEvent extends PickerEvent {
  const SelectEvent(this.path);

  final String path;
}

class FolderFilterEvent extends PickerEvent{
  const FolderFilterEvent(this.folder);

  final FolderItem folder;
}
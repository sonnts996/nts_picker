

part of 'picker_bloc.dart';

@CopyWith()
class PickerState {
  const PickerState({
    required this.time,
    required this.list,
    this.selected = const [],
    this.multiChoose = false,
    this.permission = false,
    this.listFolder = const [],
  });

  final bool multiChoose;
  final List<String> list;
  final bool permission;
  final DateTime time;
  final List<String> selected;
  final List<FolderItem> listFolder;
}

part of 'picker_bloc.dart';

@CopyWith()
class PickerState {
  const PickerState({
    required this.time,
    required this.list,
    this.multiChoose = false,
    this.permission = false,
  });

  final bool multiChoose;
  final List<MediaFile> list;
  final bool permission;
  final DateTime time;
}

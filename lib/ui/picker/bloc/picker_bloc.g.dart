// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picker_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PickerStateCopyWith on PickerState {
  PickerState copyWith({
    List<String>? list,
    List<FolderItem>? listFolder,
    bool? multiChoose,
    bool? permission,
    List<String>? selected,
    DateTime? time,
  }) {
    return PickerState(
      list: list ?? this.list,
      listFolder: listFolder ?? this.listFolder,
      multiChoose: multiChoose ?? this.multiChoose,
      permission: permission ?? this.permission,
      selected: selected ?? this.selected,
      time: time ?? this.time,
    );
  }
}

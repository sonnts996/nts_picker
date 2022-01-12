part of 'picker_bloc.dart';

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

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is PickerState && other.time == time;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => time.hashCode;

}


extension PickerStateCopyWith on PickerState {
  PickerState copyWith({
    List<MediaFile>? list,
    bool? multiChoose,
    bool? permission,
    DateTime? time,
  }) {
    return PickerState(
      list: list ?? this.list,
      multiChoose: multiChoose ?? this.multiChoose,
      permission: permission ?? this.permission,
      time: time ?? this.time,
    );
  }
}

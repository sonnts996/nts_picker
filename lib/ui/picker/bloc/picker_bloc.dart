import 'package:path/path.dart' as path;

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nts_picker/data/model/file/folder_item.dart';
import 'package:nts_picker/data/model/file/selector.model.dart';
import 'package:nts_picker/domain/file/file_repository.dart';
import 'package:nts_picker/domain/file/usecase/load_file.usecase.dart';
import 'package:nts_picker/manager/request_permission.dart';
import 'package:permission_handler/permission_handler.dart';

part 'picker_bloc.g.dart';

part 'picker_event.dart';

part 'picker_state.dart';

class PickerBloc extends Bloc<PickerEvent, PickerState> {
  PickerBloc(
    this._fileRepository,
    Selector selector,
    bool multiChoose,
  ) : super(PickerState(
          time: DateTime.now(),
          list: [],
          multiChoose: multiChoose,
        )) {
    on<LoadFilesEvent>(loadFileEvent);
    on<RequestPermissionEvent>(requestPermission);
    on<SelectEvent>(selectFile);
    on<FolderFilterEvent>(onFolderFilter);

    add(LoadFilesEvent(selector));
  }

  final FileRepository _fileRepository;
  final RequestPermission _requestPermission = RequestPermission();

  void loadFileEvent(LoadFilesEvent event, emit) async {
    var rs = await _requestPermission.checkStorage();
    if (rs) {
      emit(state.copyWith(permission: !rs, time: DateTime.now()));
    } else {
      var useCase = LoadFileUseCase(_fileRepository, event.selector);
      var files = await useCase.excute();

      var folders = _getFolder(files);
      emit(state.copyWith(
          list: files,
          time: DateTime.now(),
          permission: true,
          listFolder: folders));
    }
  }

  void requestPermission(RequestPermissionEvent event, emit) async {
    await _requestPermission.request();
    var rs = await event.permission.isDenied;
    emit(state.copyWith(permission: !rs, time: DateTime.now()));
  }

  void selectFile(SelectEvent event, emit) {
    var temp = List<String>.from(state.selected, growable: true).toList();

    if (state.multiChoose) {
      if (temp.contains(event.path)) {
        temp.remove(event.path);
      } else {
        temp.add(event.path);
      }
    } else {
      temp.clear();
      temp.add(event.path);
    }
    emit(state.copyWith(selected: temp, time: DateTime.now()));
  }

  List<FolderItem> _getFolder(List<String> files) {
    var temp = [FolderItem.all()];
    for (var e in files) {
      var dir = path.dirname(e);
      if (!temp.any((element) => element.path == dir)) {
        var name = path.basename(dir);
        temp.add(FolderItem(path: dir, name: name));
      }
    }
    return temp;
  }

  void onFolderFilter(FolderFilterEvent event, emit) {}
}

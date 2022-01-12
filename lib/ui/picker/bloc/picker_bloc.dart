import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nts_picker/data/model/file/folder_item.model.dart';
import 'package:nts_picker/data/model/file/media_file.model.dart';
import 'package:nts_picker/data/model/file/selector.model.dart';
import 'package:nts_picker/domain/file/file_repository.dart';
import 'package:nts_picker/domain/file/usecase/load_data.usecase.dart';
import 'package:nts_picker/domain/file/usecase/select_file.usecase.dart';
import 'package:nts_picker/manager/data_manager.dart';
import 'package:nts_picker/manager/picker_controller.dart';
import 'package:nts_picker/manager/request_permission.dart';

part 'picker_event.dart';

part 'picker_state.dart';

class PickerBloc extends Bloc<PickerEvent, PickerState> {
  PickerBloc(
    this._fileRepository,
    this._controller,
    this._selector,
    bool multiChoose,
  ) : super(PickerState(
          time: DateTime.now(),
          list: [],
          multiChoose: multiChoose,
        )) {
    on<OnDataEvent>(onDataEvent);
    on<LoadDataEvent>(loadFileEvent);
    on<RequestPermissionEvent>(requestPermissionEvent);
    on<SelectEvent>(selectFileEvent);
    on<FolderFilterEvent>(onFolderFilterEvent);

    _currentFolderStream = _controller.currentFolderStream.listen((event) {
      add(FolderFilterEvent(event));
    });

    _mediaFileStream = _dataManager.mediaFileStream.listen((event) {
      if (_controller.currentFolder == Folder.all()) {
        add(OnDataEvent(event));
      } else {
        add(FolderFilterEvent(_controller.currentFolder));
      }
    });

    add(LoadDataEvent(_selector));
  }

  final DataManager _dataManager = DataManager.instance;
  final FileRepository _fileRepository;
  final RequestPermission _requestPermission = RequestPermission();
  final NTSPickerController _controller;
  final Selector _selector;
  late final StreamSubscription? _currentFolderStream;
  late final StreamSubscription? _mediaFileStream;

  @override
  Future<void> close() {
    _currentFolderStream?.cancel();
    _mediaFileStream?.cancel();
    return super.close();
  }

  void loadFileEvent(LoadDataEvent event, emit) async {
    var rs = await _requestPermission.checkStorage();
    if (rs) {
      emit(state.copyWith(permission: !rs, time: DateTime.now()));
    } else {
      var useCase = LoadFileUseCase(_fileRepository, event.selector);
      useCase.excute();

      emit(state.copyWith(time: DateTime.now(), permission: true));
    }
  }

  void onDataEvent(OnDataEvent event, emit) {
    emit(state.copyWith(
      list: _fileRepository.mediaFiles,
      time: DateTime.now(),
    ));
  }

  void requestPermissionEvent(RequestPermissionEvent event, emit) async {
    await _requestPermission.request();
    var rs = await _requestPermission.checkPermisstion();
    if (rs) {
      emit(state.copyWith(permission: !rs, time: DateTime.now()));
    } else {
      add(LoadDataEvent(_selector));
    }
  }

  void selectFileEvent(SelectEvent event, emit) async {
    var useCase = SelectFileUsecase(_fileRepository,
        mediaFile: event.file, multiChoose: state.multiChoose);
    _controller.selected = await useCase.excute();
  }

  void onFolderFilterEvent(FolderFilterEvent event, emit) {
    if (event.folder != null && event.folder != Folder.all()) {
      List<MediaFile> temp = _dataManager.mediaFiles
          .where((element) => element.inFolder(event.folder!))
          .toList();
      emit(state.copyWith(list: temp, time: DateTime.now()));
    } else {
      emit(state.copyWith(list: _dataManager.mediaFiles, time: DateTime.now()));
    }
  }
}

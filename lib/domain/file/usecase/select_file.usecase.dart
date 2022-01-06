/*
 Created by Thanh Son on 28/12/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import 'package:nts_picker/data/model/file/media_file.model.dart';
import 'package:nts_picker/domain/file/file_repository.dart';
import 'package:nts_picker/domain/usecase.base.dart';
import 'package:nts_picker/manager/data_manager.dart';

class SelectFileUsecase extends UseCase<Future<List<MediaFile>>> {
  SelectFileUsecase(this._repository,
      {required this.mediaFile, this.multiChoose = true});

  final FileRepository _repository;
  final MediaFile mediaFile;
  final bool multiChoose;
  final DataManager _dataManager = DataManager.instance;

  @override
  Future<List<MediaFile>> excute() async {
    await _repository.selectFile(mediaFile, multiChoose);
    _dataManager.mediaFiles = _repository.mediaFiles;
    return _repository.selected;
  }
}

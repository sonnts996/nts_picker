import 'dart:io';

import 'package:nts_picker/data/model/file/selector.model.dart';
import 'package:nts_picker/domain/file/file_repository.dart';
import 'package:nts_picker/domain/usecase.base.dart';

class LoadFileUseCase extends UseCase<Future<List<String>>> {
  LoadFileUseCase(this._repository, this.selector);

  final FileRepository _repository;
  final Selector selector;

  @override
  Future<List<String>> excute() {
    return _repository.getListFile(selector);
  }
}

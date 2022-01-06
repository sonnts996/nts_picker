import 'package:nts_picker/data/model/file/selector.model.dart';
import 'package:nts_picker/domain/file/file_repository.dart';
import 'package:nts_picker/domain/usecase.base.dart';
import 'package:nts_picker/manager/data_manager.dart';

class LoadFileUseCase extends UseCase<Future<void>> {
  LoadFileUseCase(this._repository, this.selector);

  final FileRepository _repository;
  final Selector selector;
  final DataManager _dataManager = DataManager.instance;

  @override
  Future<void> excute() async {
    await _repository.loadData(selector);
    _dataManager.mediaFiles = _repository.mediaFiles;
    _dataManager.folders = _repository.mediaFolders;
  }
}

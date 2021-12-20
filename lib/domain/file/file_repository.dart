import 'dart:io';

import 'package:nts_picker/data/model/file/selector.model.dart';

abstract class FileRepository{

  Future<List<String>> getListFile(Selector selector);

}
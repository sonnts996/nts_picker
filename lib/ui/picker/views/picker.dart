import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nts_picker/data/model/file/selector.model.dart';
import 'package:nts_picker/data/repository/file/file_repository.dart';
import 'package:nts_picker/manager/picker_controller.dart';
import 'package:nts_picker/ui/picker/bloc/picker_bloc.dart';
import 'package:nts_picker/ui/picker/views/picker_content.dart';

class NTSPicker extends StatefulWidget {
  const NTSPicker({
    Key? key,
    this.multiChoose = false,
    this.numberColumn = 3,
    required this.selector,
    this.controller,
  }) : super(key: key);

  final int numberColumn;
  final bool multiChoose;
  final Selector selector;
  final NTSPickerController? controller;

  @override
  State<StatefulWidget> createState() {
    return NTSPickerState();
  }
}

class NTSPickerState extends State<NTSPicker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = widget.controller ?? NTSPickerController();
    return BlocProvider(
      create: (context) => PickerBloc(
        FileRepositoryV1(),
        controller,
        widget.selector,
        widget.multiChoose,
      ),
      child: PickerContent(numberColumn: widget.numberColumn),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nts_picker/data/model/file/selector.model.dart';
import 'package:nts_picker/data/repository/file/file_repository.dart';
import 'package:nts_picker/ui/picker/bloc/picker_bloc.dart';
import 'package:nts_picker/ui/picker/views/picker_content.dart';

class NTSPicker extends StatefulWidget {
  const NTSPicker({
    Key? key,
    this.summitWidget,
    this.closeWidget,
    this.multiChoose = false,
    this.numberColumn = 3,
    required this.selector,
  }) : super(key: key);

  final int numberColumn;
  final Widget? summitWidget;
  final Widget? closeWidget;
  final bool multiChoose;
  final Selector selector;

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
    return BlocProvider(
      create: (context) => PickerBloc(
        FileRepositoryV1(),
        widget.selector,
        widget.multiChoose,
      ),
      child: PickerContent(
        numberColumn: widget.numberColumn,
        closeWidget: widget.closeWidget,
        summitWidget: widget.summitWidget,
      ),
    );
  }
}

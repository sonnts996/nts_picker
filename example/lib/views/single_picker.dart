import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nts_picker/data/model/file/selector.model.dart';
import 'package:nts_picker/ui/picker/views/picker.dart';

class SinglePicker extends StatefulWidget {
  const SinglePicker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SinglePickerState();
  }
}

class SinglePickerState extends State<SinglePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Placeholder(fallbackHeight: 300),
        Expanded(
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 10,
                    )
                  ]),
              child: const NTSPicker(
                selector: Selector(extension: ['.jpg', '.jpeg', '.png']),
                multiChoose: false,
              )),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:nts_picker/nts_picker.dart';
import 'package:nts_picker_example/views/multi_picker.dart';
import 'package:nts_picker_example/views/single_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NTS Picker'),
          bottom: TabBar(controller: _controller, tabs: const [
            Tab(text: 'Single Picker'),
            Tab(text: 'Multi Picker'),
          ]),
        ),
        body: TabBarView(
          controller: _controller,
          children: const [
            SinglePicker(),
            MultiPicker(),
          ],
        ),
      ),
    );
  }
}

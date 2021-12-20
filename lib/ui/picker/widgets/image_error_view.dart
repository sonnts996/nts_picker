import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.broken_image,
        color: Colors.white38,
        size: 28,
      ),
    );
  }
}

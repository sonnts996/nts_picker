import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PermissionDenied extends StatelessWidget {
  const PermissionDenied({Key? key, required this.onRequirePermission})
      : super(key: key);

 final Function() onRequirePermission;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onRequirePermission,
        child: const Text('Allow access'),
      ),
    );
  }
}

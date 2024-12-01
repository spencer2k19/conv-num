import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProgress extends StatelessWidget {
  Color? color;

  CustomProgress({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoActivityIndicator(
            color: color,
          )
        : SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              color: color,
              strokeWidth: 1.5,
            ),
          );
  }
}

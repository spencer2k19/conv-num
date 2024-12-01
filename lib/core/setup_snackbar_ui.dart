import 'package:contacts_proj/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  service.registerSnackbarConfig(
    SnackbarConfig(
      textColor: Colors.white,
      messageColor: Colors.white,
      borderRadius: 10,
    ),
  );
}

import 'package:flutter/material.dart';

BuildContext? activeDialogContext;

void closeActiveDialog() {
  if (activeDialogContext == null) return;

  final ctx = activeDialogContext;

  // context mounted check
  if (ctx != null && ctx.mounted) {
    Navigator.of(ctx, rootNavigator: true).pop();
  }

  activeDialogContext = null;
}

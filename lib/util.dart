import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message), 
      showCloseIcon: true),
  );
}

void _showNonDismissibleDialog(BuildContext c, AlertDialog Function(BuildContext) dialogBuilder) {
  showDialog(
    context: c,
    barrierDismissible: false,
    builder: (c) => WillPopScope(
      child: dialogBuilder(c), 
      onWillPop: () async { return false; }));
}

void showExceptionDialog(BuildContext c, Exception e, StackTrace s) {

}

void showAppBlockingDialog(BuildContext c, String title, String description) {
  _showNonDismissibleDialog(c, (c) => AlertDialog(
    title: Text(title),
    content: Text(description)
  ));
}
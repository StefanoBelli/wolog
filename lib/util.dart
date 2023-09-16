import 'package:flutter/material.dart';
import 'package:rich_clipboard/rich_clipboard.dart';

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
  _showNonDismissibleDialog(c, (c) => AlertDialog(
    title: const Text("Exception log"),
    content: Column(
      children: [
        const Text("App encountered an exception while running:"),
        Text(e.toString()),
        Text(s.toString())
      ],
    ),
    actions: [
      TextButton(
        child: const Text("Ok"),
        onPressed: () => Navigator.pop(c)
      ),
      TextButton(
        onPressed: () async {
          final String data = 
            "\nexception:\n${e.toString()}"
            "\nstacktrace:\n${s.toString()}";
          await RichClipboard.setData(RichClipboardData(text: data));
        },
        child: const Text("Copy")),
    ],
  ));
}

void showAppBlockingDialog(BuildContext c, String title, String description) {
  _showNonDismissibleDialog(c, (c) => AlertDialog(
    title: Text(title),
    content: Text(description)
  ));
}
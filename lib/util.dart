import 'package:flutter/material.dart';
import 'package:rich_clipboard/rich_clipboard.dart';

void showSnackBar(final BuildContext context, final String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message), 
      showCloseIcon: true),
  );
}

void _showNonDismissibleDialog(final BuildContext c, final AlertDialog Function(BuildContext) dialogBuilder) {
  showDialog(
    context: c,
    barrierDismissible: false,
    builder: (final c) => WillPopScope(
      child: dialogBuilder(c), 
      onWillPop: () async => false ));
}

void showExceptionDialog(final BuildContext c, final Object e, final StackTrace s) {
  _showNonDismissibleDialog(c, (final c) => AlertDialog(
    title: const Row(
      children: [
        Icon(
          Icons.error, 
          size: 28),
        Padding(
          padding: EdgeInsetsDirectional.only(end: 7)),
        Text('Exception log')
      ]),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Message', 
          style: TextStyle(fontSize: 20),),
        Flexible(
          child: SingleChildScrollView(
            child: Text(e.toString()))),
        const Text('Stack trace', 
          style: TextStyle(fontSize: 20)),
        Flexible(
          child: SingleChildScrollView(
            child:  Text(s.toString())))
      ],
    ),
    actions: [
      TextButton(
        child: const Text('Ok'),
        onPressed: () => Navigator.pop(c)
      ),
      TextButton(
        onPressed: () async {
          final data = 
            '\nexception:\n$e'
            '\nstacktrace:\n$s';
          await RichClipboard.setData(RichClipboardData(text: data));
        },
        child: const Text('Copy')),
    ],
  ));
}

void showAppBlockingDialog(final BuildContext c, final String title, final String description) {
  _showNonDismissibleDialog(c, (final c) => AlertDialog(
    title: Text(title),
    content: Text(description)
  ));
}
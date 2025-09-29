import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => AlertDialog(
          content: Row(
            children: [Text('Loading ... '),Spacer(), CircularProgressIndicator()],
          ),
        ),
  );
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

void showError(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => AlertDialog(
          title: Text('Error !'),
      content: Text(message),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Ok'))],
    ),
  );
}

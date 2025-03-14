import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';

class CustomToast extends StatelessWidget {
  final String text;

  const CustomToast({super.key, required this.text});

  static void show(BuildContext context, String text) {
    DelightToastBar(
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      snackbarDuration: const Duration(seconds: 3),
      builder: (context) => CustomToast(text: text),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return ToastCard(
      leading: const Icon(Icons.info, color: Colors.blue),
      title: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
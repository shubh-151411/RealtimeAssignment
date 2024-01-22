import 'package:flutter/material.dart';
import 'package:realtime_innovations/utils/constant/appconstant.dart';

class Snackbars {
  static void showGeneralSnackbar(String text) {
    final SnackBar snackBar = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(seconds: 1),
    );
    AppConsts.scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  static void showErrorSnackbar(String text) {
    final SnackBar snackBar = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: const TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.red[50],
    );
    AppConsts.scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  static void hideSnackbar() {
    AppConsts.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  }
}

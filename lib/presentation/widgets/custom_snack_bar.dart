import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

enum StatusSnackBar { success, warning, error }

SnackBar customSnackBar(StatusSnackBar status, String message) {
  return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
          title: _title(status),
          message: message,
          contentType: _contentType(status)));
}

ContentType _contentType(StatusSnackBar statusSnackBar) {
  return switch (statusSnackBar) {
    StatusSnackBar.success => ContentType.success,
    StatusSnackBar.warning => ContentType.warning,
    StatusSnackBar.error => ContentType.failure,
  };
}

String _title(StatusSnackBar status) {
  return switch (status) {
    StatusSnackBar.success => 'Success',
    StatusSnackBar.warning => 'Warning',
    StatusSnackBar.error => 'Error',
  };
}

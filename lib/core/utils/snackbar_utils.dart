import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showErrorMessage(dynamic message, {Widget? icon}) {
  toastification.dismissAll();
  toastification.show(
    title: Text(
      message.toString(),
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
    ),
    type: ToastificationType.error,
    style: ToastificationStyle.minimal,
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 3),
    icon: icon,
  );
}

void showSuccessMessage(dynamic message, {Widget? icon}) {
  toastification.dismissAll();
  toastification.show(
    title: Text(
      message.toString(),
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
    ),
    type: ToastificationType.success,
    style: ToastificationStyle.minimal,
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 3),
    icon: icon,
  );
}

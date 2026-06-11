import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnityArLauncher {
  const UnityArLauncher._();

  static const MethodChannel _channel = MethodChannel('app_ar/unity');

  static Future<void> open(BuildContext context, {String? modelId}) async {
    final messenger = ScaffoldMessenger.of(context);

    try {
      await _channel.invokeMethod<void>('openUnityAr', {
        if (modelId != null) 'modelId': modelId,
      });
    } on PlatformException catch (error) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Unable to open AR.'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}

import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class Monitoring {
  final FirebaseCrashlytics firebaseCrashlytics = FirebaseCrashlytics.instance;

  Future initialize() async {
    try {
      FlutterError.onError = (errors) async {
        try {
          FirebaseCrashlytics.instance.recordFlutterError(errors);
        } catch (e) {
          print('onError $e');
        }
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        try {
          firebaseCrashlytics.recordError(error, stack, fatal: true);
        } catch (e) {
          print('onError $e');
        }
        return true;
      };
    } catch (e) {
      print('onError $e');
    }
  }

  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    bool fatal = false,
  }) async {
    try {
      await firebaseCrashlytics.recordError(exception, stack, fatal: fatal);
    } catch (e) {
      print('onError $e');
    }
  }
}

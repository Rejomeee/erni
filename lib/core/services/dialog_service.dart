// coverage:ignore-file

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_exam/core/services/navigation_service.dart';
import 'package:injectable/injectable.dart';

abstract class DialogService {
  Future<void> alert(String message, {String? title, String? ok});

  Future<bool> dismiss([Object? result]);

  void showLoading([String? message]);

  void showSnackbar(String message, {Duration duration = const Duration(seconds: 2)});
}

@LazySingleton(as: DialogService)
class DialogServiceImpl implements DialogService {
  bool _isLoadingShown = false;
  bool _isDialogShown = false;

  static BuildContext get _context {
    final context = NavigationService.navigatorKey.currentState?.overlay?.context;

    if (context == null) {
      throw StateError('BuildContext is null');
    }

    return context;
  }

  @override
  Future<void> alert(String message, {String? title, String? ok}) async {
    _isDialogShown = true;

    await showDialog<void>(
      context: _context,
      builder: (context) {
        return AlertDialog(
          title: title != null
              ? Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              : null,
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(ok ?? 'Ok'),
            ),
          ],
        );
      },
    );

    _isDialogShown = false;
  }

  @override
  // ignore: avoid_void_async
  void showLoading([String? message]) async {
    if (_isLoadingShown) {
      return;
    }

    _isDialogShown = true;
    _isLoadingShown = true;

    await showDialog<void>(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              const SizedBox(width: 16),
              Text(message ?? 'Loading...'),
            ],
          ),
        );
      },
    );

    _isDialogShown = false;
    _isLoadingShown = false;
  }

  @override
  Future<bool> dismiss([Object? result]) async {
    if (!_isDialogShown || !_isLoadingShown) {
      return false;
    }

    return Navigator.of(_context).maybePop(result);
  }

  @override
  void showSnackbar(String message, {Duration duration = const Duration(seconds: 2)}) {
    final mediaQuery = MediaQuery.of(_context);
    final isLargeDevice = mediaQuery.size.width > 512;

    ScaffoldMessenger.of(_context).hideCurrentSnackBar();

    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        width: isLargeDevice ? 512 : null,
        duration: duration,
      ),
    );
  }
}

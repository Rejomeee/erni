// coverage:ignore-file

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_exam/core/services/view_locator.dart';
import 'package:injectable/injectable.dart';
import 'package:page_transition/page_transition.dart';

abstract class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  Future<bool> pop([Object? result]);

  void popToRoot();

  Future<T?> push<T extends Object>(String routeName, {Object? parameter});

  Future<void> pushToNewRoot(String routeName, {Object? parameter});
}

@LazySingleton(as: NavigationService)
class NavigationServiceImpl implements NavigationService {
  NavigatorState get _navigator {
    final navigatorState = NavigationService.navigatorKey.currentState;

    if (navigatorState == null) {
      throw StateError('NavigatorState is null');
    }

    return navigatorState;
  }

  @override
  Future<bool> pop([Object? result]) => _navigator.maybePop(result);

  @override
  void popToRoot() {
    _navigator.popUntil((route) => route.isFirst);
  }

  @override
  Future<T?> push<T extends Object>(String routeName, {Object? parameter}) async {
    final routeUri = _createRouteUri(routeName);
    final result = await _navigator.pushNamed(
      routeUri.toString(),
      arguments: _NavigationParameterWrapper(parameter),
    ) as T?;

    return result;
  }

  @override
  Future<void> pushToNewRoot(String routeName, {Object? parameter}) async {
    final routeUri = _createRouteUri(routeName);

    // This future does not complete
    unawaited(
      _navigator.pushNamedAndRemoveUntil(
        routeUri.toString(),
        (_) => false,
        arguments: _NavigationParameterWrapper(parameter, isRoot: true),
      ),
    );
  }

  static Uri _createRouteUri(String routeName) => Uri(path: routeName);
}

abstract class RouteGenerator {
  Route<Object> onGenerateRoute(RouteSettings settings);
}

@LazySingleton(as: RouteGenerator)
class RouteGeneratorImpl implements RouteGenerator {
  RouteGeneratorImpl(this._viewLocator);

  final ViewLocator _viewLocator;

  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;

    if (routeName == null) {
      throw StateError('routeName is null');
    }

    final isRouteRegistered = _viewLocator.isViewRegistered(routeName);

    if (isRouteRegistered) {
      final view = _viewLocator.getView(routeName);
      final navigationParameter = settings.arguments as _NavigationParameterWrapper?;
      final newSettings = RouteSettings(name: routeName, arguments: navigationParameter?.argument);

      if (navigationParameter?.isRoot == true) {
        return PageTransition<Object>(
          child: view,
          type: PageTransitionType.fade,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 250),
          settings: newSettings,
        );
      }

      return MaterialPageRoute<Object>(
        builder: (context) => view,
        settings: newSettings,
      );
    }

    return PageTransition<Object>(
      child: _RouteNotFound(routeName: routeName),
      settings: const RouteSettings(name: 'not-found'),
      type: PageTransitionType.fade,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
    );
  }
}

class _NavigationParameterWrapper {
  _NavigationParameterWrapper(this.argument, {this.isRoot = false});

  final Object? argument;
  final bool isRoot;
}

class _RouteNotFound extends StatelessWidget {
  const _RouteNotFound({required this.routeName});

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Route \'$routeName\' Not Found',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

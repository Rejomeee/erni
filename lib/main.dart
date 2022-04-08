import 'package:flutter/material.dart';
import 'package:flutter_tech_exam/core/services/navigation_service.dart';
import 'package:flutter_tech_exam/core/views/splash_view.dart';
import 'package:flutter_tech_exam/shared/service_locator.dart';

void main() {
  registerServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final RouteGenerator _routeGenerator = locator<RouteGenerator>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashView(),
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: _routeGenerator.onGenerateRoute,
    );
  }
}

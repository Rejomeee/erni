import 'package:flutter/material.dart';
import 'package:flutter_tech_exam/core/view_models/splash_view_model.dart';
import 'package:flutter_tech_exam/core/views/base/view.dart';

class SplashView extends StatelessWidget with ViewMixin<SplashViewModel> {
  SplashView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

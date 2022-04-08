import 'package:flutter_tech_exam/common/route_names.dart';
import 'package:flutter_tech_exam/core/services/navigation_service.dart';
import 'package:flutter_tech_exam/core/view_models/base/view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashViewModel extends ViewModel {
  SplashViewModel(this._navigationService);

  final NavigationService _navigationService;

  @override
  Future<void> onInitialize([Object? parameter]) async {
    // represents initial loading
    await Future<void>.delayed(const Duration(seconds: 3));

    await _navigationService.pushToNewRoot(RouteNames.userList);
  }
}

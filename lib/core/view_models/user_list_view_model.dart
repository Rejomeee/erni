import 'package:flutter/foundation.dart';
import 'package:flutter_tech_exam/common/route_names.dart';
import 'package:flutter_tech_exam/core/services/dialog_service.dart';
import 'package:flutter_tech_exam/core/services/navigation_service.dart';
import 'package:flutter_tech_exam/core/view_models/base/view_model.dart';
import 'package:flutter_tech_exam/domain/entities/user_entity.dart';
import 'package:flutter_tech_exam/domain/managers/user_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserListViewModel extends ViewModel {
  UserListViewModel(this._navigationService, this._dialogService, this._userManager);

  final NavigationService _navigationService;
  final DialogService _dialogService;
  final UserManager _userManager;

  final ValueNotifier<List<UserEntity>> users = ValueNotifier([]);

  @override
  Future<void> onInitialize([Object? parameter]) async {
    await _tryGetUsers();
  }

  Future<void> onNavigateToUserDetails(UserEntity user) {
    return _navigationService.push(RouteNames.userDetails, parameter: user);
  }

  Future<void> _tryGetUsers() async {
    // TODO: Check if connected to internet.

    _dialogService.showLoading();

    users.value = await _userManager.getUsers();

    await _dialogService.dismiss();
  }
}

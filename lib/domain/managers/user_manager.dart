import 'package:flutter_tech_exam/domain/entities/user_entity.dart';
import 'package:flutter_tech_exam/domain/mappers/user_mapper.dart';
import 'package:flutter_tech_exam/web/services/user_service.dart';
import 'package:injectable/injectable.dart';

abstract class UserManager {
  Future<List<UserEntity>> getUsers();
}

@LazySingleton(as: UserManager)
class UserManagerImpl implements UserManager {
  UserManagerImpl(this._userService, this._userMapper);

  final UserService _userService;
  final UserMapper _userMapper;

  @override
  Future<List<UserEntity>> getUsers() async {
    final contracts = await _userService.getUsers();

    // TODO: Remove duplicate entries from `contracts`

    return contracts.map(_userMapper.fromContract).toList();
  }
}

import 'package:flutter_tech_exam/web/contracts/user_contract.dart';
import 'package:injectable/injectable.dart';

abstract class UserService {
  Future<List<UserContract>> getUsers();
}

@LazySingleton(as: UserService)
class UserServiceImpl implements UserService {
  @override
  Future<List<UserContract>> getUsers() {
    // TODO: Implement getUsers, use endpoints from `ApiEndpoints` class
    return Future<List<UserContract>>.delayed(const Duration(seconds: 3), () async => []);
  }
}

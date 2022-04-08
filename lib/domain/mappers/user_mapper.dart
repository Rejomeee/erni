import 'package:flutter_tech_exam/domain/entities/user_entity.dart';
import 'package:flutter_tech_exam/web/contracts/user_contract.dart';
import 'package:injectable/injectable.dart';
import 'package:smartstruct/smartstruct.dart';

part 'user_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class UserMapper {
  UserEntity fromContract(UserContract contract);
}

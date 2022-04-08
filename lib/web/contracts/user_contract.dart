import 'package:json_annotation/json_annotation.dart';

part 'user_contract.g.dart';

@JsonSerializable()
class UserContract {
  const UserContract(this.id, this.name, this.imageUrl);

  final String id;
  final String name;
  final String imageUrl;

  factory UserContract.fromJson(Map<String, dynamic> json) => _$UserContractFromJson(json);

  Map<String, dynamic> toJson() => _$UserContractToJson(this);
}

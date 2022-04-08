import 'package:meta/meta.dart';

@immutable
class UserEntity {
  const UserEntity(this.id, this.name, this.imageUrl);

  final String id;
  final String name;
  final String imageUrl;
}

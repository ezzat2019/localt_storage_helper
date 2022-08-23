import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;

  UserModel(this.name, this.age);

  @override
  String toString() {
    return 'UserModel{name: $name, age: $age}';
  }
}
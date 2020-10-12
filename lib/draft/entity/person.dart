import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class PersonModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String imageUrl;

  PersonModel({this.id, this.name, this.imageUrl});

  @override
  List<Object> get props => [id, name, imageUrl];

  @override
  String toString() {
    return 'PersonModel{id: $id, name: $name, imageUrl: $imageUrl}';
  }
}

import 'package:hive/hive.dart';
part 'student.g.dart';
//flutter_hive>flutter packages pub run build_runner build  -> terminal komutu
@HiveType(typeId: 1)
class Student {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final EyeColor eyeColor;

  Student(this.id, this.name, this.eyeColor);

  @override
  String toString() {
    return '$id  -  $name  -  $eyeColor';
  }
}

@HiveType(typeId: 2)
enum EyeColor {
  @HiveField(0,defaultValue: true)
  SIYAH,

  @HiveField(1)
  MAVI,

  @HiveField(2)
  YESIL
}

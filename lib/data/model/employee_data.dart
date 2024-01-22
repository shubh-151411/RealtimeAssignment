import 'package:hive/hive.dart';
part 'employee_data.g.dart';

@HiveType(typeId: 1)
class EmployeeData extends HiveObject {
  @HiveField(1)
  String? id;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? role;

  @HiveField(4)
  String? fromDate;

  @HiveField(5)
  String? toDate;

  EmployeeData({this.id, this.name, this.role, this.fromDate, this.toDate});
}

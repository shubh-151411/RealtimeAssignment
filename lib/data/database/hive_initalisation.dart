import 'package:hive_flutter/hive_flutter.dart';
import 'package:realtime_innovations/data/model/employee_data.dart';
import 'package:realtime_innovations/utils/constant/appconstant.dart';

class HiveManager {
  static HiveManager? _instance;
  late Box<EmployeeData> _employeeBox;
  HiveManager._();
  factory HiveManager.getInstance() {
    _instance ??= HiveManager._();
    return _instance!;
  }
  Box<EmployeeData> get employeeBox => _employeeBox;

  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EmployeeDataAdapter());
    _employeeBox = await Hive.openBox<EmployeeData>(AppConsts.DBName);
  }

  Future<void> addPerson(
      EmployeeData? employeeData, Box<EmployeeData> box) async {
    await box.add(employeeData!);
  }

  List<EmployeeData> getPersons(Box<EmployeeData> box) {
    return box.values.toList();
  }

  Future<void> updatePerson(int? index, EmployeeData? updatedEmployeeData,
      Box<EmployeeData> box) async {
    await box.putAt(index!, updatedEmployeeData!);
  }

  Future<void> deletePerson(int index, Box<EmployeeData> box) async {
    await box.deleteAt(index);
  }
}

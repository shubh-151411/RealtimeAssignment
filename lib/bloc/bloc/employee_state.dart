part of 'employee_bloc.dart';

@immutable
abstract class EmployeeBlocState {}

final class EmployeeBlocInitial extends EmployeeBlocState {}

class EmployeeEmptyState extends EmployeeBlocState {}

class EmployeeResultState extends EmployeeBlocState {
  final List<EmployeeData>? currentEmployeeData;
  final List<EmployeeData>? previousEmployeeData;

  EmployeeResultState(
      {required this.currentEmployeeData, required this.previousEmployeeData});
}

class EmployeeActionState extends EmployeeBlocState {}

class EmployeeAddState extends EmployeeBlocState {}

class EmployeeEditState extends EmployeeBlocState {}

class EditEmployeeActionState extends EmployeeBlocState {
  final int? index;
  final EmployeeData? employeeData;

  EditEmployeeActionState({this.index, this.employeeData});
}

class EmployeeDeleteState extends EmployeeBlocState {}

class AllEmployeeResultState extends EmployeeBlocState {}

class RefreshState extends EmployeeBlocState {}

class SelectRoleState extends EmployeeBlocState {
  final String? data;
  SelectRoleState({this.data});
}

class SelectFromDateState extends EmployeeBlocState {
  final String? formDate;
  SelectFromDateState({this.formDate});
}

class SelectToDateState extends EmployeeBlocState {
  final String? toDate;
  SelectToDateState({this.toDate});
}

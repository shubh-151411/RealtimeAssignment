part of 'employee_bloc.dart';

@immutable
abstract class EmployeeBlocEvent {}

class EmployeeActionEvent extends EmployeeBlocEvent {}

class InitialEvent extends EmployeeBlocEvent {}

class AddEmployeeEvent extends EmployeeBlocEvent {
  final EmployeeData? employeeDate;
  AddEmployeeEvent({this.employeeDate});
}

class EditEmployeeActionEvent extends EmployeeBlocEvent {
  final EmployeeData? employeeDate;
  EditEmployeeActionEvent({this.employeeDate});
}

class EditEmployeeEvent extends EmployeeBlocEvent {
  final EmployeeData? employeeDate;
  final int? index;
  EditEmployeeEvent({this.employeeDate, this.index});
}

class DeleteEmployeeEvent extends EmployeeBlocEvent {
  final EmployeeData? employeeData;
  DeleteEmployeeEvent({this.employeeData});
}

class SelectRoleEvent extends EmployeeBlocEvent {
  final String? role;
  SelectRoleEvent({this.role});
}

class SelectFromDateEvent extends EmployeeBlocEvent {
  final String? fromDate;
  SelectFromDateEvent({this.fromDate});
}

class SelectToDateEvent extends EmployeeBlocEvent {
  final String? toDate;
  SelectToDateEvent({this.toDate});
}

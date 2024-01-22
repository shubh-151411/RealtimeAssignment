import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:realtime_innovations/data/database/hive_initalisation.dart';
import 'package:realtime_innovations/data/model/employee_data.dart';
import 'package:realtime_innovations/utils/constant/appconstant.dart';
import 'package:realtime_innovations/utils/decoration/snack_bars.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeBlocEvent, EmployeeBlocState> {
  EmployeeBloc() : super(EmployeeBlocInitial()) {
    on<InitialEvent>(initalEvent);
    on<AddEmployeeEvent>(addEmployeeEvent);
    on<EditEmployeeEvent>(editEmployeeEvent);
    on<DeleteEmployeeEvent>(deleteEmployeeEvent);
    on<SelectRoleEvent>(selectRoleEvent);
    on<SelectFromDateEvent>(selectFromDateEvent);
    on<SelectToDateEvent>(selectToDateEvent);
    on<EditEmployeeActionEvent>(editEmployeeActionEvent);
  }

  FutureOr<void> initalEvent(
      InitialEvent event, Emitter<EmployeeBlocState> emit) async {
    List<EmployeeData> employeeData = HiveManager.getInstance()
        .getPersons(HiveManager.getInstance().employeeBox);
    if (employeeData?.isEmpty ?? true) {
      //Emit EmptyState
      emit(EmployeeEmptyState());
    } else {
      List<EmployeeData>? _currentEmployeeDate =
          getCurrentEmployeeList(employeeData: employeeData);
      List<EmployeeData>? _previousEmployeeDate =
          getPreviousEmployeeList(employeeData: employeeData);
      emit(EmployeeResultState(
          currentEmployeeData: _currentEmployeeDate,
          previousEmployeeData: _previousEmployeeDate));
      //Show Result State
    }
  }

  FutureOr<void> addEmployeeEvent(
      AddEmployeeEvent event, Emitter<EmployeeBlocState> emit) async {
    await HiveManager.getInstance()
        .addPerson(event.employeeDate, HiveManager.getInstance().employeeBox);
    Snackbars.showGeneralSnackbar("Added Successfully");
    emit(RefreshState());
  }

  FutureOr<void> editEmployeeEvent(
      EditEmployeeEvent event, Emitter<EmployeeBlocState> emit) async {
    await HiveManager.getInstance().updatePerson(
        event.index, event.employeeDate, HiveManager.getInstance().employeeBox);
    Snackbars.showGeneralSnackbar('Edited Successfully');
    emit(RefreshState());
  }

  FutureOr<void> deleteEmployeeEvent(
      DeleteEmployeeEvent event, Emitter<EmployeeBlocState> emit) async {
    int? index;
    for (int i = 0; i < HiveManager.getInstance().employeeBox.length; i++) {
      EmployeeData employeeData =
          HiveManager.getInstance().employeeBox.getAt(i) as EmployeeData;
      if (employeeData.id == event.employeeData?.id) {
        index = i;
      }
    }
    HiveManager.getInstance()
        .deletePerson(index!, HiveManager.getInstance().employeeBox);
    Snackbars.showGeneralSnackbar("Deleted SuccessFully");
    emit(RefreshState());
  }

  FutureOr<void> selectRoleEvent(
      SelectRoleEvent event, Emitter<EmployeeBlocState> emit) {
    emit(SelectRoleState(data: event.role));
  }

  FutureOr<void> selectFromDateEvent(
      SelectFromDateEvent event, Emitter<EmployeeBlocState> emit) {
    emit(SelectFromDateState(formDate: event.fromDate));
  }

  FutureOr<void> selectToDateEvent(
      SelectToDateEvent event, Emitter<EmployeeBlocState> emit) {
    emit(SelectToDateState(toDate: event.toDate));
  }

  List<EmployeeData>? getCurrentEmployeeList(
      {required List<EmployeeData>? employeeData}) {
    List<EmployeeData>? _employeeData = [];
    employeeData?.forEach((element) {
      if (element.toDate?.isEmpty ?? false) {
        _employeeData.add(element);
      }
    });
    return _employeeData;
  }

  List<EmployeeData>? getPreviousEmployeeList(
      {required List<EmployeeData> employeeData}) {
    List<EmployeeData>? _employeeData = [];
    employeeData?.forEach((element) {
      if (element.toDate?.isNotEmpty ?? false) {
        _employeeData.add(element);
      }
    });
    return _employeeData;
  }

  FutureOr<void> editEmployeeActionEvent(
      EditEmployeeActionEvent event, Emitter<EmployeeBlocState> emit) async {
    int? index;

    for (int i = 0; i < HiveManager.getInstance().employeeBox.length; i++) {
      EmployeeData employeeData =
          HiveManager.getInstance().employeeBox.getAt(i) as EmployeeData;
      if (employeeData.id == event.employeeDate?.id) {
        index = i;
      }
    }
    emit(EditEmployeeActionState(
        index: index, employeeData: event.employeeDate));
  }
}

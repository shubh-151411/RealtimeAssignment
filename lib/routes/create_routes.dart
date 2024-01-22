import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations/bloc/bloc/employee_bloc.dart';
import 'package:realtime_innovations/presentations/employeeDetail/add_edit_employee.dart';
import 'package:realtime_innovations/presentations/home/home.dart';
import 'package:realtime_innovations/routes/routesconstant.dart';

Route<dynamic>? createRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case "/home":
      return MaterialPageRoute(builder: (context) => const Home());

    case "/add_edit_employee":
      Map data = {};
      if (routeSettings.arguments != null) {
        data = routeSettings.arguments as Map;
      }

      return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
                value: EmployeeBloc(),
                child: AddorEditEmployee(
                  employeeData: data['employeeData'],
                  index: data['index'],
                ),
              ));
    default:
      return MaterialPageRoute(builder: (context) => const Home());
  }
}

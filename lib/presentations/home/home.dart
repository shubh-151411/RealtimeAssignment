import 'package:flutter/material.dart';
import 'package:realtime_innovations/bloc/bloc/employee_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations/presentations/EmployeeList/employee_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EmployeeBloc(), child: EmplopyeeList());
  }
}

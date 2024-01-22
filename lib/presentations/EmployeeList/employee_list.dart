import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:realtime_innovations/bloc/bloc/employee_bloc.dart';
import 'package:realtime_innovations/data/model/employee_data.dart';
import 'package:realtime_innovations/routes/routesconstant.dart';
import 'package:realtime_innovations/utils/assets/icon_assets.dart';
import 'package:realtime_innovations/utils/colors/colors.dart';
import 'package:realtime_innovations/utils/decoration/size_config.dart';
import 'package:realtime_innovations/utils/decoration/text_decoration.dart';
import 'package:flutter_slidable/src/slidable.dart';

class EmplopyeeList extends StatefulWidget {
  const EmplopyeeList({super.key});

  @override
  State<EmplopyeeList> createState() => _EmplopyeeListState();
}

class _EmplopyeeListState extends State<EmplopyeeList> {
  EmployeeBloc? employeeBloc;
  @override
  void initState() {
    super.initState();
    employeeBloc = context.read<EmployeeBloc>()..add(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryBlue,
          elevation: 0.0,
          title: Text(
            "Employee List",
            style: normalTextStyle.copyWith(fontSize: 16),
          ),
        ),
        body: BlocConsumer<EmployeeBloc, EmployeeBlocState>(
          bloc: employeeBloc,
          listener: (context, state) {
            if (state is RefreshState) {
              employeeBloc?.add(InitialEvent());
            }
            if (state is EditEmployeeActionState) {
              Navigator.pushNamed(
                  context, RealTimeInnovationsRoute.add_edit_employee,
                  arguments: {
                    'employeeData': state.employeeData,
                    'index': state.index,
                  }).then((value) {
                employeeBloc?.add(InitialEvent());
              });
            }
          },
          builder: (context, state) {
            if (state is EmployeeResultState) {
              return employeeListView(
                  currentEmployeeData: state.currentEmployeeData,
                  previousEmployeeData: state.previousEmployeeData);
            }
            if (state is EmployeeEmptyState) {
              return noListFound();
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget noListFound() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
        bottom: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    IconPath.no_person_found,
                    scale: 5,
                  ),
                  Text(
                    "No employee records found",
                    style: normalTextStyle.copyWith(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                      context, RealTimeInnovationsRoute.add_edit_employee)
                  .then((value) {
                employeeBloc?.add(InitialEvent());
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: primaryBlue, borderRadius: BorderRadius.circular(8.0)),
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget employeeListView(
      {List<EmployeeData>? currentEmployeeData,
      List<EmployeeData>? previousEmployeeData}) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (currentEmployeeData?.isNotEmpty ?? false)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: tilesColor,
                        padding: const EdgeInsets.only(
                            left: 10, top: 20, bottom: 20),
                        child: Text(
                          'Current Employees',
                          style: normalTextStyle.copyWith(color: primaryBlue),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, top: 20, bottom: 20),
                        color: Colors.white,
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: currentEmployeeData?.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key('${currentEmployeeData?[index].id}'),
                                onDismissed: (direction) {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    employeeBloc?.add(DeleteEmployeeEvent(
                                        employeeData:
                                            currentEmployeeData?[index]));
                                  }
                                },
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Color(0xffF34642),
                                  child: ImageIcon(AssetImage(IconPath.delete_icon),color: Colors.white),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 20.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    employeeBloc?.add(EditEmployeeActionEvent(
                                        employeeDate:
                                            currentEmployeeData?[index]));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: SizeConfig.height! * 0.03),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentEmployeeData?[index].name ??
                                              '',
                                          style: normalTextStyle.copyWith(
                                              color: textColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        Text(
                                          currentEmployeeData?[index].role ??
                                              '',
                                          style: normalTextStyle.copyWith(
                                              color: roleColor),
                                        ),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        Text(
                                          "From ${currentEmployeeData?[index].fromDate}",
                                          style: normalTextStyle.copyWith(
                                              color: roleColor),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                if (previousEmployeeData?.isNotEmpty ?? false)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: tilesColor,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                            left: 10, top: 20, bottom: 20),
                        child: Text(
                          'Previous Employees',
                          style: normalTextStyle.copyWith(color: primaryBlue),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, top: 20, bottom: 20),
                        color: Colors.white,
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: previousEmployeeData?.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key('${previousEmployeeData?[index].id}'),
                                onDismissed: (direction) {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    employeeBloc?.add(DeleteEmployeeEvent(
                                        employeeData:
                                            previousEmployeeData?[index]));
                                  }
                                },
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Color(0xffF34642),
                                  child: ImageIcon(AssetImage(IconPath.delete_icon),color: Colors.white),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 20.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    employeeBloc?.add(EditEmployeeActionEvent(
                                        employeeDate:
                                            previousEmployeeData?[index]));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: SizeConfig.height! * 0.03),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          previousEmployeeData?[index].name ??
                                              '',
                                          style: normalTextStyle.copyWith(
                                              color: textColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        Text(
                                          previousEmployeeData?[index].role ??
                                              '',
                                          style: normalTextStyle.copyWith(
                                              color: roleColor),
                                        ),
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              previousEmployeeData?[index]
                                                      .fromDate ??
                                                  '',
                                              style: normalTextStyle.copyWith(
                                                  color: roleColor),
                                            ),
                                            Text(
                                              " - ${previousEmployeeData?[index].toDate}"
                                              '',
                                              style: normalTextStyle.copyWith(
                                                  color: roleColor),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
        Container(
          color: tilesColor,
          padding: const EdgeInsets.only(right: 10, bottom: 10, left: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Swipe left to delete',
                style: normalTextStyle.copyWith(color: roleColor),
              ),
              const SizedBox(
                width: 5.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                          context, RealTimeInnovationsRoute.add_edit_employee)
                      .then((value) {
                    employeeBloc?.add(InitialEvent());
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

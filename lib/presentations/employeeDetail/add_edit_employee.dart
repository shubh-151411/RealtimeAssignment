import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations/bloc/bloc/employee_bloc.dart';
import 'package:realtime_innovations/data/model/employee_data.dart';
import 'package:realtime_innovations/presentations/employeeDetail/custom_calender.dart';
import 'package:realtime_innovations/utils/assets/icon_assets.dart';
import 'package:realtime_innovations/utils/colors/colors.dart';
import 'package:realtime_innovations/utils/decoration/size_config.dart';
import 'package:realtime_innovations/utils/decoration/snack_bars.dart';
import 'package:realtime_innovations/utils/decoration/text_decoration.dart';
import 'package:uuid/uuid.dart';

class AddorEditEmployee extends StatefulWidget {
  final EmployeeData? employeeData;
  final int? index;
  const AddorEditEmployee({super.key, this.employeeData, this.index});

  @override
  State<AddorEditEmployee> createState() => _AddorEditEmployeeState();
}

class _AddorEditEmployeeState extends State<AddorEditEmployee> {
  TextEditingController? _nameController = TextEditingController();
  String? role;
  String? formDate;
  String? toDate;
  EmployeeBloc? employeeBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    _nameController?.text = widget.employeeData?.name ?? '';
    role = widget.employeeData?.role ?? '';
    formDate = widget.employeeData?.fromDate ?? '';
    toDate = widget.employeeData?.toDate ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: primaryBlue,
        title: Text(
          (widget.employeeData == null)
              ? "Add Employee Details"
              : 'Edit Employee Details',
          style: normalTextStyle.copyWith(fontSize: 16),
        ),
        actions: [
          (widget.employeeData != null)
              ? Image.asset(
                  IconPath.delete_icon,
                  scale: 2.5,
                )
              : const SizedBox()
        ],
      ),
      body: BlocConsumer<EmployeeBloc, EmployeeBlocState>(
        bloc: employeeBloc,
        listener: (context, state) {
          if (state is RefreshState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: SizeConfig.width! * 0.03,
                  right: SizeConfig.width! * 0.03,
                  top: SizeConfig.height! * 0.02,
                ),
                padding: EdgeInsets.only(left: SizeConfig.width! * 0.02),
                decoration: BoxDecoration(
                  border: Border.all(color: borderGrey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      IconPath.person_icon,
                      width: SizeConfig.width! * 0.06,
                      height: SizeConfig.width! * 0.06,
                      color: primaryBlue,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: TextFormField(
                          controller: _nameController,
                          style: normalTextStyle.copyWith(color: textColor),
                          scrollPadding: EdgeInsets.zero,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-z A-Z]')),
                          ],
                          decoration: InputDecoration(
                              border:
                                  InputBorder.none, // Remove internal border
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Employee name',
                              hintStyle:
                                  normalTextStyle.copyWith(color: roleColor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              BlocBuilder<EmployeeBloc, EmployeeBlocState>(
                builder: (context, state) {
                  if (state is SelectRoleState) {
                    role = state.data;
                  }
                  return InkWell(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      showRoleModelBottomSheet(onTap: (value) {
                        if (value != null) {
                          employeeBloc?.add(SelectRoleEvent(role: value));
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: SizeConfig.width! * 0.03,
                        right: SizeConfig.width! * 0.03,
                        top: SizeConfig.height! * 0.02,
                      ),
                      padding: EdgeInsets.only(
                          left: SizeConfig.width! * 0.02,
                          top: SizeConfig.height! * 0.015,
                          bottom: SizeConfig.height! * 0.015,
                          right: SizeConfig.width! * 0.02),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: borderGrey), // Container border color
                        borderRadius: BorderRadius.circular(
                            8.0), // Optional: add container border radius
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            IconPath.role,
                            width: SizeConfig.width! * 0.06,
                            height: SizeConfig.width! * 0.06,
                            color:
                                primaryBlue, // Adjust the image height as needed
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              (role?.isEmpty ?? true)
                                  ? "Select Role"
                                  : role ?? '',
                              style: normalTextStyle.copyWith(
                                  color: (role?.isNotEmpty ?? false)
                                      ? textColor
                                      : roleColor),
                            ),
                          )),
                          Image.asset(
                            IconPath.arrow_dropdown,
                            width: SizeConfig.width! * 0.06,
                            height: SizeConfig.width! * 0.06,
                            color:
                                primaryBlue, // Adjust the image height as needed
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: SizeConfig.width! * 0.03,
                  right: SizeConfig.width! * 0.03,
                  top: SizeConfig.height! * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: BlocBuilder<EmployeeBloc, EmployeeBlocState>(
                        builder: (context, state) {
                          if (state is SelectFromDateState) {
                            formDate = state.formDate;
                          }
                          return InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CalendarDialog(
                                    activeDate: widget?.employeeData?.fromDate,
                                    selectedDate: formDate,
                                    isNoDate: true,
                                    onTap: (value) {
                                      // formDate = value;
                                      employeeBloc?.add(
                                          SelectFromDateEvent(fromDate: value));
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.width! * 0.02,
                                  top: SizeConfig.height! * 0.012,
                                  bottom: SizeConfig.height! * 0.012,
                                  right: SizeConfig.width! * 0.02),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        borderGrey), // Container border color
                                borderRadius: BorderRadius.circular(
                                    8.0), // Optional: add container border radius
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    IconPath.calender_icon,
                                    width: SizeConfig.width! * 0.06,
                                    height: SizeConfig.width! * 0.06,
                                    color:
                                        primaryBlue, // Adjust the image height as needed
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    (formDate?.isNotEmpty ?? false)
                                        ? formDate!
                                        : 'From Date',
                                    style: normalTextStyle.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: (formDate?.isNotEmpty ?? false)
                                            ? textColor
                                            : roleColor),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        IconPath.arrow_right,
                        width: SizeConfig.width! * 0.03,
                        height: SizeConfig.width! * 0.03,
                        color: primaryBlue,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: BlocBuilder<EmployeeBloc, EmployeeBlocState>(
                        builder: (context, state) {
                          if (state is SelectToDateState) {
                            toDate = state.toDate;
                          }
                          return InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CalendarDialog(
                                    activeDate: widget?.employeeData?.toDate,
                                    selectedDate: toDate,
                                    fromDate: formDate,
                                    isNoDate: false,
                                    onTap: (value) {
                                      if (value?.isNotEmpty ?? false) {
                                        employeeBloc?.add(
                                            SelectToDateEvent(toDate: value));
                                      }else{
                                        employeeBloc?.add(
                                            SelectToDateEvent(toDate: ""));

                                      }
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.width! * 0.02,
                                  top: SizeConfig.height! * 0.015,
                                  bottom: SizeConfig.height! * 0.015,
                                  right: SizeConfig.width! * 0.02),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        borderGrey), // Container border color
                                borderRadius: BorderRadius.circular(
                                    8.0), // Optional: add container border radius
                              ),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        IconPath.calender_icon,
                                        width: SizeConfig.width! * 0.06,
                                        height: SizeConfig.width! * 0.06,
                                        color:
                                            primaryBlue, // Adjust the image height as needed
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    (toDate?.isNotEmpty ?? false)
                                        ? toDate!
                                        : 'To Date',
                                    style: normalTextStyle.copyWith(
                                        color: (toDate?.isNotEmpty ?? false)
                                            ? textColor
                                            : roleColor),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: borderGrey)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        decoration: BoxDecoration(
                          color: blueLight,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: normalTextStyle.copyWith(color: primaryBlue),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      onTap: () {
                        if (role == null) {
                          Snackbars.showErrorSnackbar("Please choose role");
                          return;
                        }
                        if (formDate == null) {
                          Snackbars.showErrorSnackbar("Please choose date");
                          return;
                        }
                        if (_nameController?.text.isEmpty ?? true) {
                          Snackbars.showErrorSnackbar("Please enter your name");
                          return;
                        }
                        EmployeeData employeeData = EmployeeData()
                          ..id = (widget.employeeData == null)
                              ? const Uuid().v4()
                              : widget.employeeData?.id
                          ..name = _nameController?.text
                          ..role = role
                          ..fromDate = formDate
                          ..toDate = toDate ?? '';
                        if (widget.employeeData == null) {
                          employeeBloc?.add(
                              AddEmployeeEvent(employeeDate: employeeData));
                        } else {
                          employeeBloc?.add(EditEmployeeEvent(
                              employeeDate: employeeData, index: widget.index));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: normalTextStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Future showRoleModelBottomSheet({Function(String?)? onTap}) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  onTap!('Product Designer');
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Product Designer',
                    style: normalTextStyle.copyWith(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  onTap!('Flutter Developer');
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Flutter Developer',
                    style: normalTextStyle.copyWith(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  onTap!('QA Tester');
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'QA Tester',
                    style: normalTextStyle.copyWith(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  onTap!('Product Owner');
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Product Owner',
                    style: normalTextStyle.copyWith(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:realtime_innovation_manage_employees/src/adding_an_employee/add_employee_cubit.dart';
import 'package:realtime_innovation_manage_employees/src/helper/date_selector.dart';
import 'package:realtime_innovation_manage_employees/src/helper/helper.dart';
import 'package:realtime_innovation_manage_employees/src/models/employee.dart';

class FormWidget extends StatelessWidget {
  FormWidget({
    super.key,
    this.employee,
    required this.formState,
    required this.onSubmitted,
  }) {
    nameField.text = employee?.name ?? "";
    roleField.text = employee?.role ?? "";
    dateList['date1'] = employee?.fromDate;
    dateList['date2'] = employee?.toDate;
    if (dateList['date1'] != null) {
      fromDate.text = formatter.format(dateList['date1'] as DateTime);
    }
    if (dateList['date2'] != null) {
      toDate.text = formatter.format(dateList['date2'] as DateTime);
    }
  }
  final AddEmployeeStateInitial formState;
  final Employee? employee;
  final Function(Employee emp) onSubmitted;
  final nameField = TextEditingController();
  final roleField = TextEditingController();
  final fromDate = TextEditingController();
  final toDate = TextEditingController();
  final Map<String, DateTime?> dateList = {
    "date1": null,
    "date2": null,
  };
  final _formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('d MMM yyyy');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameField,
                    validator: inputValidator,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: Icon(
                        Icons.person_outlined,
                        color: Colors.blueAccent,
                      ),
                      hintText: "Employee name",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: roleField,
                    validator: inputValidator,
                    onTap: () => onDropDownPick(context),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: Icon(
                        Icons.work_outline,
                        color: Colors.blueAccent,
                      ),
                      hintText: "Select role",
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blueAccent,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                        color: Colors.grey,
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: fromDate,
                            validator: inputValidator,
                            onTap: () => onPickDate(context, 1),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              prefixIcon: Icon(
                                Icons.today_outlined,
                                color: Colors.blueAccent,
                              ),
                              hintText: "No Date",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.arrow_right_alt_sharp,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: toDate,
                            validator: inputValidator,
                            onTap: () => onPickDate(context, 2),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                prefixIcon: Icon(
                                  Icons.today_outlined,
                                  color: Colors.blueAccent,
                                ),
                                hintText: "No Date",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: double.infinity,
              height: 60,
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                width: 0.5,
                color: Colors.grey,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          onSubmitted(Employee(
                            id: 23 + Random().nextInt(1000),
                            name: nameField.text,
                            role: roleField.text,
                            fromDate: dateList['date1'] as DateTime,
                            toDate: dateList['date2'] as DateTime,
                          ));
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              )),
        ),
      ],
    );
  }

  void onDropDownPick(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: formState.roleList
                    .map<InkWell>((it) => InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            roleField.value = TextEditingValue(text: it);
                          },
                          child: Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.3, color: Colors.grey))),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Center(child: Text(it))),
                        ))
                    .toList()),
          );
        });
  }

  void onPickDate(BuildContext context, int mode) async {
    try {
      final Map<String, DateTime?>? dateListHere =
          await Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false, // Set opaque to false for transparency
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return DateSelector(
              selectedDate1: dateList.isNotEmpty ? dateList['date1'] : null,
              selectedDate2: dateList.length == 2 ? dateList['date2'] : null,
              mode: mode,
            );
          },
        ),
      );
      if (dateListHere != null) {
        dateList.clear();
        dateList.addAll(dateListHere);
        if (dateList['date1'] != null) {
          fromDate.text = formatter.format(dateList['date1'] as DateTime);
        }
        if (dateList['date2'] != null) {
          toDate.text = formatter.format(dateList['date2'] as DateTime);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }
}

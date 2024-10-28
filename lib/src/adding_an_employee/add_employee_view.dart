import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovation_manage_employees/src/adding_an_employee/add_employee_cubit.dart';
import 'package:realtime_innovation_manage_employees/src/adding_an_employee/form_widget.dart';
import 'package:realtime_innovation_manage_employees/src/models/employee.dart';
import 'package:realtime_innovation_manage_employees/src/repository/employee_repository.dart';

class AddEmployeeView extends StatelessWidget {
  const AddEmployeeView({super.key, this.employee});
  final Employee? employee;
  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddEmployeeCubit(
            employeeRepository: context.read<EmployeeRepository>()),
        child: Builder(builder: (context) {
          return Material(
            child: BlocBuilder<AddEmployeeCubit, AddEmployeeState>(
              bloc: context.read<AddEmployeeCubit>(),
              builder: (context, state) {
                if (state is AddEmployeeStateMessage) {
                  return Scaffold(
                      appBar: AppBar(
                        leadingWidth: 0,
                        automaticallyImplyLeading: false,
                        title: Text(
                            '${employee == null ? 'Add' : 'Edit'} Employee Details'),
                      ),
                      body: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(state.message),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text("Ok"))
                          ],
                        ),
                      ));
                }
                if (state is AddEmployeeStateInitial) {
                  return Scaffold(
                    appBar: AppBar(
                      leadingWidth: 0,
                      automaticallyImplyLeading: false,
                      title: Text(
                          '${employee == null ? 'Add' : 'Edit'} Employee Details'),
                      actions: [
                        if (employee != null)
                          IconButton(
                            onPressed: () {
                              context
                                  .read<AddEmployeeCubit>()
                                  .deleteEmployee(employee!);
                            },
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                    body: FormWidget(
                      employee: employee,
                      formState: state,
                      onSubmitted: (emp) {
                        context.read<AddEmployeeCubit>().addEmployee(emp);
                      },
                    ),
                  );
                }
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              },
            ),
          );
        }));
  }
}

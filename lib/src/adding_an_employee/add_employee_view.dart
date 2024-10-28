import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovation_manage_employees/src/adding_an_employee/add_employee_cubit.dart';
import 'package:realtime_innovation_manage_employees/src/adding_an_employee/form_widget.dart';
import 'package:realtime_innovation_manage_employees/src/repository/employee_repository.dart';

class AddEmployeeView extends StatelessWidget {
  const AddEmployeeView({super.key, this.employeeId});
  final int? employeeId;
  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: Text('${employeeId == null ? 'Add' : 'Edit'} Employee Details'),
      ),
      body: BlocProvider(
        create: (context) => AddEmployeeCubit(
            employeeRepository: context.read<EmployeeRepository>()),
        child: Builder(builder: (context) {
          return BlocBuilder<AddEmployeeCubit, AddEmployeeState>(
            bloc: context.read<AddEmployeeCubit>(),
            builder: (context, state) {
              if (state is AddEmployeeStateMessage) {
                return Container(
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
                );
              }
              if (state is AddEmployeeStateInitial) {
                return FormWidget(
                  formState: state,
                  onSubmitted: (emp) {
                    context.read<AddEmployeeCubit>().addEmployee(emp);
                  },
                );
              }
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            },
          );
        }),
      ),
    );
  }
}

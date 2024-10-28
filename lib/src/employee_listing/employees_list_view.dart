import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovation_manage_employees/src/adding_an_employee/add_employee_view.dart';
import 'package:realtime_innovation_manage_employees/src/employee_listing/employee_listing_cubit.dart';
import 'package:realtime_innovation_manage_employees/src/employee_listing/employee_tile.dart';
import 'package:realtime_innovation_manage_employees/src/repository/employee_repository.dart';

class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeListingCubit(
          employeeRepository: context.read<EmployeeRepository>())
        ..loadEmployees(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Employee List'),
            ),
            body: BlocBuilder<EmployeeListingCubit, EmployeeListingState>(
                bloc: context.read<EmployeeListingCubit>(),
                builder: (context, state) {
                  if (state is EmployeeStateFailed) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(state.errorMessage),
                    );
                  }
                  if (state is EmployeeStateEmpty) {
                    return Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Image.asset('assets/images/empty_image.png'),
                      ),
                    );
                  }
                  if (state is EmployeeListingLoaded) {
                    return Scaffold(
                        floatingActionButton: (state is! EmployeeStateLoading)
                            ? FloatingActionButton(
                                backgroundColor: Colors.blueAccent,
                                onPressed: () async {
                                  final bool? isUpdated =
                                      await Navigator.pushNamed(
                                    context,
                                    AddEmployeeView.routeName,
                                  );
                                  if (context.mounted && isUpdated == true) {
                                    context
                                        .read<EmployeeListingCubit>()
                                        .loadEmployees();
                                  }
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox.shrink(),
                        backgroundColor: const Color(0xfff2f2f2),
                        body: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (state.currentEmployees.isNotEmpty)
                                Container(
                                  color: const Color(0xfff2f2f2),
                                  padding: const EdgeInsets.all(
                                    12,
                                  ),
                                  width: double.infinity,
                                  child: const Text(
                                    "Current Employees",
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.currentEmployees.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = state.currentEmployees[index];
                                  return EmployeeTile(
                                    item: item,
                                  );
                                },
                              ),
                              if (state.exEmployees.isNotEmpty)
                                Container(
                                  color: const Color(0xfff2f2f2),
                                  padding: const EdgeInsets.all(
                                    12,
                                  ),
                                  width: double.infinity,
                                  child: const Text(
                                    "Previous Employees",
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.exEmployees.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = state.exEmployees[index];
                                  return EmployeeTile(
                                    item: item,
                                  );
                                },
                              ),
                              Container(
                                color: const Color(0xfff2f2f2),
                                padding: const EdgeInsets.all(
                                  12,
                                ),
                                width: double.infinity,
                                child: const Text(
                                  "Swipe left to delete",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                  }
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }),
          );
        },
      ),
    );
  }
}

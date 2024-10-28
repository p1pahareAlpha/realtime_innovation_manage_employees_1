import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:realtime_innovation_manage_employees/src/adding_an_employee/add_employee_view.dart';
import 'package:realtime_innovation_manage_employees/src/employee_listing/employee_listing_cubit.dart';
import 'package:realtime_innovation_manage_employees/src/models/employee.dart';

class EmployeeTile extends StatelessWidget {
  const EmployeeTile({
    super.key,
    required this.item,
  });

  final Employee item;

  @override
  Widget build(BuildContext context) {
    String fromDate = DateFormat('dd MMM, yyyy').format(item.fromDate);
    String toDate = DateFormat('dd MMM, yyyy').format(item.toDate);
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(item.toString()),
      background: Container(
        color: Colors.red,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete_outline_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          context.read<EmployeeListingCubit>().deleteEmployee(item);
        }
      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
                isThreeLine: true,
                title: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      item.role,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      (item.toDate.isAfter(
                              DateTime.now().add(const Duration(days: 1))))
                          ? "From $fromDate"
                          : "$fromDate - $toDate",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                onTap: () async {
                  final bool? isUpdated = await Navigator.pushNamed(
                    context,
                    AddEmployeeView.routeName,
                  );
                  if (context.mounted && isUpdated == true) {
                    context.read<EmployeeListingCubit>().loadEmployees();
                  }
                }),
            Container(
              height: 0.4,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

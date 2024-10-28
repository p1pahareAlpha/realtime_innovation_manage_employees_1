import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realtime_innovation_manage_employees/src/models/employee.dart';
import 'package:realtime_innovation_manage_employees/src/repository/employee_repository.dart';

part 'employee_listing_state.dart';

class EmployeeListingCubit extends Cubit<EmployeeListingState> {
  EmployeeListingCubit({required this.employeeRepository})
      : super(EmployeeStateLoading());
  final EmployeeRepository employeeRepository;
  void loadEmployees() async {
    emit(EmployeeStateLoading());
    await Future.delayed(const Duration(milliseconds: 1500));
    final employeeList = await employeeRepository.getEmployees();
    if (employeeList.isEmpty) {
      emit(EmployeeStateEmpty());
    } else {
      final List<Employee> pastEmployees = [];
      final List<Employee> presentEmployees = [];
      for (int i = 0; i < employeeList.length; i++) {
        final nowDate = DateTime.now();
        final todayEod = DateTime(
            nowDate.year, nowDate.month, nowDate.day, 23, 59, 59, 0, 0);
        if (employeeList[i].toDate.isAfter(todayEod)) {
          presentEmployees.add(employeeList[i]);
        } else {
          pastEmployees.add(employeeList[i]);
        }
      }
      employeeList.clear();
      emit(
        EmployeeListingLoaded(
          currentEmployees: presentEmployees,
          exEmployees: pastEmployees,
        ),
      );
    }
  }

  void deleteEmployee(Employee e1) async {
    emit(EmployeeStateLoading());
    await Future.delayed(const Duration(milliseconds: 1500));
    await employeeRepository.deleteEmployee(e1.id);
    final employeeList = await employeeRepository.getEmployees();
    if (employeeList.isEmpty) {
      emit(EmployeeStateEmpty());
    } else {
      final List<Employee> pastEmployees = [];
      final List<Employee> presentEmployees = [];
      for (int i = 0; i < employeeList.length; i++) {
        final nowDate = DateTime.now();
        final todayEod = DateTime(
            nowDate.year, nowDate.month, nowDate.day, 23, 59, 59, 0, 0);
        if (employeeList[i].toDate.isAfter(todayEod)) {
          presentEmployees.add(employeeList[i]);
        } else {
          pastEmployees.add(employeeList[i]);
        }
      }
      employeeList.clear();
      emit(
        EmployeeListingLoaded(
          currentEmployees: presentEmployees,
          exEmployees: pastEmployees,
        ),
      );
    }
  }
}

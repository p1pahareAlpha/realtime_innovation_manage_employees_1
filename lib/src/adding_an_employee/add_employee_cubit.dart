import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realtime_innovation_manage_employees/src/models/employee.dart';
import 'package:realtime_innovation_manage_employees/src/repository/employee_repository.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  final EmployeeRepository employeeRepository;
  AddEmployeeCubit({required this.employeeRepository})
      : super(AddEmployeeStateInitial());

  void addEmployee(Employee e1) async {
    emit(AddEmployeeStateLoading());
    await Future.delayed(const Duration(milliseconds: 1500));
    await employeeRepository.addEmployee(e1);
    emit(AddEmployeeStateMessage(
        message: "Employee Details were Added Successfully!"));
  }

  void deleteEmployee(Employee e1) async {
    emit(AddEmployeeStateLoading());
    await Future.delayed(const Duration(milliseconds: 1500));
    await employeeRepository.deleteEmployee(e1.id);
    emit(AddEmployeeStateMessage(
        message: "Employee details was removed successfully!"));
  }
}

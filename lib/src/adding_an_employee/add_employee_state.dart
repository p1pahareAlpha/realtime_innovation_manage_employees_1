part of 'add_employee_cubit.dart';

@immutable
abstract class AddEmployeeState {}

class AddEmployeeStateInitial extends AddEmployeeState {
  final List<String> roleList = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner",
  ];
}

class AddEmployeeStateLoading extends AddEmployeeState {}

class AddEmployeeStateMessage extends AddEmployeeState {
  final String message;
  AddEmployeeStateMessage({this.message = ""});
}

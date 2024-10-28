part of 'employee_listing_cubit.dart';

@immutable
abstract class EmployeeListingState {}

class EmployeeStateEmpty extends EmployeeListingState {}

class EmployeeStateLoading extends EmployeeListingState {}

class EmployeeStateFailed extends EmployeeListingState {
  final String errorMessage;
  EmployeeStateFailed({this.errorMessage = ""});
}

class EmployeeListingLoaded extends EmployeeListingState {
  final List<Employee> currentEmployees;
  final List<Employee> exEmployees;
  EmployeeListingLoaded({
    this.currentEmployees = const [],
    this.exEmployees = const [],
  });
}

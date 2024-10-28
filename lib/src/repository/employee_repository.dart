import 'package:realtime_innovation_manage_employees/src/models/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeRepository {
  late SharedPreferences? _prefs;

  EmployeeRepository() {
    SharedPreferences.getInstance().then((onValue) => _prefs = onValue);
  }

  Future<List<Employee>> getEmployees() async {
    final List<String>? employeesString = _prefs?.getStringList("employees");
    if (employeesString?.isNotEmpty == false) {
      return [];
    } else {
      return employeesString
              ?.map<Employee>((str) => Employee.fromString(str))
              .toList() ??
          [];
    }
  }

  Future setEmployees(List<Employee> employees) async {
    final newlist = employees.map<String>((emp) => emp.toString()).toList();
    await _prefs?.setStringList("employees", newlist);
  }

  Future addEmployee(Employee e1) async {
    final prevList = await getEmployees();
    prevList.add(e1);
    await setEmployees(prevList);
    return prevList;
  }

  Future editEmployee(Employee e1, int id) async {
    final prevList = await getEmployees();
    prevList.removeWhere((it) => it.id == id);
    prevList.add(e1);
    await setEmployees(prevList);
    return prevList;
  }

  Future deleteEmployee(int id) async {
    final prevList = await getEmployees();
    prevList.removeWhere((test) => test.id == id);
    await setEmployees(prevList);
    return prevList;
  }
}

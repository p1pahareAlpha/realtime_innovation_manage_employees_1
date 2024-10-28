class Employee {
  Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.fromDate,
    required this.toDate,
  });

  late final int id;
  late final String name;
  late final String role;
  late final DateTime fromDate;
  late final DateTime toDate;

  @override
  String toString() {
    return "$id,$name,$role,${fromDate.toIso8601String()},${toDate.toIso8601String()}";
  }

  Employee.fromString(String input) {
    List<String> inputs = input.split(",");
    id = int.parse(inputs[0]);
    name = inputs[1];
    role = inputs[2];
    fromDate = DateTime.parse(inputs[3]);
    toDate = DateTime.parse(inputs[4]);
  }
}

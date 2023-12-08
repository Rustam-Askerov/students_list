class DepartmentModel {
  final int id;
  final String departmentName;
  final String faculty;

  DepartmentModel(
      {required this.id, required this.departmentName, required this.faculty});

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
        id: json['id'],
        departmentName: json['department_name'],
        faculty: json['faculty']);
  }
}

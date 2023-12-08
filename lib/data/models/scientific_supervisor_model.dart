class ScientificSupervisorModel {
  final int id;
  final String fullName;
  final String post;
  final String? academicDegree;
  final int departmentId;

  ScientificSupervisorModel(
      {required this.id,
      required this.fullName,
      required this.post,
      required this.academicDegree,
      required this.departmentId});

  factory ScientificSupervisorModel.fromJson(Map<String, dynamic> json) {
    return ScientificSupervisorModel(
        id: json['id'],
        fullName: json['full_name'],
        post: json['post'],
        academicDegree: json['academic_degree'],
        departmentId: json['fk_department_id']);
  }
}

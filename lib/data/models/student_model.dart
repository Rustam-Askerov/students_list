class StudentModel {
  final int id;
  final String fullName;
  final String groupName;
  final int studentIDnumber;
  final int? departmentID;
  final int? scientificSupervisorID;
  final String stage;
  final int dateOfAdmission;
  final int? dateOfGraduation;
  final bool? isGraduate;

  StudentModel(
      {required this.id,
      required this.fullName,
      required this.groupName,
      required this.studentIDnumber,
      required this.departmentID,
      required this.scientificSupervisorID,
      required this.stage,
      required this.dateOfAdmission,
      required this.dateOfGraduation,
      required this.isGraduate});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
        id: json['id'],
        fullName: json['full_name'],
        groupName: json['group_name'],
        studentIDnumber: json['student_id_number'],
        departmentID: json['fk_department_id'],
        scientificSupervisorID: json['fk_scientific_supervisor_id'],
        stage: json['stage'],
        dateOfAdmission: json['date_of_admission'] != null
            ? int.parse(json['date_of_admission'].toString().substring(0, 4))
            : json['date_of_admission'],
        dateOfGraduation: json['date_of_graduate'] != null
            ? int.parse(json['date_of_graduate'].toString().substring(0, 4))
            : json['date_of_graduate'],
        isGraduate: json['is_graduate']);
  }
}

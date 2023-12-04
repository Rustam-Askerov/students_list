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
      this.departmentID,
      this.scientificSupervisorID,
      required this.stage,
      required this.dateOfAdmission,
      required this.dateOfGraduation,
      required this.isGraduate});
}

class WorkModel {
  final int id;
  final String name;
  final int fkStudentId;
  final String workType;
  final String? assesment;
  final String? workDueDate;

  WorkModel(
      {required this.id,
      required this.name,
      required this.fkStudentId,
      required this.workType,
      required this.assesment,
      required this.workDueDate});

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
        id: json['id'],
        name: json['work_name'],
        fkStudentId: json['fk_student_id'],
        workType: json['work_type'],
        assesment: json['assesment'],
        workDueDate: json['work_due_date']);
  }
}

import 'package:students_list/data/models/student_model.dart';

abstract class StudentsListRepository {
  Future<List<StudentModel>> getStudents();
  Future<List<StudentModel>> getStudentByID(int id);
  Future<void> createStudent(
    String fullName,
    String groupName,
    int studentIDnumber,
    int? departmentID,
    int? scientificSupervisorID,
    String stage,
    int dateOfAdmission,
    int? dateOfGraduation,
    bool? isGraduate,
  );

  Future<void> editStudent(
    int id,
    String fullName,
    String groupName,
    int studentIDnumber,
    int? departmentID,
    int? scientificSupervisorID,
    String stage,
    int dateOfAdmission,
    int? dateOfGraduation,
    bool? isGraduate,
  );

  Future<void> deleteStudent(int id);
}

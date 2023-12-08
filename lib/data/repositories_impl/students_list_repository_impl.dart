import 'package:students_list/data/datasources/students_list_remote_datasource.dart';
import 'package:students_list/data/models/student_model.dart';
import 'package:students_list/domain/repositories/students_repository.dart';

class StudentsListRepositoryImpl implements StudentsListRepository {
  final StudentsListDataSource studentsListDataSource;

  StudentsListRepositoryImpl({required this.studentsListDataSource});

  @override
  Future<StudentModel> createStudent(
      String fullName,
      String groupName,
      int studentIDnumber,
      int? departmentID,
      int? scientificSupervisorID,
      String stage,
      int dateOfAdmission,
      int? dateOfGraduation,
      bool? isGraduate) async {
    return await studentsListDataSource.createStudent(
        fullName,
        groupName,
        studentIDnumber,
        departmentID,
        scientificSupervisorID,
        stage,
        dateOfAdmission,
        dateOfGraduation,
        isGraduate);
  }

  @override
  Future<void> deleteStudent(int id) async {
    studentsListDataSource.deleteStudent(id);
  }

  @override
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
      bool? isGraduate) async {
    await studentsListDataSource.editStudent(
        id,
        fullName,
        groupName,
        studentIDnumber,
        departmentID,
        scientificSupervisorID,
        stage,
        dateOfAdmission,
        dateOfGraduation,
        isGraduate);
  }

  @override
  Future<List<StudentModel>> getStudentByID(int id) async {
    return await studentsListDataSource.getStudentByID(id);
  }

  @override
  Future<List<StudentModel>> getStudents() async{
    return await studentsListDataSource.getStudents();
  }
}

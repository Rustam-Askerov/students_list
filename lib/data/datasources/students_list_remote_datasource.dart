import 'dart:convert';
import 'dart:developer';
import 'package:students_list/data/models/student_model.dart';
import 'package:http/http.dart' as http;
import 'package:students_list/utils/connection_mode.dart';

abstract class StudentsListDataSource {
  Future<List<StudentModel>> getStudents();
  Future<List<StudentModel>> getStudentByID(int id);
  Future<StudentModel> createStudent(
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

  Future<StudentModel> editStudent(
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

class StudentsListRemoteDataSource extends StudentsListDataSource {
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
    final uri =
        Uri.http(ConnectionMode.getConnectionUrl(), '/api/create_new_student');
    final response = await http.post(
      uri,
      headers: ConnectionMode().getHeaders(),
      body: json.encode({
        'full_name': fullName,
        'group_name': groupName,
        'student_id_number': studentIDnumber,
        'fk_department_id': departmentID,
        'fk_scientific_supervisor_id': scientificSupervisorID,
        'stage': stage,
        'date_of_admission': '$dateOfAdmission-01-08',
        'date_of_graduate': dateOfGraduation != null
            ? '$dateOfGraduation-01-08'
            : dateOfGraduation,
        'is_graduate': isGraduate
      }),
    );
    if (response.statusCode == 200) {
      final student = json.decode(response.body);
      return StudentModel.fromJson(student);
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<StudentModel> editStudent(
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
    final uri =
        Uri.http(ConnectionMode.getConnectionUrl(), '/api/update_student/$id');
    final response = await http.put(
      uri,
      headers: ConnectionMode().getHeaders(),
      body: json.encode({
        'id': id,
        'full_name': fullName,
        'group_name': groupName,
        'student_id_number': studentIDnumber,
        'fk_department_id': departmentID,
        'fk_scientific_supervisor_id': scientificSupervisorID,
        'stage': stage,
        'date_of_admission': '$dateOfAdmission-01-08',
        'date_of_graduate': dateOfGraduation != null
            ? '$dateOfGraduation-01-08'
            : dateOfGraduation,
        'is_graduate': isGraduate
      }),
    );
    if (response.statusCode == 200) {
      final student = json.decode(response.body);
      return StudentModel.fromJson(student);
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<void> deleteStudent(int id) async {
    final uri =
        Uri.http(ConnectionMode.getConnectionUrl(), '/api/delete_students/$id');
    final response = await http.delete(
      uri,
      headers: ConnectionMode().getHeaders(),
    );
    if (response.statusCode == 200) {
      log(response.body);
    }
  }

  @override
  Future<List<StudentModel>> getStudentByID(int id) {
    return _getDataFromUrl(
        '${ConnectionMode.getConnectionUrl()}/api/get_students_by_id/$id');
  }

  @override
  Future<List<StudentModel>> getStudents() {
    return _getDataFromUrl('/api/get_students');
  }

  Future<List<StudentModel>> _getDataFromUrl(String url) async {
    final uri = Uri.http(
      ConnectionMode.getConnectionUrl(),
      url,
    );
    final response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      final students = json.decode(response.body);
      return (students as List)
          .map((students) => StudentModel.fromJson(students))
          .toList();
    } else {
      return [];
    }
  }
}

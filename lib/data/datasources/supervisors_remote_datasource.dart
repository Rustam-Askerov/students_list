import 'dart:convert';
import 'dart:developer';
import 'package:students_list/data/models/scientific_supervisor_model.dart';
import 'package:students_list/utils/connection_mode.dart';
import 'package:http/http.dart' as http;

abstract class ScientificSupervisorDataSource {
  Future<List<ScientificSupervisorModel>> getSupervisors();
  Future<List<ScientificSupervisorModel>> getSupervisorByID(int id);
  Future<ScientificSupervisorModel> createSupervisor(
    String fullName,
    String post,
    String academicDegree,
    int departmentId,
  );

  Future<ScientificSupervisorModel> editSupervisor(
    int id,
    String fullName,
    String post,
    String academicDegree,
    int departmentId,
  );

  Future<void> deleteStudent(int id);
}

class ScientificSupervisorRemoteDataSource
    extends ScientificSupervisorDataSource {
  @override
  Future<ScientificSupervisorModel> createSupervisor(String fullName,
      String post, String academicDegree, int departmentId) async {
    final uri = Uri.http(
        ConnectionMode.getConnectionUrl(), '/api/create_new_supervisor');
    final response = await http.post(
      uri,
      headers: ConnectionMode().getHeaders(),
      body: json.encode({
        'full_name': fullName,
        'post': post,
        'academic_degree': academicDegree != '' ? academicDegree : null,
        'fk_department_id': departmentId,
      }),
    );
    if (response.statusCode == 200) {
      final supervisors = json.decode(response.body);
      return ScientificSupervisorModel.fromJson(supervisors);
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<void> deleteStudent(int id) async {
    final uri = Uri.http(
        ConnectionMode.getConnectionUrl(), '/api/delete_supervisor/$id');
    final response = await http.delete(
      uri,
      headers: ConnectionMode().getHeaders(),
    );
    if (response.statusCode == 200) {
      log(response.body);
    }
  }

  @override
  Future<ScientificSupervisorModel> editSupervisor(int id, String fullName,
      String post, String academicDegree, int departmentId) async {
    final uri = Uri.http(
        ConnectionMode.getConnectionUrl(), '/api/update_supervisor/$id');
    final response = await http.put(
      uri,
      headers: ConnectionMode().getHeaders(),
      body: json.encode({
        'id': id,
        'full_name': fullName,
        'post': post,
        'academic_degree': academicDegree,
        'fk_department_id': departmentId,
      }),
    );
    if (response.statusCode == 200) {
      final supervisors = json.decode(response.body);
      return ScientificSupervisorModel.fromJson(supervisors);
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<List<ScientificSupervisorModel>> getSupervisorByID(int id) async {
    return await _getDataFromUrl('/api/get_supervisor_by_id/$id');
  }

  @override
  Future<List<ScientificSupervisorModel>> getSupervisors() async {
    return await _getDataFromUrl('/api/get_supervisors');
  }

  Future<List<ScientificSupervisorModel>> _getDataFromUrl(String url) async {
    final uri = Uri.http(
      ConnectionMode.getConnectionUrl(),
      url,
    );
    final response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      final supervisors = json.decode(response.body);
      return (supervisors as List)
          .map((supervisors) => ScientificSupervisorModel.fromJson(supervisors))
          .toList();
    } else {
      return [];
    }
  }
}

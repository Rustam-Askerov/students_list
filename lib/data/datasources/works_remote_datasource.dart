import 'dart:convert';
import 'dart:developer';
import 'package:students_list/data/models/work_model.dart';
import 'package:students_list/utils/connection_mode.dart';
import 'package:http/http.dart' as http;

abstract class WorksDataSource {
  Future<List<WorkModel>> getWorks();
  Future<List<WorkModel>> getWorkByID(int id);
  Future<WorkModel> createWork(String name, int fkStudentId, String workType,
      String? assesment, String? workDueDate);

  Future<WorkModel> editWork(int id, String name, int fkStudentId,
      String workType, String? assesment, String? workDueDate);

  Future<void> deleteWork(int id);
}

class WorksRemoteDataSource extends WorksDataSource {
  @override
  Future<WorkModel> createWork(String name, int fkStudentId, String workType,
      String? assesment, String? workDueDate) async {
    final uri = Uri.http(
        ConnectionMode.getConnectionUrl(), '/api/create_work');
    final response = await http.post(
      uri,
      headers: ConnectionMode().getHeaders(),
      body: json.encode({
        'name': name,
        'fk_student_id': fkStudentId,
        'work_type': workType,
        'assesment': assesment,
        'work_due_date': workDueDate!=''? workDueDate : null
      }),
    );
    if (response.statusCode == 200) {
      final work = json.decode(response.body);
      return WorkModel.fromJson(work);
    }
    else{
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<void> deleteWork(int id) async {
    final uri = Uri.http(
        ConnectionMode.getConnectionUrl(), '/api/delete_work/$id');
    final response = await http.delete(
      uri,
      headers: ConnectionMode().getHeaders(),
    );
    if (response.statusCode == 200) {
      log(response.body);
    }
  }

  @override
  Future<WorkModel> editWork(int id, String name, int fkStudentId,
      String workType, String? assesment, String? workDueDate) async {
    final uri = Uri.http(
        ConnectionMode.getConnectionUrl(), '/api/update_work/$id');
    final response = await http.put(
      uri,
      headers: ConnectionMode().getHeaders(),
      body: json.encode({
        'id': id,
        'name': name,
        'fk_student_id': fkStudentId,
        'work_type': workType,
        'assesment': assesment,
        'work_due_date': workDueDate
      }),
    );
    if (response.statusCode == 200) {
      final work = json.decode(response.body);
      return WorkModel.fromJson(work);
    }
    else{
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<List<WorkModel>> getWorkByID(int id) async {
    return await _getDataFromUrl('/api/get_work_by_id/$id');
  }

  @override
  Future<List<WorkModel>> getWorks() async {
    return await _getDataFromUrl('/api/get_works');
  }

  Future<List<WorkModel>> _getDataFromUrl(String url) async {
    final uri = Uri.http(
      ConnectionMode.getConnectionUrl(),
      url,
    );
    final response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      final works = json.decode(response.body);
      return (works as List).map((works) => WorkModel.fromJson(works)).toList();
    } else {
      return [];
    }
  }
}

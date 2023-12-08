import 'dart:convert';

import 'package:students_list/data/models/department_model.dart';
import 'package:students_list/utils/connection_mode.dart';
import 'package:http/http.dart' as http;

abstract class DepartmentsDataSource{
  Future<List<DepartmentModel>> getDepartments();
  Future<List<DepartmentModel>> getDepartmentsByID(int id);
}

class DepartmentsRemoteDataSource extends DepartmentsDataSource{
  @override
  Future<List<DepartmentModel>> getDepartments() {
    return _getDataFromUrl('/api/get_departments');
  }

  @override
  Future<List<DepartmentModel>> getDepartmentsByID(int id) {
    return _getDataFromUrl('/api/get_department_by_id/$id');
  }

  Future<List<DepartmentModel>> _getDataFromUrl(String url) async {
    final uri = Uri.http(
      ConnectionMode.getConnectionUrl(),
      url,
    );
    final response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      final departments = json.decode(response.body);
      return (departments as List)
          .map((departments) => DepartmentModel.fromJson(departments))
          .toList();
    } else {
      throw Exception('Non valid data');
    }
  }
}
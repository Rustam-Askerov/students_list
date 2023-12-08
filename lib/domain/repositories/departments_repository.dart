import 'package:students_list/data/models/department_model.dart';

abstract class DepartmentsRepository{
  Future<List<DepartmentModel>> getDepartments();
  Future<List<DepartmentModel>> getDepartmentsByID(int id);
}
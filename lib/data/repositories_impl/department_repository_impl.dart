import 'package:students_list/data/datasources/departments_remote_datasource.dart';
import 'package:students_list/data/models/department_model.dart';
import 'package:students_list/domain/repositories/departments_repository.dart';

class DepartmentsRepositoryImpl implements DepartmentsRepository{
  final DepartmentsDataSource departmentsDataSource;

  DepartmentsRepositoryImpl({required this.departmentsDataSource});
  @override
  Future<List<DepartmentModel>> getDepartments() async {
    return await departmentsDataSource.getDepartments();
  }

  @override
  Future<List<DepartmentModel>> getDepartmentsByID(int id)async  {
    return await departmentsDataSource.getDepartmentsByID(id);
  }

}
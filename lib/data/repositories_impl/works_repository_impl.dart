import 'package:students_list/data/datasources/works_remote_datasource.dart';
import 'package:students_list/data/models/work_model.dart';
import 'package:students_list/domain/repositories/works_repository.dart';

class WorksRepositoryImpl implements WorksRepository {
  final WorksDataSource worksDataSource;

  WorksRepositoryImpl({required this.worksDataSource});
  @override
  Future<WorkModel> createWork(String name, int fkStudentId, String workType,
      String? assesment, String? workDueDate) async {
    return await worksDataSource.createWork(
        name, fkStudentId, workType, assesment, workDueDate);
  }

  @override
  Future<void> deleteWork(int id) async {
    await worksDataSource.deleteWork(id);
  }

  @override
  Future<WorkModel> editWork(int id, String name, int fkStudentId,
      String workType, String? assesment, String? workDueDate) async {
    return await worksDataSource.editWork(
        id, name, fkStudentId, workType, assesment, workDueDate);
  }

  @override
  Future<List<WorkModel>> getWorkByID(int id) async {
    return await worksDataSource.getWorkByID(id);
  }

  @override
  Future<List<WorkModel>> getWorks() async {
    return await worksDataSource.getWorks();
  }
}

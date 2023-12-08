import 'package:students_list/data/models/work_model.dart';

abstract class WorksRepository {
  Future<List<WorkModel>> getWorks();
  Future<List<WorkModel>> getWorkByID(int id);
  Future<WorkModel> createWork(String name, int fkStudentId, String workType,
      String? assesment, String? workDueDate);

  Future<WorkModel> editWork(int id, String name, int fkStudentId, String workType,
      String? assesment, String? workDueDate);

  Future<void> deleteWork(int id);
}

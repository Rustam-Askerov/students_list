import 'package:students_list/data/models/scientific_supervisor_model.dart';

abstract class ScientificSupervisorRepository {
  Future<List<ScientificSupervisorModel>> getSupervisors();
  Future<List<ScientificSupervisorModel>> getSupervisorByID(int id);
  Future<ScientificSupervisorModel> createSupervisor(
    String fullName,
    String post,
    String academicDegree,
    int departmentId,
  );

  Future<void> editSupervisor(
    int id,
    String fullName,
    String post,
    String academicDegree,
    int departmentId,
  );

  Future<void> deleteSupervisor(int id);
}

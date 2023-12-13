import 'package:students_list/data/datasources/supervisors_remote_datasource.dart';
import 'package:students_list/data/models/scientific_supervisor_model.dart';
import 'package:students_list/domain/repositories/scientific_supervisor.dart';

class ScientificSupervisorRepositoryImpl
    implements ScientificSupervisorRepository {
  final ScientificSupervisorDataSource scientificSupervisorDataSource;

  ScientificSupervisorRepositoryImpl(
      {required this.scientificSupervisorDataSource});
  @override
  Future<ScientificSupervisorModel> createSupervisor(String fullName, String post,
      String? academicDegree, int departmentId) async {
    return await scientificSupervisorDataSource.createSupervisor(
        fullName, post, academicDegree, departmentId);
  }

  @override
  Future<void> deleteSupervisor(int id) async {
    await scientificSupervisorDataSource.deleteStudent(id);
  }

  @override
  Future<ScientificSupervisorModel> editSupervisor(int id, String fullName, String post,
      String academicDegree, int departmentId) async {
    return await scientificSupervisorDataSource.editSupervisor(
        id, fullName, post, academicDegree, departmentId);
  }

  @override
  Future<List<ScientificSupervisorModel>> getSupervisorByID(int id) async {
    return await scientificSupervisorDataSource.getSupervisorByID(id);
  }

  @override
  Future<List<ScientificSupervisorModel>> getSupervisors() async {
    return await scientificSupervisorDataSource.getSupervisors();
  }
}

import 'package:get/get.dart';
import 'package:students_list/data/datasources/students_list_remote_datasource.dart';
import 'package:students_list/data/models/student_model.dart';
import 'package:students_list/data/repositories_impl/students_list_repository_impl.dart';

class HomeScreenController extends GetxController {
  final StudentsListRepositoryImpl _studentsListRepositoryImpl =
      StudentsListRepositoryImpl(
          studentsListDataSource: StudentsListRemoteDataSource());

  List<StudentModel> models = [];
  List<StudentModel> data = [];
  List<List<String>> rows = [];

  Future<List<StudentModel>> getData() async {
    models = await _studentsListRepositoryImpl.getStudents();
    data = models;
    rows = getRows().reversed.toList();
    update();
    return models;
  }

  Future<void> deleteStudent(int index) async {
    await _studentsListRepositoryImpl
        .deleteStudent(data[data.length - index - 1].id);
    models.removeAt(models.length - index - 1);
    data = models;
    rows = getRows().reversed.toList();
    update();
  }

  List<List<String>> getRows() {
    return List.generate(
      models.length,
      (index) => [
        '',
        models[index].fullName,
        models[index].studentIDnumber.toString(),
        models[index].groupName,
        models[index].stage,
        models[index].dateOfAdmission.toString(),
        (models[index].dateOfGraduation ?? '').toString(),
        models[index].isGraduate != null
            ? models[index].isGraduate!
                ? 'Окончено'
                : 'Не окончено'
            : 'Обучается',
      ],
    );
  }
}

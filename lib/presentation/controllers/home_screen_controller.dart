import 'package:get/get.dart';
import 'package:students_list/data/datasources/students_list_remote_datasource.dart';
import 'package:students_list/data/models/student_model.dart';
import 'package:students_list/data/repositories_impl/students_list_repository_impl.dart';
import 'package:students_list/domain/repositories/students_repository.dart';

class HomeScreenController extends GetxController {
  final StudentsListRepositoryImpl repositry = StudentsListRepositoryImpl(
      studentsListDataSource: StudentsListRemoteDataSource());

  List<StudentModel> models = [];
  List<StudentModel> data = [];

  Future<List<StudentModel>> getData() async {
    models = await repositry.getStudents();
    data = models;
    update();
    return models;
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
        models[index].dateOfGraduation.toString(),
        models[index].isGraduate != null
            ? models[index].isGraduate!
                ? 'Окончено'
                : 'Не окончено'
            : 'Нет данных',
      ],
    );
  }

  // void addRow(

  // ) {
  //   data.add(StudentModel(id: id, fullName: fullName, groupName: groupName, studentIDnumber: studentIDnumber, stage: stage, dateOfAdmission: dateOfAdmission, dateOfGraduation: dateOfGraduation, isGraduate: isGraduate));
  //   update();
  // }
}

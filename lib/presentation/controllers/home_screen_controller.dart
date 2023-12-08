import 'package:flutter/material.dart';
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
  final TextEditingController searchController =
      TextEditingController(text: '');

  void search() {
    data = models
        .where((element) =>
            element.fullName.toLowerCase().contains(searchController.text.toLowerCase()) ||
            element.stage.toLowerCase().contains(searchController.text.toLowerCase()) ||
            element.studentIDnumber.toString().toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();
    rows = getRows().reversed.toList();
    update();
  }

  Future<List<StudentModel>> getData() async {
    models = await _studentsListRepositoryImpl.getStudents();
    if (searchController.text != '') {
      search();
    } else {
      data = models;
      rows = getRows().reversed.toList();
    }
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
      data.length,
      (index) => [
        '',
        data[index].fullName,
        data[index].studentIDnumber.toString(),
        data[index].groupName,
        data[index].stage,
        data[index].dateOfAdmission.toString(),
        (data[index].dateOfGraduation ?? '').toString(),
        data[index].isGraduate != null
            ? models[index].isGraduate!
                ? 'Окончено'
                : 'Не окончено'
            : 'Обучается',
      ],
    );
  }
}

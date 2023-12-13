import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/data/datasources/students_list_remote_datasource.dart';
import 'package:students_list/data/models/student_model.dart';
import 'package:students_list/data/repositories_impl/students_list_repository_impl.dart';
import 'package:students_list/enums/filter_enums.dart';

class HomePageController extends GetxController {
  final StudentsListRepositoryImpl _studentsListRepositoryImpl =
      StudentsListRepositoryImpl(
          studentsListDataSource: StudentsListRemoteDataSource());

  List<StudentModel> models = [];
  List<StudentModel> data = [];
  List<List<String>> rows = [];
  final TextEditingController searchController =
      TextEditingController(text: '');
  Rx<AlphabetFilter> alphabetFilter = AlphabetFilter.none.obs;
  Rx<YearOfAdmission> yearOfAdmission = YearOfAdmission.none.obs;
  Rx<YearOfGraduation> yearOfGraduation = YearOfGraduation.none.obs;
  Rx<StudyingIndicationFilter> studyingIndication =
      StudyingIndicationFilter.none.obs;
  void search() {
    data = models
        .where((element) =>
            element.fullName
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            element.stage
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            element.studentIDnumber
                .toString()
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
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

  void callAllFilters() {
    if (searchController.text != '') {
      search();
    } else {
      data = models;
    }
    if (alphabetFilter.value != AlphabetFilter.none) {
      filter(alphabetFilter.value);
    }
    if (yearOfAdmission.value != YearOfAdmission.none) {
      filter(yearOfAdmission.value);
    }
    if (yearOfGraduation.value != YearOfGraduation.none) {
      filter(yearOfGraduation.value);
    }
    if (studyingIndication.value != StudyingIndicationFilter.none) {
      filter(studyingIndication.value);
    }
    update();
  }

  void filter(dynamic value) {
    switch (value) {
      case (AlphabetFilter.up):
        data.sort(
          (a, b) => b.fullName.substring(0, 2).compareTo(
                a.fullName.substring(0, 2),
              ),
        );
      case (AlphabetFilter.down):
        data.sort(
          (a, b) => a.fullName.substring(0, 2).compareTo(
                b.fullName.substring(0, 2),
              ),
        );
      case (YearOfAdmission.up):
        data.sort((a, b) => b.dateOfAdmission.compareTo(a.dateOfAdmission));
      case (YearOfAdmission.down):
        data.sort((a, b) => a.dateOfAdmission.compareTo(b.dateOfAdmission));
      case (YearOfGraduation.up):
        data.sort(
          (a, b) {
            if (a.dateOfGraduation == null && b.dateOfGraduation != null) {
              return b.dateOfGraduation!;
            } else if (b.dateOfGraduation == null &&
                a.dateOfGraduation != null) {
              return a.dateOfGraduation!;
            } else if (a.dateOfGraduation == null &&
                b.dateOfGraduation == null) {
              return (-1);
            } else {
              return b.dateOfGraduation!.compareTo(a.dateOfGraduation!);
            }
          },
        );
      case (YearOfGraduation.down):
        data.sort(
          (a, b) {
            if (a.dateOfGraduation == null && b.dateOfGraduation != null) {
              return b.dateOfGraduation!;
            } else if (b.dateOfGraduation == null &&
                a.dateOfGraduation != null) {
              return a.dateOfGraduation!;
            } else if (a.dateOfGraduation == null &&
                b.dateOfGraduation == null) {
              return (-1);
            } else {
              return a.dateOfGraduation!.compareTo(b.dateOfGraduation!);
            }
          },
        );
      case (StudyingIndicationFilter.inProcess):
        data = data.where((element) => element.isGraduate == null).toList();
      case (StudyingIndicationFilter.complete):
        data = data
            .where(
                (element) => element.isGraduate != null && element.isGraduate!)
            .toList();
      case (StudyingIndicationFilter.nonComplete):
        data = data
            .where(
                (element) => element.isGraduate != null && !element.isGraduate!)
            .toList();
    }
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
            ? data[index].isGraduate!
                ? 'Окончено'
                : 'Не окончено'
            : 'Обучается',
      ],
    );
  }

  void updateAlphabetValue(AlphabetFilter value) {
    yearOfGraduation.value = YearOfGraduation.none;
    yearOfAdmission.value = YearOfAdmission.none;
    alphabetFilter.value = value;
    update();
  }

  void updateYearOfAdmissionValue(YearOfAdmission value) {
    yearOfGraduation.value = YearOfGraduation.none;
    alphabetFilter.value = AlphabetFilter.none;
    yearOfAdmission.value = value;
    update();
  }

  void updateYearOfGraduationValue(YearOfGraduation value) {
    yearOfAdmission.value = YearOfAdmission.none;
    alphabetFilter.value = AlphabetFilter.none;
    yearOfGraduation.value = value;
    update();
  }

  void updateStudyingIndicationValue(StudyingIndicationFilter value) {
    studyingIndication.value = value;
    update();
  }

  void clearFilters() {
    alphabetFilter.value = AlphabetFilter.none;
    yearOfAdmission.value = YearOfAdmission.none;
    yearOfGraduation.value = YearOfGraduation.none;
    studyingIndication.value = StudyingIndicationFilter.none;
    data = models;
    search();
    update();
  }
}

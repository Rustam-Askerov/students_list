import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/data/datasources/departments_remote_datasource.dart';
import 'package:students_list/data/datasources/students_list_remote_datasource.dart';
import 'package:students_list/data/datasources/supervisors_remote_datasource.dart';
import 'package:students_list/data/datasources/works_remote_datasource.dart';
import 'package:students_list/data/models/department_model.dart';
import 'package:students_list/data/models/scientific_supervisor_model.dart';
import 'package:students_list/data/models/student_model.dart';
import 'package:students_list/data/models/work_model.dart';
import 'package:students_list/data/repositories_impl/department_repository_impl.dart';
import 'package:students_list/data/repositories_impl/students_list_repository_impl.dart';
import 'package:students_list/data/repositories_impl/supervisors_repository_impl.dart';
import 'package:students_list/data/repositories_impl/works_repository_impl.dart';
import 'package:students_list/presentation/controllers/home_page_controller.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';

class AddUpdateController extends GetxController {
  final HomePageController _homeScreenController =
      Get.find<HomePageController>();
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  bool serviceAvaliable = true;
  // ---------------------------------репозитории----------------------------------------------
  final StudentsListRepositoryImpl repositry = StudentsListRepositoryImpl(
      studentsListDataSource: StudentsListRemoteDataSource());
  final DepartmentsRepositoryImpl _departmentsRepositoryImpl =
      DepartmentsRepositoryImpl(
          departmentsDataSource: DepartmentsRemoteDataSource());
  final WorksRepositoryImpl _worksRepositoryImpl =
      WorksRepositoryImpl(worksDataSource: WorksRemoteDataSource());
  final ScientificSupervisorRepositoryImpl _supervisorRepositoryImpl =
      ScientificSupervisorRepositoryImpl(
          scientificSupervisorDataSource:
              ScientificSupervisorRemoteDataSource());
  // ---------------------------------репозитории----------------------------------------------

  // ---------------------------------данные---------------------------------------------------
  List<DepartmentModel> departments = [];
  List<WorkModel> works = [];
  List<ScientificSupervisorModel> supervisors = [];
  List<String> faculties = [];
  List<DepartmentModel> departmentsOfCurrentFaculty = [];
  DepartmentModel? currentDepartment;
  ScientificSupervisorModel? currentSupervisor;
  WorkModel? currentWork;
  //----------------------------------данные---------------------------------------------------

  //----------------------------------поля формы заполнения------------------------------------
  final TextEditingController surname = TextEditingController(text: '');
  final TextEditingController firstName = TextEditingController(text: '');
  final TextEditingController fatherName = TextEditingController(text: '');
  final TextEditingController group = TextEditingController(text: '');
  final TextEditingController studNum = TextEditingController(text: '');
  DateTime yearOfAdmission = DateTime(DateTime.now().year);
  DateTime? yearOfGraduation;
  String? stage;
  bool? graduationIndicator;
  //информация о работе
  final TextEditingController workName = TextEditingController(text: '');
  String? workType;
  String? assessment;
  final TextEditingController workDueDateText = TextEditingController(text: '');
  DateTime? workDueDate;
  //информация о кафедре
  String? faculty;
  String? departmentName;
  //информация о научном руководителе
  final TextEditingController supervisorSurname =
      TextEditingController(text: '');
  final TextEditingController supervisorFirstName =
      TextEditingController(text: '');
  final TextEditingController supervisorFatherName =
      TextEditingController(text: '');
  String? post;
  String? academicDegree;
  //----------------------------------поля формы заполнения------------------------------------

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;
    update();
  }

  Future<bool> getData() async {
    works = await _worksRepositoryImpl.getWorks();
    supervisors = await _supervisorRepositoryImpl.getSupervisors();
    if (works.isNotEmpty && supervisors.isNotEmpty) {
      return true;
    } else {
      return true;
    }
  }

  //для заполнения информации о студенте
  Future<List<DepartmentModel>> getDataCreate() async {
    clearFields();
    departments = await _departmentsRepositoryImpl.getDepartments();
    faculties =
        List.generate(departments.length, (index) => departments[index].faculty)
            .toSet()
            .toList();
    getData();
    yearOfGraduation = null;
    return departments;
  }

  //для редактирования информации о студенте
  Future<List<DepartmentModel>> getDataUpdate(StudentModel student) async {
    clearFields();
    departments = await _departmentsRepositoryImpl.getDepartments();
    faculties =
        List.generate(departments.length, (index) => departments[index].faculty)
            .toSet()
            .toList();
    final bool result = await getData();
    if (result) {
      fillCurrentModels(student);
      fillFields(student);
    }
    return departments;
  }

  //добавление новой информации о студенте
  Future<void> addStudent() async {
    ScientificSupervisorModel supervisor;
    try {
      if (supervisorSurname.text != '' &&
          supervisorFirstName.text != '' &&
          supervisorFatherName.text != '' &&
          faculty != null &&
          departmentName != null &&
          faculty != Dictionary.nonChose &&
          departmentName != Dictionary.nonChose) {
        if (equalSupervisor() != null) {
          supervisor = equalSupervisor()!;
        } else {
          supervisor = await _supervisorRepositoryImpl.createSupervisor(
              getFullName(supervisorSurname.text, supervisorFirstName.text,
                  supervisorFatherName.text),
              post!,
              academicDegree,
              departments
                  .where((element) => element.departmentName == departmentName)
                  .first
                  .id);
        }
        if (supervisor.id > -1) {
          StudentModel student = await repositry.createStudent(
              getFullName(surname.text, firstName.text, fatherName.text),
              group.text,
              int.parse(studNum.text),
              departments
                  .where((element) => element.departmentName == departmentName)
                  .first
                  .id,
              supervisor.id,
              stage!,
              yearOfAdmission.year,
              yearOfGraduation?.year,
              graduationIndicator);
          if (student.id > -1 && workName.text != '' && workType != null) {
            await _worksRepositoryImpl.createWork(workName.text, student.id,
                workType!, assessment, workDueDateText.text);
          }
        }
      } else if (faculty != null &&
          departmentName != null &&
          faculty != Dictionary.nonChose &&
          departmentName != Dictionary.nonChose) {
        await repositry.createStudent(
            getFullName(surname.text, firstName.text, fatherName.text),
            group.text,
            int.parse(studNum.text),
            departments
                .where((element) => element.departmentName == departmentName)
                .first
                .id,
            null,
            stage!,
            yearOfAdmission.year,
            yearOfGraduation?.year,
            graduationIndicator);
      } else {
        await repositry.createStudent(
            getFullName(surname.text, firstName.text, fatherName.text),
            group.text,
            int.parse(studNum.text),
            null,
            null,
            stage!,
            yearOfAdmission.year,
            yearOfGraduation?.year,
            graduationIndicator);
      }
      _homeScreenController.getData();
    } catch (error) {
      throw Exception(error);
    }
  }

  //редактирование информации о студенте
  Future<void> updateStudent(StudentModel student) async {
    ScientificSupervisorModel? supervisorModel;
    try {
      if (departmentName != null && departmentName != Dictionary.nonChose) {
        if (currentSupervisor == null) {
          //случай если при редактировании научный руководитель еще не вписан

          if (equalSupervisor() != null) {
            //если такой научный руководитель уже существует
            supervisorModel = equalSupervisor();
          } else {
            if (supervisorSurname.text != '' &&
                supervisorFirstName.text != '' &&
                supervisorFatherName.text != '' &&
                post != null) {
              //если пользователь вписал данные
              supervisorModel =
                  await _supervisorRepositoryImpl.createSupervisor(
                      getFullName(supervisorSurname.text,
                          supervisorFirstName.text, supervisorFatherName.text),
                      post!,
                      academicDegree!,
                      departments
                          .where((element) =>
                              element.departmentName == departmentName)
                          .first
                          .id);
            }
          }

          if (workName.text != '' && workType != null) {
            // если данные о научной работе заполнены то создаем
            await _worksRepositoryImpl.createWork(workName.text, student.id,
                workType!, assessment, workDueDateText.text);
          }
        } else {
          //cлучай если при редактировании научный руководитель уже вписан

          //но пользователь очистил данные о нем
          if (supervisorSurname.text == '' &&
              supervisorFirstName.text == '' &&
              supervisorFatherName.text == '' &&
              post == null) {
            supervisorModel = null;
            if (currentWork != null) {
              await _worksRepositoryImpl.deleteWork(currentWork!.id);
            }
          } else if (supervisorSurname.text != '' &&
              supervisorFirstName.text != '' &&
              supervisorFatherName.text != '' &&
              post != null) {
            //cлучай если при редактировании научный руководитель уже вписан,но пользователь поменял его на другого
            if (equalSupervisor() != null) {
              supervisorModel = equalSupervisor()!;
            } else {
              supervisorModel =
                  await _supervisorRepositoryImpl.createSupervisor(
                      getFullName(supervisorSurname.text,
                          supervisorFirstName.text, supervisorFatherName.text),
                      post!,
                      academicDegree!,
                      departments
                          .where((element) =>
                              element.departmentName == departmentName)
                          .first
                          .id);
            }
            if (currentWork != null) {
              if (workName.text == '') {
                await _worksRepositoryImpl.deleteWork(currentWork!.id);
              } else {
                //если научная работа есть то редактируем
                await _worksRepositoryImpl.editWork(
                    currentWork!.id,
                    workName.text,
                    student.id,
                    workType!,
                    assessment,
                    workDueDateText.text);
              }
            } else {
              //если научной работы нет то создаем
              if (workName.text != '' && workType != null) {
                await _worksRepositoryImpl.createWork(workName.text, student.id,
                    workType!, assessment, workDueDateText.text);
              }
            }
          }
        }
        await repositry.editStudent(
            student.id,
            getFullName(surname.text, firstName.text, fatherName.text),
            group.text,
            int.parse(studNum.text),
            departments
                .where((element) => element.departmentName == departmentName)
                .first
                .id,
            supervisorModel?.id,
            stage!,
            yearOfAdmission.year,
            yearOfGraduation?.year,
            graduationIndicator);
      } else {
        await repositry.editStudent(
            student.id,
            getFullName(surname.text, firstName.text, fatherName.text),
            group.text,
            int.parse(studNum.text),
            null,
            null,
            stage!,
            yearOfAdmission.year,
            yearOfGraduation?.year,
            graduationIndicator);
      }
      _homeScreenController.getData();
    } catch (error) {
      throw Exception(error);
    }
  }

  void fillCurrentModels(StudentModel student) {
    if (departments
        .where((element) => element.id == student.departmentID)
        .isNotEmpty) {
      currentDepartment = departments
          .where((element) => element.id == student.departmentID)
          .first;
    }
    if (supervisors
        .where((element) => element.id == student.scientificSupervisorID)
        .isNotEmpty) {
      currentSupervisor = supervisors
          .where((element) => element.id == student.scientificSupervisorID)
          .first;
    }
    if (works
        .where((element) => element.fkStudentId == student.id)
        .isNotEmpty) {
      currentWork =
          works.where((element) => element.fkStudentId == student.id).first;
    }
  }

  void fillFields(
    StudentModel student,
  ) {
    final fullName = student.fullName.split(' ');
    surname.text = fullName[0];
    firstName.text = fullName[1];
    fatherName.text = fullName[2];
    group.text = student.groupName;
    studNum.text = student.studentIDnumber.toString();
    yearOfAdmission = DateTime(student.dateOfAdmission);
    if (student.dateOfGraduation != null) {
      yearOfGraduation = DateTime(student.dateOfGraduation!);
    }
    stage = student.stage;
    graduationIndicator = student.isGraduate;
    if (currentDepartment != null) {
      updateFaculty(currentDepartment!.faculty);
      departmentName = currentDepartment!.departmentName;
    }
    if (currentSupervisor != null) {
      final supervisorFullName = currentSupervisor!.fullName.split(' ');
      supervisorSurname.text = supervisorFullName[0];
      supervisorFirstName.text = supervisorFullName[1];
      supervisorFatherName.text = supervisorFullName[2];
      post = currentSupervisor!.post;
      academicDegree = currentSupervisor!.academicDegree;
    }
    if (currentWork != null) {
      workName.text = currentWork!.name;
      workType = currentWork!.workType;
      assessment = currentWork!.assesment;
      if (currentWork!.workDueDate != null) {
        workDueDate =
            DateTime.parse(currentWork!.workDueDate!.replaceFirst('T', ' '))
                .toLocal();
        workDueDateText.text = workDueDate!.toString().substring(0, 10);
      }
    }
  }

  //очистка полей
  void clearFields() {
    surname.clear();
    firstName.clear();
    fatherName.clear();
    group.clear();
    studNum.clear();
    yearOfAdmission = DateTime(DateTime.now().year);
    yearOfGraduation = null;
    stage = null;
    faculty = null;
    departmentName = null;
    supervisorSurname.clear();
    supervisorFirstName.clear();
    supervisorFatherName.clear();
    post = null;
    academicDegree = null;
    workName.clear();
    workType = null;
    assessment = null;
    workDueDate = null;
    workDueDateText.clear();
    currentDepartment = null;
    currentSupervisor = null;
    currentWork = null;
  }

  void clearStudentFields() {
    surname.clear();
    firstName.clear();
    fatherName.clear();
    group.clear();
    studNum.clear();
    yearOfAdmission = DateTime(DateTime.now().year);
    yearOfGraduation = null;
    stage = null;
    update();
  }

  void clearDepartmentFields() {
    faculty = null;
    departmentName = null;
    update();
  }

  void clearSupervisorFields() {
    supervisorSurname.clear();
    supervisorFirstName.clear();
    supervisorFatherName.clear();
    post = null;
    academicDegree = null;
    update();
  }

  void clearScientificWorkFields() {
    workName.clear();
    workType = null;
    assessment = null;
    workDueDate = null;
    workDueDateText.clear();
    update();
  }

  //смена выбора факультета
  void updateFaculty(String value) {
    departmentName = null;
    faculty = value;
    //формируем список кафедр для выбранного факультета
    departmentsOfCurrentFaculty = departments
        .where(
          (element) => element.faculty == value,
        )
        .toList();
    update();
  }

  //cмена выбора кафедры
  void updateDepartment(String value) {
    departmentName = value;
    update();
  }

  void graduationUpdate(bool? value) {
    graduationIndicator = value;
    if (value == null) {
      yearOfGraduation = null;
    }
    update();
  }

  void updateWorkMark(String? value) {
    if (workType != null) {
      assessment = value!;
      update();
    }
  }

  void updateWorkType(String? value) {
    workType = value;
    update();
  }

  void clearWorkDueDate() {
    workDueDate = null;
    workDueDateText.clear();
    update();
  }

  void updateWorkDueDate(DateTime value) {
    workDueDate = value;
    String month;
    String day;
    if (workDueDate!.month.toString().length == 1) {
      month = '0${workDueDate!.month}';
    } else {
      month = workDueDate!.month.toString();
    }
    if (workDueDate!.day.toString().length == 1) {
      day = '0${workDueDate!.day}';
    } else {
      day = workDueDate!.day.toString();
    }
    workDueDateText.text = '${workDueDate!.year}-$month-$day';
    update();
  }

  String getFullName(String surname, String firstName, String fatherName) {
    return '${surname.trim()} ${firstName.trim()} ${fatherName.trim()}';
  }

  ScientificSupervisorModel? equalSupervisor() {
    if (supervisors
        .where((element) =>
            element.fullName ==
                getFullName(supervisorSurname.text, supervisorFirstName.text,
                    supervisorFatherName.text) &&
            element.post == post! &&
            element.academicDegree == academicDegree &&
            element.departmentId ==
                departments
                    .where(
                        (element) => element.departmentName == departmentName)
                    .first
                    .id)
        .isNotEmpty) {
      return supervisors
          .where((element) =>
              element.fullName ==
                  getFullName(supervisorSurname.text, supervisorFirstName.text,
                      supervisorFatherName.text) &&
              element.post == post! &&
              element.academicDegree == academicDegree &&
              element.departmentId ==
                  departments
                      .where(
                          (element) => element.departmentName == departmentName)
                      .first
                      .id)
          .first;
    } else {
      return null;
    }
  }

  bool checkFilledFields() {
    if (graduationIndicator == true) {
      if (surname.text != '' &&
          firstName.text != '' &&
          fatherName.text != '' &&
          group.text != '' &&
          studNum.text != '' &&
          stage != null &&
          yearOfGraduation != null &&
          departmentName != null &&
          faculty != null &&
          supervisorSurname.text != '' &&
          supervisorFirstName.text != '' &&
          supervisorFatherName.text != '' &&
          post != null &&
          workName.text != '' &&
          workDueDate != null &&
          workType != null &&
          assessment != null) {
        return true;
      } else {
        return false;
      }
    } else if (graduationIndicator == false &&
        surname.text != '' &&
        firstName.text != '' &&
        fatherName.text != '' &&
        group.text != '' &&
        studNum.text != '' &&
        stage != null &&
        yearOfGraduation != null &&
        departmentName == null &&
        faculty == null) {
      return true;
    } else if (graduationIndicator == false &&
        surname.text != '' &&
        firstName.text != '' &&
        fatherName.text != '' &&
        group.text != '' &&
        studNum.text != '' &&
        stage != null &&
        yearOfGraduation != null &&
        departmentName != null &&
        faculty != null &&
        supervisorSurname.text == '' &&
        supervisorFirstName.text == '' &&
        supervisorFatherName.text == '' &&
        post == null &&
        academicDegree == null) {
      return true;
    } else if (graduationIndicator == false &&
        surname.text != '' &&
        firstName.text != '' &&
        fatherName.text != '' &&
        group.text != '' &&
        studNum.text != '' &&
        stage != null &&
        yearOfGraduation != null &&
        departmentName != null &&
        faculty != null &&
        supervisorSurname.text != '' &&
        supervisorFirstName.text != '' &&
        supervisorFatherName.text != '' &&
        post != null &&
        ((workName.text == '' &&
                workDueDate == null &&
                workType == null &&
                assessment == null) ||
            (workName.text != '' &&
                workDueDate == null &&
                workType != null &&
                assessment == null))) {
      return true;
    } else if (graduationIndicator == null &&
        surname.text != '' &&
        firstName.text != '' &&
        fatherName.text != '' &&
        group.text != '' &&
        studNum.text != '' &&
        stage != null &&
        faculty == null &&
        departmentName == null &&
        supervisorSurname.text == '' &&
        supervisorFirstName.text == '' &&
        supervisorFatherName.text == '' &&
        post == null &&
        academicDegree == null) {
      return true;
    } else if (graduationIndicator == null &&
        surname.text != '' &&
        firstName.text != '' &&
        fatherName.text != '' &&
        group.text != '' &&
        studNum.text != '' &&
        stage != null &&
        faculty != null &&
        departmentName != null &&
        supervisorSurname.text == '' &&
        supervisorFirstName.text == '' &&
        supervisorFatherName.text == '' &&
        post == null &&
        academicDegree == null) {
      return true;
    } else if (graduationIndicator == null &&
        surname.text != '' &&
        firstName.text != '' &&
        fatherName.text != '' &&
        group.text != '' &&
        studNum.text != '' &&
        stage != null &&
        departmentName != null &&
        faculty != null &&
        supervisorSurname.text != '' &&
        supervisorFirstName.text != '' &&
        supervisorFatherName.text != '' &&
        post != null &&
        ((workName.text == '' &&
                workDueDate == null &&
                workType == null &&
                assessment == null) ||
            (workName.text != '' &&
                workDueDate == null &&
                workType != null &&
                assessment == null) ||
            (workName.text != '' &&
                workDueDate != null &&
                workType != null &&
                assessment != null))) {
      return true;
    } else {
      return false;
    }
  }

  void updateServiceAvalibility(bool value) {
    serviceAvaliable = value;
    update();
  }
}

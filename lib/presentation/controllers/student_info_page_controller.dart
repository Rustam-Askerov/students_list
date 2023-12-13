import 'package:get/get.dart';
import 'package:students_list/data/datasources/departments_remote_datasource.dart';
import 'package:students_list/data/datasources/supervisors_remote_datasource.dart';
import 'package:students_list/data/datasources/works_remote_datasource.dart';
import 'package:students_list/data/models/department_model.dart';
import 'package:students_list/data/models/scientific_supervisor_model.dart';
import 'package:students_list/data/models/work_model.dart';
import 'package:students_list/data/repositories_impl/department_repository_impl.dart';
import 'package:students_list/data/repositories_impl/supervisors_repository_impl.dart';
import 'package:students_list/data/repositories_impl/works_repository_impl.dart';

class StudentInfoPageController extends GetxController {
  List<DepartmentModel> departments = [];
  List<WorkModel> works = [];
  List<ScientificSupervisorModel> supervisors = [];
  final List<String> monthes = [
    'Января',
    'Февраля',
    'Марта',
    'Апреля',
    'Мая',
    'Июня',
    'Июля',
    'Августа',
    'Сентября',
    'Октября',
    'Ноября',
    'Декабря'
  ];
  final DepartmentsRepositoryImpl _departmentsRepositoryImpl =
      DepartmentsRepositoryImpl(
          departmentsDataSource: DepartmentsRemoteDataSource());
  final WorksRepositoryImpl _worksRepositoryImpl =
      WorksRepositoryImpl(worksDataSource: WorksRemoteDataSource());
  final ScientificSupervisorRepositoryImpl _supervisorRepositoryImpl =
      ScientificSupervisorRepositoryImpl(
          scientificSupervisorDataSource:
              ScientificSupervisorRemoteDataSource());

  Future<List<DepartmentModel>> getDepartmentsData() async {
    departments = await _departmentsRepositoryImpl.getDepartments();
    update();
    return departments;
  }

  Future<List<ScientificSupervisorModel>> getSupervisor() async {
    supervisors = await _supervisorRepositoryImpl.getSupervisors();
    update();
    return supervisors;
  }

  Future<List<WorkModel>> getWorks() async {
    works = await _worksRepositoryImpl.getWorks();
    update();
    return works;
  }

  String formateDate(String date) {
    final splitDate = date.split('-');
    return '${int.parse(splitDate[2])+1} ${monthes[int.parse(splitDate[1])-1]} ${splitDate[0]}';
  }
}

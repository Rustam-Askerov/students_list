import 'package:get/get.dart';
import 'package:students_list/data/models/student_model.dart';

class HomeScreenController extends GetxController {
  List<StudentModel> data = [
    StudentModel(
        'Иванов Иван Ивановиииииииич',
        2648951,
        'Мат.анализ',
        2019,
        2023,
        false,
        'Бакалавр',
        'bbbbbbbbbbbbbbbbbbb',
        'Отлично',
        'Математический',
        'Мат.анализ',
        'Невский М.В.'),
    StudentModel(
        'Иванов Иван Иванович',
        2648951,
        'Мат.анализ',
        2019,
        2023,
        false,
        'Бакалавр',
        'bbbbbbbbbbbbbbbbbbb',
        'Отлично',
        'Математический',
        'Мат.анализ',
        'Невский М.В.'),
    StudentModel(
        'Иванов Иван Иванович',
        2648951,
        'Мат.анализ',
        2019,
        2023,
        false,
        'Бакалавр',
        'bbbbbbbbbbbbbbbbbbb',
        'Отлично',
        'Математический',
        'Мат.анализ',
        'Невский М.В.'),
  ];

  List<List<String>> getRows() {
    return List.generate(
      data.length,
      (index) => [
        '',
        data[index].fio,
        data[index].studPassportNum.toString(),
        data[index].department,
        data[index].yearOfEntering.toString(),
        data[index].degree,
        data[index].archiveIndicator.toString(),
        data[index].vkrName,
        data[index].vkrMark,
        data[index].faculty,
        data[index].departmentName,
        data[index].departmentHead,
      ],
    );
  }

  void addRow(
    String fio,
    num studPassportNum,
    String department,
    num yearOfEntering,
    num yearOfEnding,
    String degree,
    bool archiveIndicator,
    String vkrName,
    String vkrMark,
    String faculty,
    String departmentName,
    String departmentHead,
  ) {
    data.add(StudentModel(
        fio,
        studPassportNum,
        department,
        yearOfEntering,
        yearOfEnding,
        archiveIndicator,
        degree,
        vkrName,
        vkrMark,
        faculty,
        departmentName,
        departmentHead));
    update();
  }
}

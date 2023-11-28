import 'package:get/get.dart';
import 'package:students_list/data/models/student_model.dart';

class HomeScreenController extends GetxController {
  List<StudentModel> data = [
    StudentModel(
        'Иванов Иван Ивановиииииииич',
        '2648951',
        'Мат.анализ',
        '2019',
        'Бакалавр',
        'aaaaaaaaaa',
        'bbbbbbbbbbbbbbbbbbb',
        'Отлично',
        'Математический',
        'Мат.анализ',
        'Невский М.В.'),
    StudentModel(
        'Иванов Иван Иванович',
        '2648951',
        'Мат.анализ',
        '2019',
        'Бакалавр',
        'aaaaaaaaaa',
        'bbbbbbbbbbbbbbbbbbb',
        'Отлично',
        'Математический',
        'Мат.анализ',
        'Невский М.В.'),
    StudentModel(
        'Иванов Иван Иванович',
        '2648951',
        'Мат.анализ',
        '2019',
        'Бакалавр',
        'aaaaaaaaaa',
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
        data[index].studPassportNum,
        data[index].department,
        data[index].yearOfEntering,
        data[index].degree,
        data[index].endIndication,
        data[index].vkrName,
        data[index].vkrMark,
        data[index].faculty,
        data[index].name,
        data[index].departmentHead,
      ],
    );
  }

  void addRow(
    String fio,
    String studPassportNum,
    String department,
    String yearOfEntering,
    String degree,
    String endIndication,
    String vkrName,
    String vkrMark,
    String faculty,
    String name,
    String departmentHead,
  ) {
    data.add(StudentModel(
        fio,
        studPassportNum,
        department,
        yearOfEntering,
        degree,
        endIndication,
        vkrName,
        vkrMark,
        faculty,
        name,
        departmentHead));
    update();
  }
  
}

import 'package:get/get.dart';
import 'package:students_list/data/models/student_model.dart';

class HomeScreenController extends GetxController {
  List<StudentModel> data = [
    
  ];

  List<List<String>> getRows() {
    return List.generate(
      5,
      (index) => [
        '',
        'AAAAAAAAAAAAAAAAAA',
        'AAAAAAAAAAAAAAAAAA',
        'AAAAAAAAAAAAAAAAAA',
        'AAAAAAAAAAAAAAAAAA',
        'AAAAAAAAAAAAAAAAAA',
        'AAAAAAAAAAAAAAAAAA',
        'AAAAAAAAAAAAAAAAAA',
        'AAAAAAAAAAAAAAAAAA',
      ],
    );
  }

  // void addRow(
    
  // ) {
  //   data.add(StudentModel(id: id, fullName: fullName, groupName: groupName, studentIDnumber: studentIDnumber, stage: stage, dateOfAdmission: dateOfAdmission, dateOfGraduation: dateOfGraduation, isGraduate: isGraduate));
  //   update();
  // }
}

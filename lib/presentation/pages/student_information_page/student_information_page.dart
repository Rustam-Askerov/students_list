import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/data/models/student_model.dart';
import 'package:students_list/presentation/controllers/student_info_page_controller.dart';
import 'package:students_list/presentation/pages/student_information_page/components/department_info_view.dart';
import 'package:students_list/presentation/pages/student_information_page/components/student_info_view.dart';
import 'package:students_list/presentation/pages/student_information_page/components/supervisor_info_view.dart';
import 'package:students_list/presentation/pages/student_information_page/components/work_info_view.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class StudentInformationPage extends StatelessWidget {
  const StudentInformationPage({super.key, required this.student});
  final StudentModel student;
  static final StudentInfoPageController _studentInfoPageController =
      Get.find<StudentInfoPageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundPrimary,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: IntrinsicWidth(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Dictionary.studentsInfo,
                      style: TextStyles.header
                          .copyWith(color: ThemeColors.textColorPrimary)),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(child: StudentInfoView(student: student)),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(Dictionary.departmentInfo,
                      style: TextStyles.header
                          .copyWith(color: ThemeColors.textColorPrimary)),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder(
                    future: _studentInfoPageController.getDepartmentsData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return _studentInfoPageController.departments
                                .where((element) =>
                                    element.id == student.departmentID)
                                .isNotEmpty
                            ? DepartmentInfoView(
                                department: _studentInfoPageController.departments
                                    .where((element) =>
                                        element.id == student.departmentID)
                                    .first)
                            : Text(
                                Dictionary.infoDoesntExist,
                                style: TextStyles.mainText
                                    .copyWith(color: ThemeColors.hintTextColor),
                              );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    Dictionary.supervisorInfoTable,
                    style: TextStyles.header
                        .copyWith(color: ThemeColors.textColorPrimary),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder(
                    future: _studentInfoPageController.getSupervisor(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return _studentInfoPageController.supervisors
                                .where((element) =>
                                    element.id == student.scientificSupervisorID)
                                .isNotEmpty
                            ? SupervisorInfoView(
                                supervisor: _studentInfoPageController.supervisors
                                    .where((element) =>
                                        element.id ==
                                        student.scientificSupervisorID)
                                    .first,
                              )
                            : Text(
                                Dictionary.infoDoesntExist,
                                style: TextStyles.mainText
                                    .copyWith(color: ThemeColors.hintTextColor),
                              );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    Dictionary.workInfoTable,
                    style: TextStyles.header
                        .copyWith(color: ThemeColors.textColorPrimary),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder(
                    future: _studentInfoPageController.getWorks(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return _studentInfoPageController.works
                                .where((element) =>
                                    element.fkStudentId == student.id)
                                .isNotEmpty
                            ? WorkInfoView(
                                work: _studentInfoPageController.works
                                .where((element) =>
                                    element.fkStudentId == student.id).first,
                              )
                            : Text(
                                Dictionary.infoDoesntExist,
                                style: TextStyles.mainText
                                    .copyWith(color: ThemeColors.hintTextColor),
                              );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





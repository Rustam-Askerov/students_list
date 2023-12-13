import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/add_update_controller.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class DepartmentInfo extends StatelessWidget {
  const DepartmentInfo({super.key});
  static final _addUpdateController = Get.find<AddUpdateController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddUpdateController>(
      init: _addUpdateController,
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.only(bottom: 25, top: 30),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ThemeColors.backgroundPrimary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ThemeColors.backgroundSecondary),
            boxShadow: const [
              BoxShadow(
                color: ThemeColors.backgroundSecondary,
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Dictionary.departmentInfo,
                    style: TextStyles.header
                        .copyWith(color: ThemeColors.textColorPrimary),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                          ThemeColors.backgroundSecondary),
                      overlayColor: const MaterialStatePropertyAll(
                          ThemeColors.backgroundPrimary),
                      surfaceTintColor: const MaterialStatePropertyAll(
                          ThemeColors.backgroundSecondary),
                    ),
                    onPressed: () {
                      _addUpdateController.clearDepartmentFields();
                    },
                    child: SizedBox(
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Dictionary.clear,
                              style: TextStyles.header.copyWith(
                                  color: ThemeColors.textColorPrimary),
                              textAlign: TextAlign.center,
                            ),
                            const Icon(
                              Icons.close,
                              size: 24,
                              color: ThemeColors.hintTextColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 625,
                child: DropdownButton<String>(
                    dropdownColor: ThemeColors.backgroundSecondary,
                    focusColor: ThemeColors.backgroundSecondary,
                    hint: Text(
                      Dictionary.faculty,
                      style: TextStyles.hintText.copyWith(
                          color: ThemeColors.hintTextColor, fontSize: 14),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: Dictionary.nonChose,
                        child: Text(
                          Dictionary.nonChose,
                          style:
                              TextStyles.mainText.copyWith(color: Colors.grey),
                        ),
                      ),
                      ...List.generate(
                        _addUpdateController.faculties.length,
                        (index) => DropdownMenuItem(
                          value: _addUpdateController.faculties[index],
                          child: Text(
                            _addUpdateController.faculties[index],
                            style: TextStyles.mainText,
                          ),
                        ),
                      ),
                    ],
                    value: _addUpdateController.faculty,
                    onChanged: (String? value) {
                      _addUpdateController.updateFaculty(value!);
                    }),
              ),
              SizedBox(
                width: 625,
                child: DropdownButton<String>(
                  dropdownColor: ThemeColors.backgroundSecondary,
                  focusColor: ThemeColors.backgroundSecondary,
                  hint: Text(
                    Dictionary.departmentName,
                    style: TextStyles.hintText.copyWith(
                        color: ThemeColors.hintTextColor, fontSize: 14),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: Dictionary.nonChose,
                      child: Text(
                        Dictionary.nonChose,
                        style: TextStyles.mainText.copyWith(color: Colors.grey),
                      ),
                    ),
                    ...List.generate(
                      _addUpdateController.departmentsOfCurrentFaculty.length,
                      (index) => DropdownMenuItem(
                        value: _addUpdateController
                            .departmentsOfCurrentFaculty[index].departmentName,
                        child: Text(
                          _addUpdateController
                              .departmentsOfCurrentFaculty[index]
                              .departmentName,
                          style: TextStyles.mainText,
                        ),
                      ),
                    ),
                  ],
                  value: _addUpdateController.departmentName,
                  onChanged: (String? value) {
                    _addUpdateController.updateDepartment(value!);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
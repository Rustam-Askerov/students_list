import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/add_update_controller.dart';

import 'package:students_list/presentation/pages/add_update_data_page/components/custom_enter_field.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key});
  static final _addUpdateController = Get.find<AddUpdateController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddUpdateController>(
      init: _addUpdateController,
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(16).copyWith(bottom: 62),
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: ThemeColors.backgroundPrimary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ThemeColors.backgroundSecondary),
            boxShadow: const [
              BoxShadow(
                  color: ThemeColors.backgroundSecondary,
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(5, 5))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Dictionary.studentsInfo,
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
                      _addUpdateController.clearStudentFields();
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
                height: 16,
              ),
              CustomEnterField(
                textEditingController: _addUpdateController.surname,
                labelText: Dictionary.surname,
                padding: const EdgeInsets.only(bottom: 16),
              ),
              CustomEnterField(
                textEditingController: _addUpdateController.firstName,
                labelText: Dictionary.firstName,
                padding: const EdgeInsets.only(bottom: 16),
              ),
              CustomEnterField(
                textEditingController: _addUpdateController.fatherName,
                labelText: Dictionary.fatherName,
                padding: const EdgeInsets.only(bottom: 16),
              ),
              CustomEnterField(
                textEditingController: _addUpdateController.group,
                labelText: Dictionary.group,
                padding: const EdgeInsets.only(bottom: 16),
              ),
              CustomEnterField(
                textEditingController: _addUpdateController.studNum,
                labelText: Dictionary.studNum,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                padding: const EdgeInsets.only(bottom: 4),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                width: 625,
                child: DropdownButton<String>(
                  dropdownColor: ThemeColors.backgroundSecondary,
                  focusColor: ThemeColors.backgroundSecondary,
                  hint: Text(
                    Dictionary.degree,
                    style: TextStyles.hintText.copyWith(
                        color: ThemeColors.hintTextColor, fontSize: 14),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: Dictionary.undergraduateStudent,
                      child: Text(
                        Dictionary.undergraduateStudent,
                        style: TextStyles.mainText,
                      ),
                    ),
                    DropdownMenuItem(
                      value: Dictionary.specialtyStudent,
                      child: Text(
                        Dictionary.specialtyStudent,
                        style: TextStyles.mainText,
                      ),
                    ),
                    DropdownMenuItem(
                      value: Dictionary.masterStudent,
                      child: Text(
                        Dictionary.masterStudent,
                        style: TextStyles.mainText,
                      ),
                    ),
                    DropdownMenuItem(
                      value: Dictionary.bachelor,
                      child: Text(
                        Dictionary.bachelor,
                        style: TextStyles.mainText,
                      ),
                    ),
                    DropdownMenuItem(
                      value: Dictionary.specialist,
                      child: Text(
                        Dictionary.specialist,
                        style: TextStyles.mainText,
                      ),
                    ),
                    DropdownMenuItem(
                      value: Dictionary.master,
                      child: Text(
                        Dictionary.master,
                        style: TextStyles.mainText,
                      ),
                    ),
                  ],
                  value: _addUpdateController.stage,
                  onChanged: (String? value) {
                    _addUpdateController.stage = value;
                    _addUpdateController.update();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                width: 625,
                child: DropdownButton<bool>(
                  dropdownColor: ThemeColors.backgroundSecondary,
                  focusColor: ThemeColors.backgroundSecondary,
                  hint: Text(
                    Dictionary.graduationIndicator,
                    style: TextStyles.hintText.copyWith(
                        color: ThemeColors.hintTextColor, fontSize: 14),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: null,
                      child: Text(
                        Dictionary.inProcess,
                        style: TextStyles.mainText,
                      ),
                    ),
                    DropdownMenuItem(
                      value: true,
                      child: Text(
                        Dictionary.successGraduation,
                        style: TextStyles.mainText,
                      ),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text(
                        Dictionary.failureGraduation,
                        style: TextStyles.mainText,
                      ),
                    ),
                  ],
                  value: _addUpdateController.graduationIndicator,
                  onChanged: _addUpdateController.graduationUpdate,
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Dictionary.yearOfEntering,
                          style: TextStyles.mainText.copyWith(
                            color: ThemeColors.textColorPrimary,
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          width: 300,
                          child: YearPicker(
                            firstDate: DateTime(1970),
                            lastDate: DateTime(DateTime.now().year),
                            selectedDate: _addUpdateController.yearOfAdmission,
                            onChanged: (DateTime value) {
                              if (_addUpdateController.yearOfGraduation !=
                                      null &&
                                  _addUpdateController.yearOfGraduation!.year <
                                      value.year) {
                                _addUpdateController.yearOfGraduation = null;
                              }
                              _addUpdateController.yearOfAdmission = value;
                              _addUpdateController.update();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Visibility(
                    visible: _addUpdateController.graduationIndicator != null,
                    child: Flexible(
                      child: Column(
                        children: [
                          Text(
                            Dictionary.yearOfEnding,
                            style: TextStyles.mainText.copyWith(
                              color: ThemeColors.textColorPrimary,
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: YearPicker(
                              firstDate: _addUpdateController.yearOfAdmission,
                              lastDate: DateTime(DateTime.now().year),
                              selectedDate:
                                  _addUpdateController.yearOfGraduation,
                              onChanged: (DateTime value) {
                                _addUpdateController.yearOfGraduation = value;
                                _addUpdateController.update();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

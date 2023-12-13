import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/add_update_controller.dart';
import 'package:students_list/presentation/pages/add_update_data_page/components/custom_enter_field.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class ScientificSupervisor extends StatelessWidget {
  const ScientificSupervisor({super.key});
  static final _addUpdateController = Get.find<AddUpdateController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddUpdateController>(
      init: _addUpdateController,
      builder: (controller) {
        return Visibility(
          visible: _addUpdateController.faculty != null &&
              _addUpdateController.departmentName != null &&
              _addUpdateController.faculty != Dictionary.nonChose &&
              _addUpdateController.departmentName != Dictionary.nonChose,
          child: Container(
            margin: const EdgeInsets.only(bottom: 25),
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
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Dictionary.scientificAdvisorInfo,
                      style: TextStyles.header
                          .copyWith(color: ThemeColors.textColorPrimary),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        _addUpdateController.clearSupervisorFields();
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
                CustomEnterField(
                  textEditingController: _addUpdateController.supervisorSurname,
                  labelText: Dictionary.surname,
                  padding: const EdgeInsets.only(bottom: 16),
                  onChanged: (String value) {
                    _addUpdateController.update();
                  },
                ),
                CustomEnterField(
                  textEditingController:
                      _addUpdateController.supervisorFirstName,
                  labelText: Dictionary.firstName,
                  padding: const EdgeInsets.only(bottom: 16),
                  onChanged: (String value) {
                    _addUpdateController.update();
                  },
                ),
                CustomEnterField(
                  textEditingController:
                      _addUpdateController.supervisorFatherName,
                  labelText: Dictionary.fatherName,
                  padding: const EdgeInsets.only(bottom: 4),
                  onChanged: (String value) {
                    _addUpdateController.update();
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  width: 625,
                  child: DropdownButton<String>(
                    dropdownColor: ThemeColors.backgroundSecondary,
                    focusColor: ThemeColors.backgroundSecondary,
                    hint: Text(
                      Dictionary.post,
                      style: TextStyles.hintText.copyWith(
                          color: ThemeColors.hintTextColor, fontSize: 14),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: Dictionary.departmentAssistant,
                        child: Text(
                          Dictionary.departmentAssistant,
                          style: TextStyles.mainText,
                        ),
                      ),
                      DropdownMenuItem(
                        value: Dictionary.seniorLecture,
                        child: Text(
                          Dictionary.seniorLecture,
                          style: TextStyles.mainText,
                        ),
                      ),
                      DropdownMenuItem(
                        value: Dictionary.docent,
                        child: Text(
                          Dictionary.docent,
                          style: TextStyles.mainText,
                        ),
                      ),
                      DropdownMenuItem(
                        value: Dictionary.professor,
                        child: Text(
                          Dictionary.professor,
                          style: TextStyles.mainText,
                        ),
                      ),
                      DropdownMenuItem(
                        value: Dictionary.departmentHead,
                        child: Text(
                          Dictionary.departmentHead,
                          style: TextStyles.mainText,
                        ),
                      ),
                    ],
                    value: _addUpdateController.post,
                    onChanged: (String? value) {
                      _addUpdateController.post = value!;
                      _addUpdateController.update();
                    },
                  ),
                ),
                SizedBox(
                  width: 625,
                  child: DropdownButton<String>(
                    dropdownColor: ThemeColors.backgroundSecondary,
                    focusColor: ThemeColors.backgroundSecondary,
                    hint: Text(
                      Dictionary.academicDegree,
                      style: TextStyles.hintText.copyWith(
                          color: ThemeColors.hintTextColor, fontSize: 14),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: Dictionary.candidate,
                        child: Text(
                          Dictionary.candidate,
                          style: TextStyles.mainText,
                        ),
                      ),
                      DropdownMenuItem(
                        value: Dictionary.doctor,
                        child: Text(
                          Dictionary.doctor,
                          style: TextStyles.mainText,
                        ),
                      ),
                    ],
                    value: _addUpdateController.academicDegree,
                    onChanged: (String? value) {
                      _addUpdateController.academicDegree = value!;
                      _addUpdateController.update();
                    },
                  ),
                ),
                // CustomEnterField(
                //   textEditingController: _addUpdateController.post,
                //   labelText: Dictionary.post,
                //   padding: const EdgeInsets.only(bottom: 16),
                //   onChanged: (String value) {
                //     _addUpdateController.update();
                //   },
                // ),
                // CustomEnterField(
                //   textEditingController: _addUpdateController.academicDegree,
                //   labelText: Dictionary.academicDegree,
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

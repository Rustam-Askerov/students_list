import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/add_update_controller.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class AddUpdateData extends StatelessWidget {
  const AddUpdateData({super.key});
  static final _addUpdateController = Get.find<AddUpdateController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddUpdateController>(
      init: _addUpdateController,
      builder: (controller) {
        return Scaffold(
          backgroundColor: ThemeColors.backgroundPrimary,
          body: SingleChildScrollView(
            controller: ScrollController(),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const IntrinsicWidth(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(child: StudentInfo()),
                          SizedBox(
                            width: 25,
                          ),
                          Flexible(child: DepartmentInfo()),
                        ],
                      ),
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
                        _addUpdateController.addRow();
                      },
                      child: SizedBox(
                        height: 50,
                        width: 400,
                        child: Center(
                          child: Text(
                            Dictionary.saveInfoAboutStudent,
                            style: TextStyles.header
                                .copyWith(color: ThemeColors.textColorPrimary),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key});
  static final _addUpdateController = Get.find<AddUpdateController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddUpdateController>(
      init: _addUpdateController,
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Dictionary.studentsInfo,
              style: TextStyles.header
                  .copyWith(color: ThemeColors.textColorPrimary),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomEnterField(
              textEditingController: _addUpdateController.fioController,
              labelText: Dictionary.fio,
              padding: const EdgeInsets.only(bottom: 16),
            ),
            CustomEnterField(
              textEditingController: _addUpdateController.studNum,
              labelText: Dictionary.studNum,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              padding: const EdgeInsets.only(bottom: 16),
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
                          selectedDate: _addUpdateController.yearOfEntering,
                          onChanged: (DateTime value) {
                            _addUpdateController.yearOfEntering = value;
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
                Flexible(
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
                          firstDate: DateTime(1970),
                          lastDate: DateTime(DateTime.now().year),
                          selectedDate: _addUpdateController.yearOfEnding,
                          onChanged: (DateTime value) {
                            _addUpdateController.yearOfEnding = value;
                            _addUpdateController.update();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DropdownButton<String>(
                dropdownColor: ThemeColors.backgroundSecondary,
                focusColor: ThemeColors.backgroundSecondary,
                hint: Text(
                  Dictionary.degree,
                  style: TextStyles.hintText
                      .copyWith(color: ThemeColors.hintTextColor, fontSize: 14),
                ),
                items: const [
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
                value: _addUpdateController.degree,
                onChanged: (String? value) {
                  _addUpdateController.degree = value;
                  _addUpdateController.update();
                },
              ),
            ),
            CustomEnterField(
              textEditingController: _addUpdateController.vkrName,
              labelText: Dictionary.vkrName,
              padding: const EdgeInsets.only(bottom: 4),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DropdownButton<String>(
                dropdownColor: ThemeColors.backgroundSecondary,
                focusColor: ThemeColors.backgroundSecondary,
                hint: Text(
                  Dictionary.vkrMark,
                  style: TextStyles.hintText
                      .copyWith(color: ThemeColors.hintTextColor, fontSize: 14),
                ),
                items: const [
                  DropdownMenuItem(
                    value: Dictionary.dontExists,
                    child: Text(
                      Dictionary.dontExists,
                      style: TextStyles.mainText,
                    ),
                  ),
                  DropdownMenuItem(
                    value: Dictionary.greate,
                    child: Text(
                      Dictionary.greate,
                      style: TextStyles.mainText,
                    ),
                  ),
                  DropdownMenuItem(
                    value: Dictionary.good,
                    child: Text(
                      Dictionary.good,
                      style: TextStyles.mainText,
                    ),
                  ),
                  DropdownMenuItem(
                    value: Dictionary.satisfactorily,
                    child: Text(
                      Dictionary.satisfactorily,
                      style: TextStyles.mainText,
                    ),
                  ),
                ],
                value: _addUpdateController.vkrMark,
                onChanged: (String? value) {
                  _addUpdateController.vkrMark = value!;
                  _addUpdateController.update();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class DepartmentInfo extends StatelessWidget {
  const DepartmentInfo({super.key});
  static final _addUpdateController = Get.find<AddUpdateController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddUpdateController>(
      init: _addUpdateController,
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Dictionary.departmentInfo,
              style: TextStyles.header
                  .copyWith(color: ThemeColors.textColorPrimary),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DropdownButton<String>(
                  dropdownColor: ThemeColors.backgroundSecondary,
                  focusColor: ThemeColors.backgroundSecondary,
                  hint: Text(
                    Dictionary.faculty,
                    style: TextStyles.hintText.copyWith(
                        color: ThemeColors.hintTextColor, fontSize: 14),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: Dictionary.mathFaculty,
                      child: Text(
                        Dictionary.mathFaculty,
                        style: TextStyles.mainText,
                      ),
                    ),
                    DropdownMenuItem(
                      value: Dictionary.ivtFaculty,
                      child: Text(
                        Dictionary.ivtFaculty,
                        style: TextStyles.mainText,
                      ),
                    ),
                  ],
                  value: _addUpdateController.faculty,
                  onChanged: (String? value) {
                    _addUpdateController.faculty = value;
                    _addUpdateController.update();
                  }),
            ),
            CustomEnterField(
              textEditingController: _addUpdateController.departmentName,
              labelText: Dictionary.departmentName,
              padding: const EdgeInsets.only(bottom: 4),
            ),
            CustomEnterField(
              textEditingController: _addUpdateController.departmentHead,
              labelText: Dictionary.departmentHead,
              padding: const EdgeInsets.only(top: 16),
            ),
          ],
        );
      },
    );
  }
}

class CustomEnterField extends StatelessWidget {
  const CustomEnterField(
      {super.key,
      required this.labelText,
      required this.textEditingController,
      this.padding = EdgeInsets.zero,
      this.onChanged,
      this.onEditingComplete,
      this.inputFormatters});
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? textEditingController;
  final EdgeInsets padding;
  final String labelText;
  final void Function(String value)? onChanged;
  final void Function()? onEditingComplete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 50,
        width: 625,
        child: TextFormField(
          controller: textEditingController,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 14, left: 22),
            labelText: labelText,
            labelStyle:
                TextStyles.mainText.copyWith(color: ThemeColors.hintTextColor),
            filled: true,
            fillColor: ThemeColors.backgroundSecondary,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ThemeColors.backgroundSecondary,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(
                color: ThemeColors.backgroundSecondary,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
        ),
      ),
    );
  }
}

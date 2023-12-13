import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/add_update_controller.dart';
import 'package:students_list/presentation/pages/add_update_data_page/components/custom_enter_field.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class ScientificWork extends StatelessWidget {
  const ScientificWork({super.key});
  static final _addUpdateController = Get.find<AddUpdateController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _addUpdateController,
      builder: (controller) => Visibility(
        visible: _addUpdateController.supervisorSurname.text != '' &&
            _addUpdateController.supervisorFirstName.text != '' &&
            _addUpdateController.supervisorFatherName.text != '' &&
            _addUpdateController.post != null,
        child: Container(
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
                    Dictionary.scientificWorkInfo,
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
                      _addUpdateController.clearScientificWorkFields();
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
                textEditingController: _addUpdateController.workName,
                labelText: Dictionary.workName,
                padding: const EdgeInsets.only(bottom: 16),
              ),
              Container(
                height: 50,
                width: 625,
                margin: const EdgeInsets.only(bottom: 4),
                child: TextFormField(
                  readOnly: true,
                  controller: _addUpdateController.workDueDateText,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 14, left: 22),
                    labelText: 'Дата сдачи работы',
                    labelStyle: TextStyles.mainText
                        .copyWith(color: ThemeColors.hintTextColor),
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
                    suffixIcon: InkWell(
                      onTap: () {
                        _addUpdateController.clearWorkDueDate();
                      },
                      child: const Icon(Icons.close),
                    ),
                  ),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
              ),
              SizedBox(
                width: 625,
                child: DropdownButton<String?>(
                  dropdownColor: ThemeColors.backgroundSecondary,
                  focusColor: ThemeColors.backgroundSecondary,
                  hint: Text(
                    Dictionary.workType,
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
                    const DropdownMenuItem(
                      value: Dictionary.courseWork,
                      child: Text(
                        Dictionary.courseWork,
                        style: TextStyles.mainText,
                      ),
                    ),
                    const DropdownMenuItem(
                      value: Dictionary.graduateWork,
                      child: Text(
                        Dictionary.graduateWork,
                        style: TextStyles.mainText,
                      ),
                    ),
                  ],
                  value: _addUpdateController.workType,
                  onChanged: _addUpdateController.updateWorkType,
                ),
              ),
              SizedBox(
                width: 625,
                child: DropdownButton<String?>(
                    dropdownColor: ThemeColors.backgroundSecondary,
                    focusColor: ThemeColors.backgroundSecondary,
                    hint: Text(
                      Dictionary.workMark,
                      style: TextStyles.hintText.copyWith(
                          color: ThemeColors.hintTextColor, fontSize: 14),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: Dictionary.dontExists,
                        child: Text(
                          Dictionary.dontExists,
                          style:
                              TextStyles.mainText.copyWith(color: Colors.grey),
                        ),
                      ),
                      const DropdownMenuItem(
                        value: Dictionary.greate,
                        child: Text(
                          Dictionary.greate,
                          style: TextStyles.mainText,
                        ),
                      ),
                      const DropdownMenuItem(
                        value: Dictionary.good,
                        child: Text(
                          Dictionary.good,
                          style: TextStyles.mainText,
                        ),
                      ),
                      const DropdownMenuItem(
                        value: Dictionary.satisfactorily,
                        child: Text(
                          Dictionary.satisfactorily,
                          style: TextStyles.mainText,
                        ),
                      ),
                    ],
                    value: _addUpdateController.assessment,
                    onChanged: _addUpdateController.updateWorkMark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale("ru", "RU"),
      initialDate: _addUpdateController.workDueDate,
      firstDate: DateTime(1970, 1, 1),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ThemeColors.textColorPrimary,
              onPrimary: ThemeColors.backgroundSecondary,
              onSurface: ThemeColors.textColorPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _addUpdateController.workDueDate) {
      _addUpdateController.updateWorkDueDate(picked);
    }
  }
}
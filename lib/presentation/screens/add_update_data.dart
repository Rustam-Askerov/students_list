import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:students_list/data/models/student_model.dart';
import 'package:students_list/presentation/controllers/add_update_controller.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class AddUpdateData extends StatefulWidget {
  const AddUpdateData(
      {super.key, required this.addUpdate, this.student, this.studentIndex});
  //если true то добавление, если false то редактирование
  final bool addUpdate;
  final int? studentIndex;
  final StudentModel? student;
  @override
  State<AddUpdateData> createState() => _AddUpdateDataState();
}

class _AddUpdateDataState extends State<AddUpdateData> {
  static final _addUpdateController = Get.find<AddUpdateController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.addUpdate
          ? _addUpdateController.getDataCreate()
          : _addUpdateController.getDataUpdate(widget.student!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              width: 100,
              height: 20,
              child: LinearProgressIndicator(
                color: ThemeColors.textColorPrimary,
              ),
            ),
          );
        } else {
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
                      padding: const EdgeInsets.all(30.0).copyWith(top: 0),
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
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DepartmentInfo(),
                                      ScientificSupervisor(),
                                      ScientificWork(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                            onPressed: () async {
                              widget.addUpdate
                                  ? await _addUpdateController
                                      .addStudent()
                                      .then((value) => Get.back())
                                  : await _addUpdateController
                                      .updateStudent(widget.student!)
                                      .then((value) => Get.back());
                            },
                            child: SizedBox(
                              height: 50,
                              width: 400,
                              child: Center(
                                child: Text(
                                  Dictionary.saveInfoAboutStudent,
                                  style: TextStyles.header.copyWith(
                                      color: ThemeColors.textColorPrimary),
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
        return Container(
          padding: const EdgeInsets.all(16).copyWith(bottom: 78),
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
                margin: const EdgeInsets.only(bottom: 16),
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
                              firstDate: DateTime(1970),
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
            _addUpdateController.post.text != '',
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
                  padding: const EdgeInsets.only(bottom: 16),
                  onChanged: (String value) {
                    _addUpdateController.update();
                  },
                ),
                CustomEnterField(
                  textEditingController: _addUpdateController.post,
                  labelText: Dictionary.post,
                  padding: const EdgeInsets.only(bottom: 16),
                  onChanged: (String value) {
                    _addUpdateController.update();
                  },
                ),
                CustomEnterField(
                  textEditingController: _addUpdateController.academicDegree,
                  labelText: Dictionary.academicDegree,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

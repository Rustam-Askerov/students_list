import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/data/models/work_model.dart';
import 'package:students_list/presentation/controllers/student_info_page_controller.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class WorkInfoView extends StatelessWidget {
  const WorkInfoView({super.key, required this.work});
  final WorkModel work;

  static final StudentInfoPageController _studentInfoPageController =
      Get.find<StudentInfoPageController>();
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(500),
        1: FixedColumnWidth(500),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(21, 14, 21, 14),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: ThemeColors.textColorPrimary),
                  left: BorderSide(color: ThemeColors.textColorPrimary),
                ),
              ),
              child: Text(
                Dictionary.workNameTable,
                style: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(21, 14, 21, 14),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: ThemeColors.textColorPrimary),
                  left: BorderSide(color: ThemeColors.textColorPrimary),
                ),
              ),
              child: Text(
                work.name,
                style: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(21, 14, 21, 14),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: ThemeColors.textColorPrimary),
                  left: BorderSide(color: ThemeColors.textColorPrimary),
                ),
              ),
              child: Text(
                Dictionary.workDueDateTable,
                style: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(21, 14, 21, 14),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: ThemeColors.textColorPrimary),
                  left: BorderSide(color: ThemeColors.textColorPrimary),
                ),
              ),
              child: Text(
                work.workDueDate != null
                    ? _studentInfoPageController
                        .formateDate(work.workDueDate!.substring(0, 10))
                    : '',
                style: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(21, 14, 21, 14),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: ThemeColors.textColorPrimary),
                  left: BorderSide(color: ThemeColors.textColorPrimary),
                ),
              ),
              child: Text(
                Dictionary.workTypeTable,
                style: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(21, 14, 21, 14),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: ThemeColors.textColorPrimary),
                  left: BorderSide(color: ThemeColors.textColorPrimary),
                ),
              ),
              child: Text(
                work.workType,
                style: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(21, 14, 21, 14),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: ThemeColors.textColorPrimary),
                  left: BorderSide(color: ThemeColors.textColorPrimary),
                ),
              ),
              child: Text(
                Dictionary.assessmentTable,
                style: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(21, 14, 21, 14),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: ThemeColors.textColorPrimary),
                  left: BorderSide(color: ThemeColors.textColorPrimary),
                ),
              ),
              child: Text(
                work.assesment ?? '',
                style: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

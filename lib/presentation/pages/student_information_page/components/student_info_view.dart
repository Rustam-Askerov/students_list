import 'package:flutter/material.dart';
import 'package:students_list/data/models/student_model.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class StudentInfoView extends StatelessWidget {
  const StudentInfoView({super.key, required this.student});
  final StudentModel student;
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
                Dictionary.fullName,
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
                student.fullName,
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
                Dictionary.studNumber,
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
                student.studentIDnumber.toString(),
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
                Dictionary.yearOfAdmissionTable,
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
                student.dateOfAdmission.toString(),
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
                Dictionary.yearOfGraduationTable,
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
                (student.dateOfGraduation ?? '').toString(),
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
                Dictionary.stageTable,
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
                student.stage,
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
                Dictionary.yearOfGraduationTable,
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
                student.isGraduate == null
                    ? 'Обучается'
                    : student.isGraduate!
                        ? 'Окончено'
                        : 'Не окончено',
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
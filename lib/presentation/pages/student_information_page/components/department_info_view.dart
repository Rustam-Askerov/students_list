import 'package:flutter/material.dart';
import 'package:students_list/data/models/department_model.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class DepartmentInfoView extends StatelessWidget {
  const DepartmentInfoView({super.key, required this.department});
  final DepartmentModel department;
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
                Dictionary.tableFaculty,
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
                department.faculty,
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
                Dictionary.department,
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
                department.departmentName.toString(),
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
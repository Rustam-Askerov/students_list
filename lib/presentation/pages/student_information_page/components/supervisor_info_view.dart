import 'package:flutter/material.dart';
import 'package:students_list/data/models/scientific_supervisor_model.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class SupervisorInfoView extends StatelessWidget {
  const SupervisorInfoView({super.key, required this.supervisor});
  final ScientificSupervisorModel supervisor;
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
              
              child: Text(
                Dictionary.fullName,
                style: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(21, 14, 21, 14),
              
              child: Text(
                supervisor.fullName,
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
              
              child: Text(
                Dictionary.post,
                style: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(21, 14, 21, 14),
              
              child: Text(
                supervisor.post,
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
              
              child: Text(
                Dictionary.academicDegreeTable,
                style: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(21, 14, 21, 14),
              
              child: Text(
                supervisor.academicDegree ?? '',
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
import 'package:flutter/material.dart';
import 'package:flutter_editable_table/flutter_editable_table.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';
import 'package:students_list/presentation/widgets/customizable_table.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundPrimary,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 32, 30, 32),
        child: Column(
          children: [
            const Header(),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              height: 1,
              color: ThemeColors.dividerColor,
            ),
            const SizedBox(
              height: 18,
            ),
            SingleChildScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.horizontal,
              child: CustomizableTable(
                fieldsDecoration: BoxDecoration(
                    color: ThemeColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(8)),
                rowsDecoration: BoxDecoration(
                    color: ThemeColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(8)),
                fieldsTextStyle: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
                fields: Dictionary.fields,
                filedsMargin: 10,
                rowsData: const [
                  [
                    ' ',
                    'Иванов Иван Ивановиииииииич',
                    '2648951',
                    'Мат.анализ',
                    '2019',
                    'Бакалавр',
                    'aaaaaaaaaa',
                    'bbbbbbbbbbbbbbbbbbb',
                    'Отлично',
                    'Математический',
                    'Мат.анализ',
                    'Невский М.В.'
                  ],
                  [
                    ' ',
                    'Иванов Иван Иванович',
                    '2648951',
                    'Мат.анализ',
                    '2019',
                    'Бакалавр',
                    'aaaaaaaaaa',
                    'bbbbbbbbbbbbbbbbbbb',
                    'Отлично',
                    'Математический',
                    'Мат.анализ',
                    'Невский М.В.'
                  ],
                  [
                    ' ',
                    'Иванов Иван Иванович',
                    '2648951',
                    'Мат.анализ',
                    '2019',
                    'Бакалавр',
                    'aaaaaaaaaa',
                    'bbbbbbbbbbbbbbbbbbb',
                    'Отлично',
                    'Математический',
                    'Мат.анализ',
                    'Невский М.В.'
                  ],
                ],
                rowDataTextStyle: TextStyles.mainText
                    .copyWith(color: ThemeColors.textColorPrimary),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Fields extends StatelessWidget {
  const Fields({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ThemeColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 90,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 90.0),
          child: Text(
            Dictionary.studentsInfoHeader,
            style: TextStyles.header.copyWith(
              color: ThemeColors.textColorPrimary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(),
          child: SizedBox(
            height: 35,
            width: 840,
            child: TextFormField(
              autofocus: false,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 2, left: 22),
                hintText: 'Поиск',
                hintStyle: TextStyles.hintText
                    .copyWith(color: ThemeColors.hintTextColor),
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 11),
                  child: Icon(
                    Icons.search,
                    color: ThemeColors.searchIconColor,
                  ),
                ),
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
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 90),
          child: InkWell(
            onTap: () {},
            child: IntrinsicWidth(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 30, top: 4, bottom: 6, right: 10),
                decoration: BoxDecoration(
                  color: ThemeColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      Dictionary.addButton,
                      style: TextStyles.mainText
                          .copyWith(color: ThemeColors.addIcon),
                    ),
                    const SizedBox(
                      width: 38,
                    ),
                    Image.asset(
                      'assets/icons/add.png',
                      height: 25,
                      width: 23,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

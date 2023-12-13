import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/home_page_controller.dart';
import 'package:students_list/presentation/pages/home_page/components/header.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';
import 'package:students_list/presentation/widgets/customizable_table.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final homeScreenController = Get.find<HomePageController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homeScreenController.getData(),
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
                  Expanded(
                    child: GetBuilder(
                      init: homeScreenController,
                      builder: (controller) => CustomizableTable(
                        fieldsDecoration: BoxDecoration(
                          color: ThemeColors.backgroundSecondary,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: ThemeColors.hintTextColor.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                        rowsDecoration: BoxDecoration(
                          color: ThemeColors.backgroundSecondary,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: ThemeColors.hintTextColor.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                        fieldsTextStyle: TextStyles.mainText.copyWith(
                            color: ThemeColors.textColorPrimary,
                            fontWeight: FontWeight.w600),
                        fields: Dictionary.fields,
                        fieldsMargin: 10,
                        rowsData: controller.rows,
                        data: homeScreenController.data,
                        rowDataTextStyle: TextStyles.mainText
                            .copyWith(color: ThemeColors.textColorPrimary),
                        deleteRow: controller.deleteStudent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}





import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/home_screen_controller.dart';
import 'package:students_list/presentation/screens/add_update_data.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';
import 'package:students_list/presentation/widgets/customizable_table.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final homeScreenController = Get.find<HomeScreenController>();
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

class Header extends StatelessWidget {
  const Header({super.key});

  static final homeScreenController = Get.find<HomeScreenController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: homeScreenController,
      builder: (controller) => Wrap(
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
            child: IntrinsicWidth(
              stepWidth: 500,
              child: Container(
                decoration: BoxDecoration(
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
                height: 35,
                child: TextFormField(
                  autofocus: false,
                  enableInteractiveSelection: false,
                  controller: homeScreenController.searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 2, left: 22),
                    hintText: 'Поиск',
                    hintStyle: TextStyles.hintText
                        .copyWith(color: ThemeColors.hintTextColor),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.search,
                        color: ThemeColors.searchIconColor,
                      ),
                    ),
                    suffixIcon: Visibility(
                      visible: homeScreenController.searchController.text != '',
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          homeScreenController.searchController.clear();
                          homeScreenController.search();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 11),
                          child: Icon(
                            Icons.close,
                            color: ThemeColors.searchIconColor,
                          ),
                        ),
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
                  onChanged: (String value) {
                    homeScreenController.search();
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 90),
            decoration: BoxDecoration(
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
            child: ElevatedButton(
              style: ButtonStyle(
                shadowColor: const MaterialStatePropertyAll(
                    Colors.transparent),
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
                Get.to(
                    () => const AddUpdateData(
                          addUpdate: true,
                        ),
                    routeName: '/AddUpdateData');
              },
              child: IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.only(left: 6, top: 4, bottom: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          Dictionary.addButton,
                          style: TextStyles.mainText
                              .copyWith(color: ThemeColors.addIcon),
                        ),
                        const SizedBox(
                          width: 25,
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
            ),
          ),
        ],
      ),
    );
  }
}

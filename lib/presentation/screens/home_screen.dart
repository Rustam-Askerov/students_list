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
        return GetBuilder(
          init: homeScreenController,
          builder: (controller) => Scaffold(
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
                      fieldsMargin: 10,
                      rowsData: homeScreenController.getRows(),
                      rowDataTextStyle: TextStyles.mainText
                          .copyWith(color: ThemeColors.textColorPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
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
              child: SizedBox(
                height: 35,
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
          ),
          Padding(
            padding: const EdgeInsets.only(right: 90),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                Get.to(() => const AddUpdateData(),
                    routeName: '/AddUpdateData');
              },
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
      ),
    );
  }
}

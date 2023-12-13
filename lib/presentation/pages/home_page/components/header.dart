import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/enums/filter_enums.dart';
import 'package:students_list/presentation/controllers/home_page_controller.dart';
import 'package:students_list/presentation/pages/add_update_data_page/add_update_data_page.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  static final homeScreenController = Get.find<HomePageController>();
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
                    suffixIcon: SizedBox(
                      width: 64,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible:
                                homeScreenController.searchController.text !=
                                    '',
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                homeScreenController.searchController.clear();
                                homeScreenController.search();
                              },
                              child: const Icon(
                                Icons.close,
                                color: ThemeColors.searchIconColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11),
                            child: InkWell(
                              onTap: () {
                                _showFilters(context, homeScreenController);
                              },
                              child: const Icon(
                                Icons.tune,
                                color: ThemeColors.searchIconColor,
                              ),
                            ),
                          ),
                        ],
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
                shadowColor: const MaterialStatePropertyAll(Colors.transparent),
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
                    () => const AddUpdateDataPage(
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

Future<void> _showFilters(
    BuildContext context, HomePageController controller) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ThemeColors.backgroundPrimary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  Dictionary.filters,
                  style: TextStyles.header
                      .copyWith(color: ThemeColors.textColorPrimary),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Dictionary.alphabet,
                        style: TextStyles.header.copyWith(
                          color: ThemeColors.textColorPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio<AlphabetFilter>(
                              value: AlphabetFilter.up,
                              groupValue: controller.alphabetFilter.value,
                              onChanged: (AlphabetFilter? value) {
                                controller.updateAlphabetValue(value!);
                                controller.callAllFilters();
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              Dictionary.up,
                              style: TextStyles.mainText.copyWith(
                                  color: ThemeColors.textColorPrimary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio<AlphabetFilter>(
                              value: AlphabetFilter.down,
                              groupValue: controller.alphabetFilter.value,
                              onChanged: (AlphabetFilter? value) {
                                controller.updateAlphabetValue(value!);
                                controller.callAllFilters();
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              Dictionary.down,
                              style: TextStyles.mainText.copyWith(
                                  color: ThemeColors.textColorPrimary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Dictionary.yearOfAdmission,
                        style: TextStyles.header.copyWith(
                          color: ThemeColors.textColorPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio<YearOfAdmission>(
                              value: YearOfAdmission.up,
                              groupValue: controller.yearOfAdmission.value,
                              onChanged: (YearOfAdmission? value) {
                                controller.updateYearOfAdmissionValue(value!);
                                controller.callAllFilters();
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              Dictionary.up,
                              style: TextStyles.mainText.copyWith(
                                  color: ThemeColors.textColorPrimary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio<YearOfAdmission>(
                              value: YearOfAdmission.down,
                              groupValue: controller.yearOfAdmission.value,
                              onChanged: (YearOfAdmission? value) {
                                controller.updateYearOfAdmissionValue(value!);
                                controller.callAllFilters();
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              Dictionary.down,
                              style: TextStyles.mainText.copyWith(
                                  color: ThemeColors.textColorPrimary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Dictionary.yearOfGraduation,
                        style: TextStyles.header.copyWith(
                          color: ThemeColors.textColorPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio<YearOfGraduation>(
                              value: YearOfGraduation.up,
                              groupValue: controller.yearOfGraduation.value,
                              onChanged: (YearOfGraduation? value) {
                                controller.updateYearOfGraduationValue(value!);
                                controller.callAllFilters();
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              Dictionary.up,
                              style: TextStyles.mainText.copyWith(
                                  color: ThemeColors.textColorPrimary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio<YearOfGraduation>(
                              value: YearOfGraduation.down,
                              groupValue: controller.yearOfGraduation.value,
                              onChanged: (YearOfGraduation? value) {
                                controller.updateYearOfGraduationValue(value!);
                                controller.callAllFilters();
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              Dictionary.down,
                              style: TextStyles.mainText.copyWith(
                                  color: ThemeColors.textColorPrimary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Dictionary.studyingIndication,
                        style: TextStyles.header.copyWith(
                          color: ThemeColors.textColorPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio<StudyingIndicationFilter>(
                              value: StudyingIndicationFilter.inProcess,
                              groupValue: controller.studyingIndication.value,
                              onChanged: (StudyingIndicationFilter? value) {
                                controller
                                    .updateStudyingIndicationValue(value!);
                                controller.callAllFilters();
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              Dictionary.inProcess,
                              style: TextStyles.mainText.copyWith(
                                  color: ThemeColors.textColorPrimary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio<StudyingIndicationFilter>(
                              value: StudyingIndicationFilter.complete,
                              groupValue: controller.studyingIndication.value,
                              onChanged: (StudyingIndicationFilter? value) {
                                controller
                                    .updateStudyingIndicationValue(value!);
                                controller.callAllFilters();
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              Dictionary.successGraduation,
                              style: TextStyles.mainText.copyWith(
                                  color: ThemeColors.textColorPrimary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio<StudyingIndicationFilter>(
                              value: StudyingIndicationFilter.nonComplete,
                              groupValue: controller.studyingIndication.value,
                              onChanged: (StudyingIndicationFilter? value) {
                                controller
                                    .updateStudyingIndicationValue(value!);
                                controller.callAllFilters();
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              Dictionary.failureGraduation,
                              style: TextStyles.mainText.copyWith(
                                  color: ThemeColors.textColorPrimary),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: 500,
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
                      shadowColor:
                          const MaterialStatePropertyAll(Colors.transparent),
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
                      controller.clearFilters();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          Dictionary.clearFilters,
                          style: TextStyles.header
                              .copyWith(color: ThemeColors.textColorPrimary),
                        ),
                      ),
                    ),
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
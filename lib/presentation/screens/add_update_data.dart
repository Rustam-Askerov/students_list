import 'package:flutter/material.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class AddUpdateData extends StatelessWidget {
  const AddUpdateData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundPrimary,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom:16),
            child: IntrinsicWidth(
              stepWidth: 500,
              child: SizedBox(
                height: 35,
                width: 300,
                child: TextFormField(
                  autofocus: false,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 14, left: 22),
                    labelText: 'ФИО',
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
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:16),
            child: IntrinsicWidth(
              stepWidth: 500,
              child: SizedBox(
                height: 35,
                width: 300,
                child: TextFormField(
                  autofocus: false,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 14, left: 22),
                    labelText: '№ студенческого:',
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
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:16),
            child: IntrinsicWidth(
              stepWidth: 500,
              child: SizedBox(
                height: 35,
                width: 300,
                child: TextFormField(
                  autofocus: false,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 14, left: 22),
                    labelText: 'Кафедра',
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
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:16),
            child: IntrinsicWidth(
              stepWidth: 500,
              child: SizedBox(
                height: 35,
                width: 300,
                child: TextFormField(
                  autofocus: false,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 14, left: 22),
                    labelText: 'Год поступления:',
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
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom:16),
            child: IntrinsicWidth(
              stepWidth: 500,
              child: SizedBox(
                height: 35,
                width: 300,
                child: TextFormField(
                  autofocus: false,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 14, left: 22),
                    labelText: 'Год поступления:',
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
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class CustomEnterField extends StatelessWidget {
  const CustomEnterField(
      {super.key,
      required this.labelText,
      required this.textEditingController,
      this.padding = EdgeInsets.zero,
      this.onChanged,
      this.onEditingComplete,
      this.inputFormatters});
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? textEditingController;
  final EdgeInsets padding;
  final String labelText;
  final void Function(String value)? onChanged;
  final void Function()? onEditingComplete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 50,
        width: 625,
        child: TextFormField(
          controller: textEditingController,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 14, left: 22),
            labelText: labelText,
            labelStyle:
                TextStyles.mainText.copyWith(color: ThemeColors.hintTextColor),
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
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/home_screen_controller.dart';

class AddUpdateController extends GetxController {
  final _homeScreenController = Get.find<HomeScreenController>();

  final TextEditingController fioController = TextEditingController(text: '');
  final TextEditingController studNum = TextEditingController(text: '');
  DateTime yearOfEntering = DateTime(DateTime.now().year);
  DateTime yearOfEnding = DateTime(DateTime.now().year);
  String? degree;
  final TextEditingController vkrName = TextEditingController(text: '');
  String? vkrMark;
  String? faculty;
  final TextEditingController departmentName = TextEditingController(text: '');
  final TextEditingController departmentHead = TextEditingController(text: '');

  void addRow() {
    _homeScreenController.addRow(
        fioController.text,
        int.parse(studNum.text),
        departmentName.text,
        yearOfEntering.year,
        yearOfEnding.year,
        degree!,
        false,
        vkrName.text,
        vkrMark!,
        faculty!,
        departmentName.text,
        departmentHead.text);
    _homeScreenController.update();
  }
}

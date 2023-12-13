import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/add_update_controller.dart';
import 'package:students_list/presentation/controllers/home_page_controller.dart';
import 'package:students_list/presentation/controllers/student_info_page_controller.dart';
import 'package:students_list/presentation/controllers/table_controller.dart';

class StudListBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomePageController());
    Get.put(CustomizableTableController());
    Get.put(AddUpdateController());
    Get.put(StudentInfoPageController());
  }
}

import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/home_screen_controller.dart';
import 'package:students_list/presentation/controllers/table_controller.dart';

class StudListBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
    Get.put(CustomizableTableController());
  }
}

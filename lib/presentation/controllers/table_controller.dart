import 'package:get/get.dart';

class CustomizableTableController extends GetxController {
  //ширины каждой колонки
  List<double> columnWidth = [];
  //растягивание колонки
  RxBool onHover = false.obs;
  RxInt onHoverIndex = (-1).obs;
  RxInt currentPage = 1.obs;

  void columnWidthInit(int num) {
    columnWidth = List<double>.filled(num, 150);
  }

  void updateColumnWidth(double newWidth, int index) {
    columnWidth[index] = newWidth;
    update();
  }

  void updateCurrentPage(bool next, int pageCount) {
    if (next) {
      if (currentPage.value < pageCount) {
        currentPage.value++;
        update();
      }
    } else {
      if (currentPage.value!=1){
      currentPage.value--;
      update();
      }
    }
  }
}

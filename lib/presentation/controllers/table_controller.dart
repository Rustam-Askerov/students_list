import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustomizableTableController extends GetxController {
  //ширины каждой колонки
  List<double> columnWidth = [];
  //растягивание колонки
  RxBool onHover = false.obs;
  RxInt onHoverIndex = (-1).obs;
  RxInt currentPage = 1.obs;
  TextEditingController paginationController = TextEditingController(text: '1');
  void columnWidthInit(int num) {
    columnWidth = List<double>.filled(num, 150);
    columnWidth[0] = 80;
  }

  void updateColumnWidth(double delta, int index) {
    if (columnWidth[index] > 50 || delta > 0) {
      columnWidth[index] += delta;
      update();
    }
  }

  void updatePageIndex(int index, int pageCount) {
    if (index > 0 && index <= pageCount) {
      currentPage.value = index;
    } else {
      if (index > pageCount) {
        currentPage.value = pageCount;
        paginationController.text = pageCount.toString();
      }else if(index<1){
        currentPage.value = 1;
        paginationController.text = '1';
      }
    }
    update();
  }

  void nextPreviousPage(bool next, int pageCount) {
    if (next) {
      if (currentPage.value < pageCount) {
        currentPage.value++;
        update();
      }
    } else {
      if (currentPage.value != 1) currentPage.value--;
      update();
    }
  }
}

import 'package:get/get.dart';

class CustomizableTableController extends GetxController{
  List<double> columnWidth = [];
  RxBool onHover = false.obs;
  RxInt hoverIndex = (-1).obs;
  void columnWidthInit(int num){
    columnWidth = List<double>.filled(num, 150);
  }
  void updateColumnWidth(double newWidth,int index){
    columnWidth[index]=newWidth;
    update();
  }
}
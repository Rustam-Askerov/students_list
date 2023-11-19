import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/table_controller.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';

final CustomizableTableController _tableController =
    Get.put(CustomizableTableController());

class CustomizableTable extends StatelessWidget {
  const CustomizableTable(
      {super.key,
      required this.fieldsDecoration,
      required this.rowsDecoration,
      required this.rowDataTextStyle,
      required this.fieldsTextStyle,
      required this.fields,
      this.filedsMargin = 35,
      required this.rowsData,
      this.rowsMargin = 24});
  final BoxDecoration fieldsDecoration;
  final Decoration rowsDecoration;
  final TextStyle fieldsTextStyle;
  final TextStyle rowDataTextStyle;
  final List<String> fields;
  final List<List<String>> rowsData;
  final double filedsMargin;
  final double rowsMargin;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _tableController,
      initState: (state) {
        _tableController.columnWidthInit(fields.length);
      },
      builder: (controller) => IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              margin: EdgeInsets.only(bottom: rowsMargin / 2),
              decoration: fieldsDecoration,
              child: Row(
                children: [
                  ...List.generate(
                    fields.length,
                    (index) => Container(
                      width: _tableController.columnWidth[index],
                      margin: EdgeInsets.only(
                          left: index == 0 ? 0 : filedsMargin,
                          right: index == fields.length - 1 ? 0 : filedsMargin),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SelectableText(
                              fields[index],
                              style: fieldsTextStyle,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          MouseRegion(
                            onEnter: (event) {
                              _tableController.onHover.value = true;
                              _tableController.hoverIndex.value = index;
                            },
                            onExit: (event) {
                              _tableController.onHover.value = false;
                            },
                            child: GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                details.localPosition
                                    .scale(150, details.localPosition.dy);
                                if (details.localPosition.dx > 150) {
                                  _tableController.updateColumnWidth(
                                      details.localPosition.dx, index);
                                } else {
                                  _tableController.updateColumnWidth(
                                      150, index);
                                }
                              },
                              child: Obx(
                                () => AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 7,
                                  height: 20,
                                  color: _tableController.onHover.value &&
                                          _tableController.hoverIndex.value ==
                                              index
                                      ? ThemeColors.searchIconColor
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ...List.generate(
                rowsData.length,
                (index) => TableRow(
                      rowData: rowsData[index],
                      rowsDecoration: rowsDecoration,
                      rowDataTextStyle: rowDataTextStyle,
                      filedsMargin: filedsMargin,
                      rowsMargin: rowsMargin,
                    ))
          ],
        ),
      ),
    );
  }
}

class TableRow extends StatelessWidget {
  const TableRow(
      {super.key,
      required this.rowsDecoration,
      required this.rowDataTextStyle,
      required this.rowData,
      required this.filedsMargin,
      required this.rowsMargin});
  final Decoration rowsDecoration;
  final TextStyle rowDataTextStyle;
  final List<String> rowData;
  final double rowsMargin;
  final double filedsMargin;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _tableController,
      builder: (controller) => Container(
        height: 50,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        margin: EdgeInsets.symmetric(vertical: rowsMargin / 2),
        decoration: rowsDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              rowData.length,
              (index) => Container(
                width: _tableController.columnWidth[index],
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    left: index == 0 ? 0 : filedsMargin,
                    right: index == rowData.length - 1 ? 0 : filedsMargin),
                child: SelectionArea(
                  child: Text(
                    rowData[index],
                    maxLines: 1,
                    style: rowDataTextStyle,
                    overflow: TextOverflow.ellipsis,
                    //showCursor: true,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

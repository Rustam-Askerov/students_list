import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/table_controller.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

final CustomizableTableController _tableController =
    Get.find<CustomizableTableController>();

class CustomizableTable extends StatefulWidget {
  const CustomizableTable(
      {super.key,
      required this.fieldsDecoration,
      required this.rowsDecoration,
      required this.rowDataTextStyle,
      required this.fieldsTextStyle,
      required this.fields,
      this.fieldsMargin = 35,
      required this.rowsData,
      this.rowsMargin = 24});
  final BoxDecoration fieldsDecoration;
  final Decoration rowsDecoration;
  final TextStyle fieldsTextStyle;
  final TextStyle rowDataTextStyle;
  final List<String> fields;
  final List<List<String>> rowsData;
  final double fieldsMargin;
  final double rowsMargin;

  @override
  State<CustomizableTable> createState() => _CustomizableTableState();
}

class _CustomizableTableState extends State<CustomizableTable> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _tableController,
      initState: (state) {
        _tableController.columnWidthInit(widget.fields.length);
      },
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  color: ThemeColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Text(
                    '${_tableController.currentPage} Страница из ${(widget.rowsData.length / 8).ceil()} ',
                    style: TextStyles.hintText.copyWith(
                      color: ThemeColors.textColorPrimary,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      _tableController.updateCurrentPage(
                          false, (widget.rowsData.length / 8).ceil());
                    },
                    child: const Icon(
                      Icons.arrow_left,
                      size: 32,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      _tableController.updateCurrentPage(
                          true, (widget.rowsData.length / 8).ceil());
                    },
                    child: const Icon(
                      Icons.arrow_right,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: ScrollController(),
                child: Column(
                  children: [
                    Fields(
                        fields: widget.fields,
                        fieldsDecoration: widget.fieldsDecoration,
                        fieldsTextStyle: widget.fieldsTextStyle,
                        rowsMargin: widget.rowsMargin,
                        fieldsMargin: widget.fieldsMargin),
                    ...List.generate(
                      widget.rowsData.length-(_tableController.currentPage.value-1)*8,
                      (index) => TableRow(
                        rowData: widget.rowsData[(_tableController.currentPage.value-1)*8+index],
                        rowsDecoration: widget.rowsDecoration,
                        rowDataTextStyle: widget.rowDataTextStyle,
                        filedsMargin: widget.fieldsMargin,
                        rowsMargin: widget.rowsMargin,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Fields extends StatelessWidget {
  const Fields(
      {super.key,
      required this.fields,
      required this.fieldsDecoration,
      required this.fieldsTextStyle,
      required this.rowsMargin,
      required this.fieldsMargin});
  final List<String> fields;
  final Decoration fieldsDecoration;
  final TextStyle fieldsTextStyle;
  final double rowsMargin;
  final double fieldsMargin;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
                  left: index == 0 ? 0 : fieldsMargin,
                  right: index == fields.length - 1 ? 0 : fieldsMargin),
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
                      _tableController.onHoverIndex.value = index;
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
                          _tableController.updateColumnWidth(150, index);
                        }
                      },
                      child: Obx(
                        () => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 7,
                          height: 20,
                          color: _tableController.onHover.value &&
                                  _tableController.onHoverIndex.value == index
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
        child: InkWell(
          onTap: (){
            print('clicked');
          },
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
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

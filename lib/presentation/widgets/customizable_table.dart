import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:students_list/data/models/student_model.dart';
import 'package:students_list/presentation/controllers/add_update_controller.dart';
import 'package:students_list/presentation/controllers/home_screen_controller.dart';
import 'package:students_list/presentation/controllers/table_controller.dart';
import 'package:students_list/presentation/screens/add_update_data.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

final CustomizableTableController _tableController =
    Get.find<CustomizableTableController>();

class CustomizableTable extends StatefulWidget {
  const CustomizableTable({
    super.key,
    required this.fieldsDecoration,
    required this.rowsDecoration,
    required this.rowDataTextStyle,
    required this.fieldsTextStyle,
    required this.fields,
    this.fieldsMargin = 35,
    required this.rowsData,
    required this.data,
    this.rowsMargin = 24,
    required this.deleteRow,
  });
  final BoxDecoration fieldsDecoration;
  final Decoration rowsDecoration;
  final TextStyle fieldsTextStyle;
  final TextStyle rowDataTextStyle;
  final List<String> fields;
  final List<List<String>> rowsData;
  final List<StudentModel> data;
  final double fieldsMargin;
  final double rowsMargin;
  final Future<void> Function(int id) deleteRow;

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
      builder: (controller) => IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Pagination(
                  pages: (widget.rowsData.length / 8).ceil(),
                  boxDecoration: widget.fieldsDecoration,
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
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
                        widget.rowsData.isNotEmpty
                            ? _tableController.currentPage.value !=
                                    (widget.rowsData.length / 8).ceil()
                                ? 8
                                : widget.rowsData.length -
                                    (_tableController.currentPage.value - 1) * 8
                            : 0,
                        (index) => TableRow(
                          rowData: widget.rowsData[
                              (_tableController.currentPage.value - 1) * 8 +
                                  index],
                          rowsDecoration: widget.rowsDecoration,
                          rowDataTextStyle: widget.rowDataTextStyle,
                          filedsMargin: widget.fieldsMargin,
                          rowsMargin: widget.rowsMargin,
                          deleteRow: widget.deleteRow,
                          rowIndex:
                              (_tableController.currentPage.value - 1) * 8 +
                                  index,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Pagination extends StatelessWidget {
  const Pagination(
      {super.key, required this.pages, required this.boxDecoration});
  final int pages;
  final Decoration boxDecoration;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: boxDecoration,
        child: Row(
          children: [
            Text(
              '${_tableController.currentPage} cтраница из $pages ',
              style: TextStyles.hintText.copyWith(
                color: ThemeColors.textColorPrimary,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                _tableController.nextPreviousPage(false, pages);
              },
              child: const Icon(
                Icons.arrow_left,
                size: 32,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              height: 30,
              width: 75,
              child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(bottom: 14, left: 7, right: 7),
                  labelStyle: TextStyles.mainText
                      .copyWith(color: ThemeColors.hintTextColor),
                  filled: true,
                  fillColor: ThemeColors.backgroundPrimary,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ThemeColors.textColorPrimary,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ThemeColors.textColorPrimary,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onFieldSubmitted: (String text) {
                  _tableController.updatePageIndex(int.parse(text), pages);
                },
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () {
                _tableController.nextPreviousPage(true, pages);
              },
              child: const Icon(
                Icons.arrow_right,
                size: 32,
              ),
            ),
          ],
        ),
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
                  index != 0
                      ? MouseRegion(
                          onEnter: (event) {
                            _tableController.onHover.value = true;
                            _tableController.onHoverIndex.value = index;
                          },
                          onExit: (event) {
                            _tableController.onHover.value = false;
                          },
                          child: GestureDetector(
                            onHorizontalDragUpdate: (details) {
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
                                        _tableController.onHoverIndex.value ==
                                            index
                                    ? ThemeColors.searchIconColor
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
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
  const TableRow({
    super.key,
    required this.rowsDecoration,
    required this.rowDataTextStyle,
    required this.rowData,
    required this.filedsMargin,
    required this.rowsMargin,
    required this.deleteRow,
    required this.rowIndex,
  });
  final Decoration rowsDecoration;
  final TextStyle rowDataTextStyle;
  final List<String> rowData;
  final double rowsMargin;
  final double filedsMargin;
  final int rowIndex;
  final Future<void> Function(int id) deleteRow;

  static final AddUpdateController _addUpdateController =
      Get.find<AddUpdateController>();
  static final HomeScreenController _homeScreenController =
      Get.find<HomeScreenController>();
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
          onTap: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                rowData.length,
                (index) => index == 0
                    ? Container(
                        width: _tableController.columnWidth[index],
                        margin: EdgeInsets.only(
                            left: index == 0 ? 0 : filedsMargin,
                            right:
                                index == rowData.length - 1 ? 0 : filedsMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                if (_homeScreenController
                                        .data[
                                            _homeScreenController.data.length -
                                                rowIndex -
                                                1]
                                        .isGraduate ==
                                    null) {
                                  Get.to(
                                          () => AddUpdateData(
                                                addUpdate: false,
                                                studentIndex: rowIndex,
                                                student: _homeScreenController
                                                    .data[_homeScreenController
                                                        .data.length -
                                                    rowIndex -
                                                    1],
                                              ),
                                          routeName: '/AddUpdateData')!
                                      .then((value) =>
                                          _addUpdateController.clearFields());
                                }
                              },
                              child: Image.asset(
                                'assets/icons/edit.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: () {
                                deleteRow(rowIndex);
                              },
                              child: Image.asset(
                                'assets/icons/trash.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: _tableController.columnWidth[index],
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            left: index == 0 ? 0 : filedsMargin,
                            right:
                                index == rowData.length - 1 ? 0 : filedsMargin),
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

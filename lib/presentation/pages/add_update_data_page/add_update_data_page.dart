import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:students_list/data/models/student_model.dart';
import 'package:students_list/presentation/controllers/add_update_controller.dart';
import 'package:students_list/presentation/pages/add_update_data_page/components/department_info.dart';
import 'package:students_list/presentation/pages/add_update_data_page/components/scientific_supervisor_info.dart';
import 'package:students_list/presentation/pages/add_update_data_page/components/scientific_work_info.dart';
import 'package:students_list/presentation/pages/add_update_data_page/components/student_info.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class AddUpdateDataPage extends StatefulWidget {
  const AddUpdateDataPage(
      {super.key, required this.addUpdate, this.student, this.studentIndex});
  //если true то добавление, если false то редактирование
  final bool addUpdate;
  final int? studentIndex;
  final StudentModel? student;
  @override
  State<AddUpdateDataPage> createState() => _AddUpdateDataPageState();
}

class _AddUpdateDataPageState extends State<AddUpdateDataPage> {
  static final _addUpdateController = Get.find<AddUpdateController>();
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  get developer => null;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen(_addUpdateController.updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _addUpdateController.updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.addUpdate
          ? _addUpdateController.getDataCreate()
          : _addUpdateController.getDataUpdate(widget.student!),
      builder: (context, snapshot) {
        return GetBuilder<AddUpdateController>(
          init: _addUpdateController,
          builder: (controller) {
            if (_addUpdateController.connectionStatus ==
                ConnectivityResult.none) {
              return Scaffold(
                backgroundColor: ThemeColors.backgroundPrimary,
                body: Center(
                  child: Text(
                    Dictionary.noInternet,
                    style: TextStyles.header
                        .copyWith(color: ThemeColors.textColorPrimary),
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  width: 100,
                  height: 20,
                  child: LinearProgressIndicator(
                    color: ThemeColors.textColorPrimary,
                  ),
                ),
              );
            } else if (snapshot.hasError ||
                !_addUpdateController.serviceAvaliable) {
              return Scaffold(
                backgroundColor: ThemeColors.backgroundPrimary,
                body: Center(
                  child: Text(
                    Dictionary.serviceIsNotAvaliable,
                    style: TextStyles.header
                        .copyWith(color: ThemeColors.textColorPrimary),
                  ),
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: ThemeColors.backgroundPrimary,
                body: SingleChildScrollView(
                  controller: ScrollController(),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0).copyWith(top: 0),
                      child: Column(
                        children: [
                          const IntrinsicWidth(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(child: StudentInfo()),
                                SizedBox(
                                  width: 25,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DepartmentInfo(),
                                      ScientificSupervisor(),
                                      ScientificWork(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              backgroundColor: const MaterialStatePropertyAll(
                                  ThemeColors.backgroundSecondary),
                              overlayColor: const MaterialStatePropertyAll(
                                  ThemeColors.backgroundPrimary),
                              surfaceTintColor: const MaterialStatePropertyAll(
                                  ThemeColors.backgroundSecondary),
                            ),
                            onPressed: () async {
                              if (widget.addUpdate) {
                                try {
                                  await _addUpdateController
                                      .addStudent()
                                      .then((value) => Get.back());
                                } catch (error) {
                                  if (error.toString().contains('500')) {
                                    _addUpdateController
                                        .updateServiceAvalibility(false);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        elevation: 10,
                                        backgroundColor:
                                            ThemeColors.backgroundSecondary,
                                        content: Text(
                                          error
                                              .toString()
                                              .replaceAll('Exception: ', ''),
                                          style: TextStyles.header.copyWith(
                                              color:
                                                  ThemeColors.textColorPrimary),
                                        ),
                                        action: SnackBarAction(
                                          textColor:
                                              ThemeColors.textColorPrimary,
                                          label: 'ОК',
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                }
                              } else {
                                if (_addUpdateController.checkFilledFields()) {
                                  try {
                                    await _addUpdateController
                                        .updateStudent(widget.student!)
                                        .then((value) => Get.back());
                                  } catch (error) {
                                    if (error.toString().contains('500')) {
                                      _addUpdateController
                                          .updateServiceAvalibility(false);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          elevation: 10,
                                          backgroundColor:
                                              ThemeColors.backgroundSecondary,
                                          content: Text(
                                            error
                                                .toString()
                                                .replaceAll('Exception: ', ''),
                                            style: TextStyles.header.copyWith(
                                                color: ThemeColors
                                                    .textColorPrimary),
                                          ),
                                          action: SnackBarAction(
                                            textColor:
                                                ThemeColors.textColorPrimary,
                                            label: 'ОК',
                                            onPressed: () {
                                              // Some code to undo the change.
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      elevation: 10,
                                      backgroundColor:
                                          ThemeColors.backgroundSecondary,
                                      content: Text(
                                        'Проверьте корректность и полноту введеных данных',
                                        style: TextStyles.header.copyWith(
                                            color:
                                                ThemeColors.textColorPrimary),
                                      ),
                                      action: SnackBarAction(
                                        textColor: ThemeColors.textColorPrimary,
                                        label: 'ОК',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: SizedBox(
                              height: 50,
                              width: 400,
                              child: Center(
                                child: Text(
                                  Dictionary.saveInfoAboutStudent,
                                  style: TextStyles.header.copyWith(
                                      color: ThemeColors.textColorPrimary),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

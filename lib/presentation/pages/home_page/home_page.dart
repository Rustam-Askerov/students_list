import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:students_list/presentation/controllers/home_page_controller.dart';
import 'package:students_list/presentation/controllers/internet_check_controller.dart';
import 'package:students_list/presentation/pages/home_page/components/header.dart';
import 'package:students_list/presentation/pages/home_page/components/table.dart';
import 'package:students_list/presentation/styles_and_colors/colors.dart';
import 'package:students_list/presentation/styles_and_colors/dictionary.dart';
import 'package:students_list/presentation/styles_and_colors/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  static final homePageController = Get.find<HomePageController>();
  static final internetController = Get.find<InternetCheckController>();
  get developer => null;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen(internetController.updateConnectionStatus);
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

    if (result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.none) {
      return internetController.updateConnectionStatus(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundPrimary,
      body: FutureBuilder(
        future: homePageController.getData(),
        builder: (context, snapshot) {
          return GetBuilder(
            init: internetController,
            builder: (controller) {
              if (internetController.connectionStatus ==
                  ConnectivityResult.none) {
                return Center(
                  child: Text(
                    Dictionary.noInternet,
                    style: TextStyles.header
                        .copyWith(color: ThemeColors.textColorPrimary),
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
              } else if (snapshot.hasError &&
                  snapshot.error.toString().replaceAll('Exception: ', '') !=
                      'Записей о студентах нет.') {
                return Center(
                  child: Text(
                    Dictionary.serviceIsNotAvaliable,
                    style: TextStyles.header
                        .copyWith(color: ThemeColors.textColorPrimary),
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.fromLTRB(30, 32, 30, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Header(),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        height: 1,
                        color: ThemeColors.dividerColor,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      HomePageTable(),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

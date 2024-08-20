
import 'package:doneapp_driver/shared_module/constants/style_params.constants.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackbar( BuildContext context, String text, String type) {
  double screenwidth = MediaQuery
      .of(context)
      .size
      .width;

  if (text == "") {
    if (type == "error") {
      Get.rawSnackbar(message: "something_wrong".tr,
          snackPosition: SnackPosition.TOP,
          borderRadius: APPSTYLE_BorderRadiusSmall,
          maxWidth: screenwidth * .9,
          backgroundColor: APPSTYLE_GuideRed);
    }
  } else {
    Get.rawSnackbar(message: text,
        snackPosition: SnackPosition.TOP,
        maxWidth: screenwidth * .9,
        borderRadius: APPSTYLE_BorderRadiusSmall,
        backgroundColor: type == 'error'
            ? APPSTYLE_GuideRed
            : APPSTYLE_WhatsappGreen);
  }
}
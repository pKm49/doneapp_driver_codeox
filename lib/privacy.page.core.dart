
import 'package:doneapp_driver/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/custom_curve_shape.component.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/language_preview_button.component.shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PrivacyPage_Core extends StatelessWidget {
  const PrivacyPage_Core({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: APPSTYLE_PrimaryColor,
        scrolledUnderElevation:0.0,
        elevation: 0.0,
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode:false),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'privacy_policies'.tr,
                  style: getHeadlineLargeStyle(context).copyWith(
                      fontWeight: APPSTYLE_FontWeightBold,
                      color: APPSTYLE_BackgroundWhite),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),

      ) ,
      body: InAppWebView(
        initialUrlRequest: URLRequest(url:WebUri("https://diet-steps.code-ox.com/privacy_policies") ),
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
            )
        ),
        onReceivedServerTrustAuthRequest: (controller, challenge) async {
          return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
        },
        onWebViewCreated: (InAppWebViewController controller) {
          controller = controller;
        },
        onUpdateVisitedHistory: (InAppWebViewController controller, Uri? url, bool? flag) {

        },
        onLoadStart: (InAppWebViewController controller, Uri? url) {

        },
        onLoadStop: (InAppWebViewController controller, Uri? url) async {


        },
        onProgressChanged: (InAppWebViewController controller, int progress) {



        },
      ),
    );
  }
}

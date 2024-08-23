
import 'package:doneapp_driver/shared_module/ui/components/preposticon_button.component.shared.dart';
import 'package:doneapp_driver/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp_driver/shared_module/controllers/controller.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/update_profile_pic.profile.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class MyProfilePage_Profile extends StatelessWidget {
  MyProfilePage_Profile({super.key});
  final sharedController = Get.find<SharedController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: APPSTYLE_PrimaryColorBg,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top:screenheight*.15),
              decoration: BoxDecoration(
                border: Border.all(color: APPSTYLE_PrimaryColor, width: .2),
                color: APPSTYLE_BackgroundWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(APPSTYLE_BorderRadiusLarge),
                    topRight: Radius.circular(APPSTYLE_BorderRadiusLarge)),
              ),
            ),
            Container(

              padding: APPSTYLE_LargePaddingAll.copyWith(
                  top: screenheight*.08
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: !sharedController.isUserDataFetching.value,
                              child: UpdateProfilePic(
                                isLarge:true,
                                onClick: () {
                                },
                                borderColor: APPSTYLE_Black,
                                profilePictureUrl: sharedController.userData.value.image,
                              ),
                            ),
                            Visibility(
                              visible: sharedController.isUserDataFetching.value,
                              child: Shimmer.fromColors(
                                baseColor: APPSTYLE_Grey20,
                                highlightColor: APPSTYLE_Grey40,
                                child: Container(
                                  height: screenwidth * .3,
                                  width: screenwidth * .3,

                                  decoration:
                                  APPSTYLE_BorderedContainerExtraSmallDecoration
                                      .copyWith(
                                      borderRadius: BorderRadius.circular(1000),
                                      border: Border.all(color: APPSTYLE_BackgroundWhite, width: 1),
                                      color: APPSTYLE_Grey20
                                  ),),
                              ),),
                          ],
                        ),
                        addVerticalSpace(APPSTYLE_SpaceMedium),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: sharedController.isUserDataFetching.value,
                              child: Shimmer.fromColors(
                                baseColor: APPSTYLE_Grey20,
                                highlightColor: APPSTYLE_Grey40,
                                child: Container(
                                  height: 30,
                                  width: screenwidth * .5,
                                  decoration:
                                  APPSTYLE_BorderedContainerExtraSmallDecoration
                                      .copyWith(
                                    border: null,
                                    color: APPSTYLE_Grey20,
                                    borderRadius: BorderRadius.circular(
                                        APPSTYLE_BlurRadiusSmall),
                                  ),),
                              ),),
                            Visibility(
                                visible: !sharedController.isUserDataFetching.value,
                                child: Text( "${sharedController.userData.value.name}  ",
                                  style: getHeadlineLargeStyle(context)
                                      .copyWith(color: APPSTYLE_Grey80),
                                )),

                          ],
                        ),
                        addVerticalSpace(APPSTYLE_SpaceSmall),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible:  sharedController.isUserDataFetching.value,
                              child: Shimmer.fromColors(
                                baseColor: APPSTYLE_Grey20,
                                highlightColor: APPSTYLE_Grey40,
                                child: Container(
                                  height: 25,
                                  width: screenwidth * .25,
                                  decoration:
                                  APPSTYLE_BorderedContainerExtraSmallDecoration
                                      .copyWith(
                                    border: null,
                                    color: APPSTYLE_Grey20,
                                    borderRadius: BorderRadius.circular(
                                        APPSTYLE_BorderRadiusLarge),
                                  ),),
                              ),),
                            Visibility(
                              visible:  !sharedController.isUserDataFetching.value,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusLarge),
                                    color: APPSTYLE_PrimaryColorBg
                                ),
                                padding: APPSTYLE_ExtraSmallPaddingAll.copyWith(left: APPSTYLE_SpaceMedium,right: APPSTYLE_SpaceMedium),
                                child: Text(
                                  sharedController.userData.value.code,
                                  style: getLabelSmallStyle(context)
                                      .copyWith(color: APPSTYLE_BackgroundWhite),
                                ),
                              ),
                            ),
                          ],
                        ),
                        addVerticalSpace(APPSTYLE_SpaceMedium),
                        SizedBox(
                          width: double.infinity,
                          child: PrePostIconButton(
                            specialColor: 0,
                            onPressed: () {
                              Get.toNamed(AppRouteNames.resetPasswordNewpasswordRoute,arguments: [sharedController. mobile.value]);
                            },
                            theme: 'dark',
                            border: '',
                            buttonTitle: "reset_password".tr,
                            preIconData: Ionicons.key_outline,
                            postIconData:Localizations.localeOf(context)
                                .languageCode
                                .toString() ==
                                'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                          ),
                        ),


                        SizedBox(
                          width: double.infinity,
                          child: PrePostIconButton(

                            specialColor: 0,
                            onPressed: () {
                              Get.toNamed(AppRouteNames.settingsPageRoute);
                            },
                            theme: 'dark',
                            border: '',
                            buttonTitle: "settings".tr,
                            preIconData: Ionicons.settings_outline,
                            postIconData:Localizations.localeOf(context)
                                .languageCode
                                .toString() ==
                                'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                          ),
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: PrePostIconButton(

                            specialColor: 0,
                            onPressed: () {
                              Get.toNamed(AppRouteNames.privacyRoute);
                            },
                            theme: 'dark',
                            border: '',
                            buttonTitle: "privacy_policies".tr,
                            preIconData: Ionicons.lock_closed_outline,
                            postIconData:Localizations.localeOf(context)
                                .languageCode
                                .toString() ==
                                'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                          ),
                        ),
                        addVerticalSpace(APPSTYLE_SpaceLarge ),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: PrePostIconButton(
                      specialColor: 1,
                      onPressed: () {
                        showLogoutConfirmDialogue(context);
                      },
                      theme: 'dark',
                      border: '',
                      buttonTitle: "logout".tr,
                      preIconData: Ionicons.log_out_outline,
                      postIconData:Localizations.localeOf(context)
                          .languageCode
                          .toString() ==
                          'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void showLogoutConfirmDialogue(BuildContext context ) async {

    final dialogTitleWidget = Text('confirm_logout'.tr,style: getHeadlineMediumStyle(context).copyWith(
        color: APPSTYLE_Grey80,fontWeight: APPSTYLE_FontWeightBold));
    final dialogTextWidget = Text(  'confirm_logout_message'.tr,style: getBodyMediumStyle(context),
    );

    final updateButtonTextWidget = Text('yes'.tr,style: TextStyle(color: APPSTYLE_PrimaryColor),);
    final updateButtonCancelTextWidget = Text('no'.tr,style: TextStyle(color: APPSTYLE_Black),);

    updateLogoutAction() async {
      sharedController.handleLogout();
    }

    updateAction() {
      Navigator.pop(context);
    }
    List<Widget> actions = [

      TextButton(
          onPressed:updateAction,
          style: APPSTYLE_TextButtonStylePrimary.copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,
                  vertical: APPSTYLE_SpaceSmall))),
          child:  updateButtonCancelTextWidget),

      TextButton(
          onPressed:updateLogoutAction,
          style: APPSTYLE_TextButtonStylePrimary.copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,
                  vertical: APPSTYLE_SpaceSmall))),
          child:  updateButtonTextWidget),
    ];

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            child: AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );
  }


}

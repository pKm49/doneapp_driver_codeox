

 import 'package:doneapp_driver/shared_module/ui/components/preposticon_button.component.shared.dart';
import 'package:doneapp_driver/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/update_profile_pic.profile.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class AboutPage_Profile extends StatelessWidget {
  const AboutPage_Profile({super.key});

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation:0.0,
        backgroundColor: APPSTYLE_BackgroundWhite,
        elevation: 0.0,
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode:false),

          ],
        ),
      ) ,
      body: SafeArea(
          child: Container(
            child: ListView(
              children: [
                addVerticalSpace(APPSTYLE_SpaceLarge ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ASSETS_NAMELOGO_PRIMARY,width: screenwidth*.4)
                  ],
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge*2 ),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("diet_done_caption".tr,style: getHeadlineMediumStyle(context).copyWith(color: APPSTYLE_Grey60,fontWeight: APPSTYLE_FontWeightBold)),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("diet_done_description".tr,style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_Grey40 )),
                ),

                addVerticalSpace(APPSTYLE_SpaceLarge ),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("what_we_offer".tr,style: getHeadlineMediumStyle(context)
                      .copyWith(color: APPSTYLE_Grey60,fontWeight: APPSTYLE_FontWeightBold)),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child:Row(
                    children: [
                      Expanded(
                        child: Container(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ASSETS_OFFERPLAN),
                              addVerticalSpace(APPSTYLE_SpaceSmall),
                              Text("tailored_plan".tr,
                                  textAlign: TextAlign.center,
                                  style: getLabelLargeStyle(context),maxLines: 2)
                            ],
                          ),
                        ),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                      Expanded(
                        child: Container(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ASSETS_OFFERTRACKING),
                              addVerticalSpace(APPSTYLE_SpaceSmall),
                              Text("smart_tracking".tr,
                                  textAlign: TextAlign.center,
                                  style: getLabelLargeStyle(context),maxLines: 2)
                            ],
                          ),
                        ),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                      Expanded(
                        child: Container(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ASSETS_OFFERMEAL),
                              addVerticalSpace(APPSTYLE_SpaceSmall),
                              Text("healthy_meal".tr,
                                  textAlign: TextAlign.center,
                                  style: getLabelLargeStyle(context),maxLines: 2)
                            ],
                          ),
                        ),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                      Expanded(
                        child: Container(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ASSETS_OFFERGUIDANCE),
                              addVerticalSpace(APPSTYLE_SpaceSmall),
                              Text("expert_guidance".tr,
                                  textAlign: TextAlign.center,
                                  style: getLabelLargeStyle(context),maxLines: 2)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge ),

                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("our_mission".tr,style: getHeadlineMediumStyle(context)
                      .copyWith(color: APPSTYLE_Grey60,fontWeight: APPSTYLE_FontWeightBold)),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("diet_mission".tr,style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_Grey40 )),
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge ),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("contact_us".tr,style: getHeadlineMediumStyle(context)
                      .copyWith(color: APPSTYLE_Grey60,fontWeight: APPSTYLE_FontWeightBold)),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child:Row(
                    children: [
                      Container(
                        decoration: APPSTYLE_BorderedContainerLargeDecoration.copyWith(
                          color: APPSTYLE_Black
                        ),
                        padding: APPSTYLE_SmallPaddingAll,
                        child: Icon(Ionicons.call,color: APPSTYLE_BackgroundWhite,),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                      Container(
                        decoration: APPSTYLE_BorderedContainerLargeDecoration.copyWith(
                            color: APPSTYLE_PrimaryColor
                        ),
                        padding: APPSTYLE_SmallPaddingAll,
                        child: Icon(Ionicons.mail,color: APPSTYLE_BackgroundWhite,),
                      ),
                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                      Container(
                        decoration: APPSTYLE_BorderedContainerLargeDecoration.copyWith(
                            color: APPSTYLE_WhatsappGreen
                        ),
                        padding: APPSTYLE_SmallPaddingAll,
                        child: Icon(Ionicons.logo_whatsapp,color: APPSTYLE_BackgroundWhite,),
                      )
                    ],
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceSmall ),

                Container(
                  decoration: APPSTYLE_BorderedContainerSmallDecoration.copyWith(color: APPSTYLE_Grey20),
                  padding: APPSTYLE_MediumPaddingAll,
                  margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                  child:  PrePostIconButton(
                    isRemoveVerticalPadding:true,
                    specialColor: 0,
                    onPressed: () {
                      Get.toNamed(AppRouteNames.termsRoute);
                    },
                    theme: 'dark',
                    border: '',
                    buttonTitle: "terms_n_conditions".tr,
                    preIconData: Icons.playlist_add_check_rounded,
                    postIconData:Localizations.localeOf(context)
                        .languageCode
                        .toString() ==
                        'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                  ),
                ),
                Container(
                  decoration: APPSTYLE_BorderedContainerSmallDecoration.copyWith(color: APPSTYLE_Grey20),
                  padding: APPSTYLE_MediumPaddingAll,
                  margin: APPSTYLE_LargePaddingAll.copyWith(bottom: 0),
                  child:  PrePostIconButton(
                    isRemoveVerticalPadding:true,
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
          )),
    );
  }
 
}

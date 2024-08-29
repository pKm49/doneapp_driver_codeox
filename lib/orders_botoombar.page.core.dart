import 'dart:ui';

import 'package:doneapp_driver/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/valid_order_status.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp_driver/shared_module/controllers/controller.shared.dart';
import 'package:doneapp_driver/shared_module/models/general_item.model.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/date_conversion.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/dropdown_selected_item_getter.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/custom_curve_shape.component.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/dropdown_selector.component.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/update_profile_pic.profile.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class OrdersPageBottomBar_Core extends StatelessWidget {

  OrdersPageBottomBar_Core({super.key });

  final sharedController = Get.find<SharedController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
          ()=> Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0.0,
          backgroundColor: APPSTYLE_PrimaryColor,
          centerTitle: true,
          elevation: 0.0,
          toolbarHeight: 10,
        ),
        body:  Container(
          width: screenwidth,
          height: screenheight,
          child: SafeArea(
            child: Column(
              children: [
                CustomCurveShapeComponent_Shared(
                  color: APPSTYLE_PrimaryColor,
                  title: "assigned_orders".tr ,
                ),

                // Visibility(
                //     visible:  !sharedController.isOrdersFetching.value && sharedController.myOrdersAll.isNotEmpty,
                //     child: Padding(
                //   padding: APPSTYLE_LargePaddingHorizontal.copyWith(bottom: APPSTYLE_SpaceSmall),
                //   child: Row(
                //     children: [
                //       for(var status in VALIDORDER_STATUS.values)
                //         Padding(
                //           padding: const EdgeInsets.only(right:APPSTYLE_SpaceSmall),
                //           child: InkWell(
                //             onTap: (){
                //               sharedController.changeOrderStatusFilter(status.name);
                //             },
                //             child: Container(
                //              decoration:
                //             APPSTYLE_ShadowedContainerExtraSmallDecoration.copyWith(
                //               border:  Border.all(color:
                //                   status.name == 'all'?
                //               APPSTYLE_Black: status.name == 'pending'?
                //               APPSTYLE_GuideRed:
                //               status.name == 'delivered'?
                //               APPSTYLE_WhatsappGreen:APPSTYLE_PrimaryColorBg, width: 1),
                //                 boxShadow: [ ],
                //                 color: sharedController.selectedStatus.value!=status.name?
                //                 Colors.transparent: status.name == 'all'?
                //                 APPSTYLE_Black: status.name == 'pending'?
                //                 APPSTYLE_GuideRed:
                //                 status.name == 'delivered'?
                //                 APPSTYLE_WhatsappGreen:APPSTYLE_PrimaryColorBg),
                //             padding: EdgeInsets.symmetric(
                //                 vertical: APPSTYLE_SpaceSmall,
                //                 horizontal: APPSTYLE_SpaceSmall),
                //             child: Text(status.name.tr,
                //                 style: getBodyMediumStyle(context).copyWith(
                //                     color:  sharedController.selectedStatus.value==status.name?APPSTYLE_BackgroundWhite
                //                         : status.name == 'all'?
                //                     APPSTYLE_Black: status.name == 'pending'?
                //                     APPSTYLE_GuideRed:
                //                     status.name == 'delivered'?
                //                     APPSTYLE_WhatsappGreen:APPSTYLE_PrimaryColorBg),
                //                 textAlign: TextAlign.center),
                //                                     ),
                //           ),
                //         ),
                //     ],
                //   ),
                // )),

                Visibility(
                  visible:  !sharedController.isOrdersAllFetching.value && sharedController.myOrdersAll.isEmpty,
                  child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  color: APPSTYLE_Grey20,
                                ),
                                width: screenwidth * .3,
                                height: screenwidth * .3,
                                child: Center(
                                  child: Icon(Icons.delivery_dining_outlined,
                                      size: screenwidth * .15,
                                      color: APPSTYLE_Grey80),
                                ),
                              )
                            ],
                          ),
                          addVerticalSpace(APPSTYLE_SpaceLarge),
                          Text("no_orders".tr,
                              style: getHeadlineMediumStyle(context)),
                        ],
                      )),
                ),
                Visibility(
                  visible:  !sharedController.isOrdersAllFetching.value && sharedController.myOrdersAll.isNotEmpty,
                  child: Expanded(
                      child: Container(
                        child: ListView(
                          children: [
                            addVerticalSpace(APPSTYLE_SpaceMedium),
                            for(var i=0;i<sharedController.myOrdersAll.length;i++ )
                              InkWell(
                                onTap:(){
                                  Get.toNamed(AppRouteNames.ordersDetails,arguments: [i]);
                                },
                                child: Container(
                                  decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                                  padding: APPSTYLE_MediumPaddingAll,
                                  margin: APPSTYLE_LargePaddingHorizontal.copyWith(bottom: APPSTYLE_SpaceMedium),
                                  child: Wrap(
                                    runSpacing: APPSTYLE_SpaceSmall,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    alignment: WrapAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          UpdateProfilePic(
                                            isLarge:false,
                                            borderColor: APPSTYLE_Black,
                                            profilePictureUrl: sharedController.myOrdersAll[i].image,
                                          ),
                                          addHorizontalSpace(APPSTYLE_SpaceSmall),

                                          Expanded(child: Text(
                                            Localizations.localeOf(context)
                                                .languageCode
                                                .toString() ==
                                                'ar'?sharedController.myOrdersAll[i].arabicName:
                                            sharedController.myOrdersAll[i].name,style: getHeadlineMediumStyle(context).copyWith(
                                              fontWeight: APPSTYLE_FontWeightBold
                                          ),)),
                                          addHorizontalSpace(APPSTYLE_SpaceSmall),

                                          Text('#${sharedController.myOrdersAll[i].queue}',style: getHeadlineLargeStyle(context),)
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(ASSETS_LOCATION,
                                              width: 30),
                                          addHorizontalSpace(APPSTYLE_SpaceSmall),
                                          Expanded(child:
                                          Text(
                                              "${ sharedController.myOrdersAll[i].area}, "
                                                  " ${sharedController.myOrdersAll[i].street} ${'street'.tr}, "
                                                  "${sharedController.myOrdersAll[i].jedha.trim()!='' ?('${sharedController.myOrdersAll[i].jedha} '):''}${sharedController.myOrdersAll[i].jedha.trim()!=''?('${'jedha'.tr},'):''}"
                                                  "${sharedController.myOrdersAll[i].houseNumber !=-1?'house_number'.tr:''} : ${sharedController.myOrdersAll[i].houseNumber!=-1 ?sharedController.myOrdersAll[i].houseNumber:''}"
                                                  "${sharedController.myOrdersAll[i].floorNumber !=-1?(', ${'floor_number'.tr} : '):''} ${sharedController.myOrdersAll[i].floorNumber!=-1 ?sharedController.myOrdersAll[i].floorNumber:''}" ,

                                              style: getHeadlineMediumStyle(context)))

                                        ],
                                      ),
                                      Container(
                                        width: screenwidth * .5,
                                        margin: EdgeInsets.only(top:APPSTYLE_SpaceSmall),
                                        decoration:
                                        APPSTYLE_ShadowedContainerExtraSmallDecoration.copyWith(
                                            boxShadow: [  ],
                                            color: sharedController.myOrdersAll[i].status == 'pending'?
                                            APPSTYLE_GuideRed:
                                            sharedController.myOrdersAll[i].status == 'delivered'?
                                            APPSTYLE_WhatsappGreen:APPSTYLE_PrimaryColorBg),
                                        padding: EdgeInsets.symmetric(
                                            vertical: APPSTYLE_SpaceSmall,
                                            horizontal: APPSTYLE_SpaceSmall),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(sharedController.myOrdersAll[i].status == 'pending'?
                                            Icons.timer_outlined :
                                            sharedController.myOrdersAll[i].status == 'delivered'?
                                            Icons.check_circle_outline :Icons.close,color: APPSTYLE_BackgroundWhite,
                                                size: APPSTYLE_FontSize20),
                                            addHorizontalSpace(APPSTYLE_SpaceSmall),

                                            addHorizontalSpace(APPSTYLE_SpaceExtraSmall),
                                            Expanded(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(sharedController.myOrdersAll[i].status == 'pending'?
                                                "pending".tr:
                                                sharedController.myOrdersAll[i].status == 'delivered'?
                                                'delivered'.tr :'not_delivered'.tr,
                                                    style: getBodyMediumStyle(context).copyWith(
                                                        color: APPSTYLE_BackgroundWhite),
                                                    textAlign: TextAlign.center),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                ),
                              ),
                          ],
                        ),
                      )),
                ),
                Visibility(
                  visible: sharedController.isOrdersAllFetching.value,
                  child: Expanded(
                      child: Container(
                        child: ListView(
                          children: [
                            addVerticalSpace(APPSTYLE_SpaceMedium),
                            for(var i=0;i<2;i++ )
                              Container(
                                decoration: APPSTYLE_ShadowedContainerSmallDecoration,
                                padding: APPSTYLE_MediumPaddingAll,
                                margin: APPSTYLE_LargePaddingHorizontal.copyWith(bottom: APPSTYLE_SpaceMedium),
                                height: screenheight*.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: APPSTYLE_Grey20,
                                          highlightColor: APPSTYLE_Grey40,
                                          child: Container(
                                            height: 40,
                                            width: 40,

                                            decoration:
                                            APPSTYLE_BorderedContainerExtraSmallDecoration
                                                .copyWith(
                                                borderRadius: BorderRadius.circular(1000),
                                                border: Border.all(color: APPSTYLE_BackgroundWhite, width: 1),
                                                color: APPSTYLE_Grey20
                                            ),),
                                        ),
                                        addHorizontalSpace(APPSTYLE_SpaceSmall),

                                        Shimmer.fromColors(
                                          baseColor: APPSTYLE_Grey20,
                                          highlightColor: APPSTYLE_Grey40,
                                          child: Container(
                                            width: screenwidth*.4,
                                            height: 22,
                                            decoration:
                                            APPSTYLE_BorderedContainerExtraSmallDecoration
                                                .copyWith(
                                                borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
                                                border: Border.all(color: APPSTYLE_BackgroundWhite, width: 1),
                                                color: APPSTYLE_Grey20
                                            ),),
                                        ),

                                      ],
                                    ),
                                    Divider(),
                                    Shimmer.fromColors(
                                      baseColor: APPSTYLE_Grey20,
                                      highlightColor: APPSTYLE_Grey40,
                                      child: Container(

                                        width: screenwidth-((APPSTYLE_SpaceMedium*2)+APPSTYLE_SpaceLarge*2),
                                        height: 50,

                                        decoration:
                                        APPSTYLE_BorderedContainerExtraSmallDecoration
                                            .copyWith(
                                            borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
                                            border: Border.all(color: APPSTYLE_BackgroundWhite, width: 1),
                                            color: APPSTYLE_Grey20
                                        ),),
                                    ),

                                  ],
                                ),

                              ),

                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }



}

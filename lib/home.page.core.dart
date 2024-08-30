import 'dart:ui';

import 'package:doneapp_driver/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp_driver/shared_module/controllers/controller.shared.dart';
import 'package:doneapp_driver/shared_module/models/general_item.model.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/date_conversion.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/dropdown_selected_item_getter.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/dropdown_selector.component.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/update_profile_pic.profile.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomePage_Core extends StatelessWidget {
  HomePage_Core({super.key});

  final sharedController = Get.find<SharedController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
          ()=> Scaffold(
        appBar: AppBar(
          backgroundColor: APPSTYLE_BackgroundWhite,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          toolbarHeight: 70,
          scrolledUnderElevation: 0.0,
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed(AppRouteNames.notificationsRoute);
              },
              child: Icon(Ionicons.notifications_outline,
                  color: APPSTYLE_Grey60, size: APPSTYLE_FontSize24),
            ),

            addHorizontalSpace(APPSTYLE_SpaceLarge),
          ],
        ),
        body: Container(
          width: screenwidth,
          height: screenheight,
          child: SafeArea(
            child: ListView(
              children: [
                addVerticalSpace(APPSTYLE_SpaceMedium ),
                // Container(
                //   decoration:
                //   APPSTYLE_ShadowedContainerExtraSmallDecoration.copyWith(
                //       boxShadow: [],
                //       color: APPSTYLE_Black),
                //   padding: APPSTYLE_MediumPaddingAll,
                //   margin: APPSTYLE_LargePaddingHorizontal,
                //   child: Row(
                //     children: [
                //       Icon(
                //         Icons.delivery_dining,
                //         color: APPSTYLE_BackgroundWhite,
                //       ),
                //       addHorizontalSpace(APPSTYLE_SpaceMedium),
                //       Expanded(
                //           child: Text("total_orders".tr,
                //               style: getHeadlineMediumStyle(context).copyWith(
                //                   color: APPSTYLE_BackgroundWhite))),
                //       Text(
                //         sharedController.userData.value.totalOrders.toString(),
                //         style: getHeadlineLargeStyle(context)
                //             .copyWith(color: APPSTYLE_BackgroundWhite),
                //       )
                //     ],
                //   ),
                // ),
                // addVerticalSpace(APPSTYLE_SpaceMedium),
                // Container(
                //   decoration:
                //   APPSTYLE_ShadowedContainerExtraSmallDecoration.copyWith(
                //       boxShadow: [],
                //       color: APPSTYLE_GuideRed),
                //   padding: APPSTYLE_MediumPaddingAll,
                //   margin: APPSTYLE_LargePaddingHorizontal,
                //   child: Row(
                //     children: [
                //       Icon(
                //         Icons.timer_outlined,
                //         color: APPSTYLE_BackgroundWhite,
                //       ),
                //       addHorizontalSpace(APPSTYLE_SpaceMedium),
                //       Expanded(
                //           child: Text("pending".tr,
                //               style: getHeadlineMediumStyle(context).copyWith(
                //                   color: APPSTYLE_BackgroundWhite))),
                //       Text(
                //         sharedController.userData.value.pendingOrders.toString(),
                //         style: getHeadlineLargeStyle(context)
                //             .copyWith(color: APPSTYLE_BackgroundWhite),
                //       )
                //     ],
                //   ),
                // ),
                // addVerticalSpace(APPSTYLE_SpaceMedium),
                // Container(
                //   decoration:
                //   APPSTYLE_ShadowedContainerExtraSmallDecoration.copyWith(
                //       boxShadow: [],
                //       color: APPSTYLE_GuideGreen),
                //   padding: APPSTYLE_MediumPaddingAll,
                //   margin: APPSTYLE_LargePaddingHorizontal,
                //   child: Row(
                //     children: [
                //       Icon(
                //         Icons.check_circle_outline,
                //         color: APPSTYLE_BackgroundWhite,
                //       ),
                //       addHorizontalSpace(APPSTYLE_SpaceMedium),
                //       Expanded(
                //           child: Text("completed".tr,
                //               style: getHeadlineMediumStyle(context).copyWith(
                //                   color: APPSTYLE_BackgroundWhite))),
                //       Text(
                //         sharedController.userData.value.deliveredOrders.toString(),
                //         style: getHeadlineLargeStyle(context)
                //             .copyWith(color: APPSTYLE_BackgroundWhite),
                //       )
                //     ],
                //   ),
                // ),

                Visibility(
                  visible: !sharedController.isUserDataFetching.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UpdateProfilePic(
                        isLarge:true,
                        borderColor: APPSTYLE_Black,
                        profilePictureUrl: sharedController.userData.value.image,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible:  sharedController.isUserDataFetching.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Shimmer.fromColors(
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
                      ),
                    ],
                  ),),

                Visibility(
                  visible: sharedController.isUserDataFetching.value,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                ),
                Visibility(
                  visible: sharedController.isUserDataFetching.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Shimmer.fromColors(
                        baseColor: APPSTYLE_Grey20,
                        highlightColor: APPSTYLE_Grey40,
                        child: Container(

                          width: screenwidth*.3,
                          height: 16,

                          decoration:
                          APPSTYLE_BorderedContainerExtraSmallDecoration
                              .copyWith(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: APPSTYLE_BackgroundWhite, width: 1),
                              color: APPSTYLE_Grey20
                          ),),
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceSmall),
                Visibility(
                  visible: !sharedController.isUserDataFetching.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sharedController.userData.value.name,
                        textAlign: TextAlign.start,
                        style: getHeadlineLargeStyle(context).copyWith(
                            fontWeight: APPSTYLE_FontWeightBold),
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: !sharedController.isUserDataFetching.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          sharedController.userData.value.code,
                          textAlign: TextAlign.start,
                          style: getBodyMediumStyle(context).copyWith(
                          ),
                        )
                      ],
                    )
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge*4),
                Padding(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  child: Text("find_orders_assigned".tr,
                      textAlign: TextAlign.center,
                      style: getHeadlineMediumStyle(context).copyWith(
                          fontWeight: APPSTYLE_FontWeightBold,
                          color: APPSTYLE_Grey80)),
                ),


                addVerticalSpace(APPSTYLE_SpaceMedium),

                InkWell(
                  onTap: (){
                    _selectDate(context);
                  },
                  child: Container(
                    margin: APPSTYLE_LargePaddingHorizontal,
                    decoration:
                    APPSTYLE_BorderedContainerExtraSmallDecoration,
                    padding: APPSTYLE_MediumPaddingAll,
                    child: Row(
                      children: [
                        Icon(Ionicons.calendar_outline),
                        addHorizontalSpace(APPSTYLE_SpaceSmall),
                        Expanded(
                          child: Text(
                            isSameDay(sharedController.selectedDate.value, DateTime.now().add(Duration(days: -1)))?
                            "select_date".tr:
                            getShortFormattedDate(sharedController.selectedDate.value),
                            style: getBodyMediumStyle(context),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),
                Container(
                  height: 90,
                  margin: APPSTYLE_LargePaddingHorizontal,
                  padding: const EdgeInsets.only(
                      left: APPSTYLE_SpaceMedium,
                      right: APPSTYLE_SpaceMedium,
                      top: APPSTYLE_SpaceMedium),
                  decoration:
                  APPSTYLE_BorderedContainerDarkSmallDecoration
                      .copyWith(
                      borderRadius: BorderRadius.circular(APPSTYLE_BorderRadiusExtraSmall),
                      color: APPSTYLE_BackgroundWhite,
                      border: Border.all(
                          color: APPSTYLE_Grey40,
                          width: .2)),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(
                            'select_shift'.tr,
                            style: TextStyle(height: .5),
                          ),

                        ],
                      ),
                      DropDownSelector(
                        titleText: 'area'.tr,
                        selected: sharedController.selectedShift.value.id,
                        items: sharedController.userData.value.shifts,
                        hintText: 'select_shift'.tr,
                        valueChanged: (newShift) {
                          sharedController.changeShif(int.parse(newShift),false);
                        },
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(APPSTYLE_SpaceMedium),
                Padding(padding: APPSTYLE_LargePaddingHorizontal,
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          child:sharedController.isOrderStatusUpdating.value
                              ? LoadingAnimationWidget.staggeredDotsWave(
                            color: APPSTYLE_BackgroundWhite,
                            size: 24,
                          ):  Text('find_orders'.tr,
                              style: getHeadlineMediumStyle(context).copyWith(
                                  color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                              textAlign: TextAlign.center),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (sharedController.selectedShift.value.id !=-1 &&
                                !isSameDay(sharedController.selectedDate.value, DateTime.now().add(Duration(days: -1))) &&

                                !sharedController.isOrderStatusUpdating.value) {
                              sharedController.getOrders(true);
                            }else{
                              if(isSameDay(sharedController.selectedDate.value, DateTime.now().add(Duration(days: -1)))){
                                showSnackbar(context, "select_date".tr, "error");
                              }else if(sharedController.selectedShift.value.id ==-1){
                                showSnackbar(context, "select_shift".tr, "error");
                              }
                            }
                          })),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getGreetingText() {
    DateTime currentDate = DateTime.now();

    if (currentDate.hour < 12) {
      return "good_morning";
    } else if (currentDate.hour < 16) {
      return "good_afternoon";
    } else {
      return "good_evening";
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:isSameDay(sharedController.selectedDate.value, DateTime.now().add(Duration(days: -1)))?
      sharedController.selectedDate.value.add(Duration(days: 1)):
      sharedController.selectedDate.value,
      initialEntryMode: DatePickerEntryMode.calendarOnly, // <- this
      firstDate:DateTime(2024),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary:
              APPSTYLE_PrimaryColor, // Customize the color of the selected date
            ),
          ),
          child: child!,
        );
      },);
    if (picked != null && picked != sharedController.selectedDate.value  ) {
      sharedController.changeDate(picked,false);
    }
  }

}

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
import 'package:doneapp_driver/shared_module/ui/components/custom_back_button.component.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/dropdown_selector.component.shared.dart';
import 'package:doneapp_driver/shared_module/ui/components/update_profile_pic.profile.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class OrderDetailsPage_Core extends StatefulWidget {

  OrderDetailsPage_Core({super.key});

  @override
  State<OrderDetailsPage_Core> createState() => _OrderDetailsPage_CoreState();
}

class _OrderDetailsPage_CoreState extends State<OrderDetailsPage_Core> {
  final sharedController = Get.find<SharedController>();
  var getArguments = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(getArguments == null){
      showSnackbar(context, "cant_find_order".tr, "error");
      Get.back();
    }
    if(getArguments[0] == null){
      showSnackbar(context, "cant_find_order".tr, "error");
      Get.back();
    }
    if(sharedController.myOrders.length<(getArguments[0]+1)){
      showSnackbar(context, "cant_find_order".tr, "error");
      Get.back();
    }
    sharedController.changeOrder(getArguments[0]);
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        title: Row(
          children: [
            CustomBackButton(isPrimaryMode: false),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'order_details'.tr,
                  style: getHeadlineLargeStyle(context)
                      .copyWith(fontWeight: APPSTYLE_FontWeightBold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        actions: [
          Container(
            width: screenwidth * .25,
            decoration:
            APPSTYLE_ShadowedContainerExtraSmallDecoration.copyWith(
                boxShadow: [
                  const BoxShadow(
                    color: APPSTYLE_Grey80Shadow24,
                    offset: Offset(0, 3.0),
                    blurRadius: APPSTYLE_BlurRadiusLarge,
                  ),
                ],
                color: sharedController.selectedOrder.value.status == 'pending'?
                APPSTYLE_GuideRed:
                sharedController.selectedOrder.value.status == 'delivered'?
                APPSTYLE_WhatsappGreen:APPSTYLE_PrimaryColorBg),
            padding: EdgeInsets.symmetric(
                vertical: APPSTYLE_SpaceSmall,
                horizontal: APPSTYLE_SpaceSmall),
            child: Row(
              children: [
                Icon(sharedController.selectedOrder.value.status == 'pending'?
                Icons.timer_outlined :
                sharedController.selectedOrder.value.status == 'delivered'?
                Icons.check_circle_outline :Icons.close,color: APPSTYLE_BackgroundWhite,
                  size: APPSTYLE_FontSize16),
                addHorizontalSpace(APPSTYLE_SpaceSmall),

                addHorizontalSpace(APPSTYLE_SpaceExtraSmall),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(sharedController.selectedOrder.value.status == 'pending'?
                    "pending".tr:
                    sharedController.selectedOrder.value.status == 'delivered'?
                    'delivered'.tr :'not_delivered'.tr,
                        style: getBodyMediumStyle(context).copyWith(
                            color: APPSTYLE_BackgroundWhite),
                        textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          ),
          addHorizontalSpace(APPSTYLE_SpaceLarge),

        ],
      ),
      body: Obx(
        ()=> Container(
          width: screenwidth,
          height: screenheight,
          child: SafeArea(
            child: ListView(
              children: [
                addVerticalSpace(APPSTYLE_SpaceMedium ),
                Container(
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
                            onClick: () {
                            },
                            borderColor: APPSTYLE_Black,
                            profilePictureUrl: sharedController.selectedOrder.value.image,
                          ),
                          addHorizontalSpace(APPSTYLE_SpaceSmall),

                          Expanded(child: Text(
                            Localizations.localeOf(context)
                                .languageCode
                                .toString() ==
                                'ar'?sharedController.selectedOrder.value.arabicName:
                            sharedController.selectedOrder.value.name,style: getHeadlineMediumStyle(context).copyWith(
                              fontWeight: APPSTYLE_FontWeightBold
                          ),)),

                        ],
                      ),
                      Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(ASSETS_LOCATION,
                              width: 30),
                          addHorizontalSpace(APPSTYLE_SpaceSmall),
                          Expanded(child: Text(
                              "${ sharedController.selectedOrder.value.area}, "
                                  " ${sharedController.selectedOrder.value.street} ${'street'.tr}, "
                                  "${sharedController.selectedOrder.value.jedha.trim()!='' ?('${sharedController.selectedOrder.value.jedha} '):''}${sharedController.selectedOrder.value.jedha.trim()!=''?('${'jedha'.tr},'):''}"
                                  "${sharedController.selectedOrder.value.houseNumber !=-1?'house_number'.tr:''} : ${sharedController.selectedOrder.value.houseNumber!=-1 ?sharedController.selectedOrder.value.houseNumber:''}"
                                  "${sharedController.selectedOrder.value.floorNumber !=-1?(', ${'floor_number'.tr} : '):''} ${sharedController.selectedOrder.value.floorNumber!=-1 ?sharedController.selectedOrder.value.floorNumber:''}" ,
                              style: getHeadlineMediumStyle(context)))

                        ],
                      ),
                    ],
                  ),

                ),
                 Visibility(
                  visible: sharedController.selectedOrder.value.mobile !="",
                  child: Padding(
                    padding: APPSTYLE_LargePaddingHorizontal.copyWith(top: APPSTYLE_SpaceSmall),
                    child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(

                            child:  Row(
                              children: [
                                Icon(Ionicons.call,color: APPSTYLE_PrimaryColor,),
                                addHorizontalSpace(APPSTYLE_SpaceMedium),
                                Text('contact_customer'.tr,
                                    style: getHeadlineMediumStyle(context).copyWith(
                                        color: APPSTYLE_PrimaryColor,fontWeight: APPSTYLE_FontWeightBold),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                            onPressed: () {
                              handleCustomerContactClick(context,sharedController.selectedOrder.value.mobile);
                            })),),
                ),
                addVerticalSpace(APPSTYLE_SpaceLarge*2),

                Visibility(
                  visible:sharedController.selectedOrder.value.status == "pending",
                  child: Padding(
                    padding: APPSTYLE_LargePaddingHorizontal,
                    child: TextFormField(
                      controller:  sharedController.commentsTextEditingController.value,
                      minLines: 4,
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'comments'.tr ,
                            hintText: 'add_comments'.tr
                        )),
                  ),
                ),
                Visibility(
                    visible:sharedController.selectedOrder.value.status == "pending",
                    child: addVerticalSpace(APPSTYLE_SpaceLarge)),
                Visibility(
                  visible:sharedController.selectedOrder.value.status == "pending",
                  child: Padding(padding: APPSTYLE_LargePaddingHorizontal,
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(APPSTYLE_GuideGreen)
                        ),
                          child:sharedController.isOrderStatusUpdating.value && sharedController.orderStatus=='delivered'
                              ? LoadingAnimationWidget.staggeredDotsWave(
                            color: APPSTYLE_BackgroundWhite,
                            size: 24,
                          ):  Text('mark_as_delivered'.tr,
                              style: getHeadlineMediumStyle(context).copyWith(
                                  color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                              textAlign: TextAlign.center),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (
                                !sharedController.isOrderStatusUpdating.value) {
                              sharedController.changeOrderStatus(
                                  sharedController.selectedOrder.value.id,
                                  true,
                                  sharedController.commentsTextEditingController.value.text);
                            }
                          })),),
                ),
                Visibility(
                    visible:sharedController.selectedOrder.value.status == "pending",

                    child: addVerticalSpace(APPSTYLE_SpaceSmall)),
                Visibility(
                  visible:sharedController.selectedOrder.value.status == "pending",
                  child: Padding(padding: APPSTYLE_LargePaddingHorizontal,
                    child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            child:sharedController.isOrderStatusUpdating.value && sharedController.orderStatus=='not_delivered'
                                ? LoadingAnimationWidget.staggeredDotsWave(
                              color: APPSTYLE_BackgroundWhite,
                              size: 24,
                            ):  Text('mark_as_not_delivered'.tr,
                                style: getHeadlineMediumStyle(context).copyWith(
                                    color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                                textAlign: TextAlign.center),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (!sharedController.isOrderStatusUpdating.value) {
                                sharedController.changeOrderStatus(
                                    sharedController.selectedOrder.value.id, false,
                                    sharedController.commentsTextEditingController.value.text);
                              }
                            })),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> handleCustomerContactClick(
      BuildContext buildContext,String mobile ) async {
    final Uri callUrl =
    Uri(scheme: 'tel', path: mobile);
    var canLaunch = false;
    canLaunch = await UrlLauncher.canLaunchUrl(callUrl);

    if (canLaunch) {
      UrlLauncher.launchUrl(callUrl);
    } else {
      showSnackbar(buildContext, "not_able_to_connect".tr, "error");
    }
  }

}

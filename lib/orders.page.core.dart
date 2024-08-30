import 'dart:ui';

import 'package:doneapp_driver/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/valid_order_status.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp_driver/shared_module/controllers/controller.shared.dart';
import 'package:doneapp_driver/shared_module/models/general_item.model.shared.dart';
import 'package:doneapp_driver/shared_module/models/my_order.model.shared.dart';
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

class OrdersPage_Core extends StatelessWidget {
  bool isBackbuttonVisible;
  OrdersPage_Core({super.key, required this.isBackbuttonVisible});

  final sharedController = Get.find<SharedController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
          ()=> Scaffold(
        // floatingActionButton: !sharedController.selectedDate.value.isBefore(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day))
        //     && sharedController.selectedShift.value.id != -1
        //     ? FloatingActionButton.extended(
        //   onPressed: (){
        //     sharedController.getAllMyOrders();
        //   },
        //   label: Text("View All",style: getBodyMediumStyle(context).copyWith(color: APPSTYLE_BackgroundWhite)),
        // ):Container(),
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
                    'assigned_orders'.tr,
                    style: getHeadlineLargeStyle(context)
                        .copyWith(fontWeight: APPSTYLE_FontWeightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
        body:  Container(
          width: screenwidth,
          height: screenheight,
          child: SafeArea(
            child: Column(
              children: [
                addVerticalSpace(APPSTYLE_SpaceSmall ),
                Container(
                  padding: APPSTYLE_LargePaddingHorizontal,
                  margin: EdgeInsets.only(bottom: APPSTYLE_SpaceMedium),
                  child: Row(
                    children: [
                      Expanded(
                          flex:2,
                          child: InkWell(
                            onTap: (){
                              _selectDate(context);
                            },
                            child: Container(
                              decoration:
                              APPSTYLE_BorderedContainerExtraSmallDecoration,
                              padding: APPSTYLE_SmallPaddingAll,
                              child: Row(
                                children: [
                                  Icon(Ionicons.calendar_outline),
                                  addHorizontalSpace(APPSTYLE_SpaceSmall),
                                  Expanded(
                                    child: Text(
                                      sharedController.selectedDate.value.isBefore(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day))?
                                      "select_date".tr:
                                      getShortFormattedDate(sharedController.selectedDate.value),
                                      style: getBodyMediumStyle(context),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      addHorizontalSpace(APPSTYLE_SpaceMedium),
                      Expanded(
                        flex: 1,
                        child: DropDownSelector(
                          titleText: 'shift'.tr,
                          selected: sharedController.selectedShift.value.id,
                          items: sharedController.userData.value.shifts,
                          hintText: 'select_shift'.tr,
                          valueChanged: (newShift) {
                            sharedController.changeShif(int.parse(newShift),true);
                          },
                        ),
                      ),
                    ],
                  ),
                ),


                Visibility(
                    visible:  !sharedController.isOrdersFetching.value && sharedController.myOrders.isNotEmpty,
                    child: Container(
                      width: screenwidth,
                      height: 50,
                      padding: APPSTYLE_LargePaddingHorizontal.copyWith(bottom: APPSTYLE_SpaceSmall),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for(var status in VALIDORDER_STATUS.values)
                            Padding(
                              padding: const EdgeInsets.only(right:APPSTYLE_SpaceSmall),
                              child: InkWell(
                                onTap: (){
                                  sharedController.changeOrderStatusFilter(status.name);
                                },
                                child: Container(
                                  decoration:
                                  APPSTYLE_ShadowedContainerExtraSmallDecoration.copyWith(
                                      border:  Border.all(color:
                                      sharedController.selectedStatus.value!=status.name?APPSTYLE_Black:
                                      status.name == 'all'?
                                      APPSTYLE_Black: status.name == 'pending'?
                                      APPSTYLE_GuideRed:
                                      status.name == 'delivered'?
                                      APPSTYLE_WhatsappGreen:APPSTYLE_PrimaryColorBg, width: 1),
                                      boxShadow: [ ],
                                      color: sharedController.selectedStatus.value!=status.name?
                                      Colors.transparent: status.name == 'pending'?
                                      APPSTYLE_GuideRed:
                                      status.name == 'delivered'?
                                      APPSTYLE_WhatsappGreen:APPSTYLE_PrimaryColorBg),
                                  padding: EdgeInsets.symmetric(
                                      vertical: APPSTYLE_SpaceSmall,
                                      horizontal: APPSTYLE_SpaceSmall),
                                  child: Row(
                                    children: [
                                      Text(status.name.tr ,
                                          style: getBodyMediumStyle(context).copyWith(
                                              color:  sharedController.selectedStatus.value!=status.name?APPSTYLE_Black:APPSTYLE_BackgroundWhite),
                                          textAlign: TextAlign.center),
                                      addHorizontalSpace(APPSTYLE_SpaceSmall),
                                      Container(
                                        decoration: APPSTYLE_BorderedContainerExtraSmallDecoration.
                                        copyWith(color: sharedController.selectedStatus.value==status.name?
                                        APPSTYLE_BackgroundWhite: status.name == 'pending'?
                                        APPSTYLE_GuideRed:
                                        status.name == 'delivered'?
                                        APPSTYLE_WhatsappGreen:APPSTYLE_PrimaryColorBg),
                                        width: 40,
                                        height: 25,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text((
                                              status.name=="pending"?sharedController.pendingCount.toString():
                                              status.name=="delivered"?sharedController.deliveredCount.toString():
                                              sharedController.notDeliveredCount.toString()
                                          ),style: TextStyle(color: sharedController.selectedStatus.value==status.name?APPSTYLE_Black:APPSTYLE_BackgroundWhite),),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )),
                Visibility(
                  visible:  !sharedController.isOrdersFetching.value && sharedController.myOrdersToShow.isNotEmpty,
                  child: Expanded(
                      child: Container(
                        child: ListView(
                          children: [
                            addVerticalSpace(APPSTYLE_SpaceSmall),
                            for(var i=0;i<sharedController.myOrdersToShow.length;i++ )
                              InkWell(
                                onTap:(){
                                  if(sharedController.selectedOrder.value.id != sharedController.myOrdersToShow[i].id){
                                    sharedController.changeOrder(i);
                                  }else{
                                    sharedController.changeOrder(-1);
                                  }

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
                                            profilePictureUrl: sharedController.myOrdersToShow[i].image,
                                          ),
                                          addHorizontalSpace(APPSTYLE_SpaceSmall),

                                          Expanded(child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Localizations.localeOf(context)
                                                    .languageCode
                                                    .toString() ==
                                                    'ar'?sharedController.myOrdersToShow[i].arabicName:
                                                sharedController.myOrdersToShow[i].name,style: getHeadlineMediumStyle(context).copyWith(
                                                  fontWeight: APPSTYLE_FontWeightBold
                                              ),),
                                              Text(
                                                "#${sharedController.myOrdersToShow[i].customerId}",
                                                style: getBodyMediumStyle(context).copyWith(
                                                ),),
                                            ],
                                          )),
                                          addHorizontalSpace(APPSTYLE_SpaceSmall),

                                          Text('Q#${sharedController.myOrdersToShow[i].queue}',style: getHeadlineLargeStyle(context),)

                                        ],
                                      ),
                                      Divider(),
                                      Visibility(
                                        visible:sharedController.selectedOrder.value.id != sharedController.myOrdersToShow[i].id  ,

                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(ASSETS_LOCATION,
                                                width: 30),
                                            addHorizontalSpace(APPSTYLE_SpaceSmall),
                                            Expanded(child:
                                            Text(getAddressString(Localizations.localeOf(context)
                                                .languageCode
                                                .toString(),sharedController.myOrdersToShow[i]),

                                                style: getHeadlineMediumStyle(context)))

                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible:sharedController.selectedOrder.value.id == sharedController.myOrdersToShow[i].id  ,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(ASSETS_LOCATION,
                                                width: 30),
                                            addHorizontalSpace(APPSTYLE_SpaceSmall),
                                            Expanded(child:
                                            Text(getAddressStringFull(Localizations.localeOf(context)
                                                .languageCode
                                                .toString(),sharedController.myOrdersToShow[i]),

                                                style: getHeadlineMediumStyle(context)))

                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                              onTap: (){
                                                handleCustomerContactClick(context,sharedController.myOrdersToShow[i].mobile);
                                              },child: Icon(Ionicons.call,color: APPSTYLE_PrimaryColor,)),
                                          addHorizontalSpace(APPSTYLE_SpaceSmall),
                                          Expanded(child:
                                          InkWell(
                                            onTap: (){
                                              handleCustomerContactClick(context,sharedController.myOrdersToShow[i].mobile);
                                            },
                                            child: Text(sharedController.myOrdersToShow[i].mobile,
                                                style: getHeadlineMediumStyle(context)),
                                          ))

                                        ],
                                      ),
                                      Visibility(
                                        visible:sharedController.selectedOrder.value.id == sharedController.myOrdersToShow[i].id  ,
                                        child: Padding(
                                          padding: APPSTYLE_SmallPaddingVertical,
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
                                      SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            children: [

                                              Visibility(
                                                visible:sharedController.myOrdersToShow[i].status == "pending",
                                                child: Expanded(
                                                  child: SizedBox(
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                          style: ButtonStyle(
                                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                                  EdgeInsets.symmetric(
                                                                      horizontal: APPSTYLE_SpaceSmall,
                                                                      vertical:APPSTYLE_SpaceExtraSmall)),
                                                              backgroundColor: MaterialStateProperty.all<Color>(APPSTYLE_GuideGreen)
                                                          ),
                                                          child:sharedController.isOrderStatusUpdating.value && sharedController.orderStatus=='delivered'
                                                              ? LoadingAnimationWidget.staggeredDotsWave(
                                                            color: APPSTYLE_BackgroundWhite,
                                                            size: 24,
                                                          ): FittedBox(
                                                            fit: BoxFit.scaleDown,
                                                            child: Text('mark_as_delivered'.tr,
                                                                style: getHeadlineMediumStyle(context).copyWith(
                                                                    color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                                                                textAlign: TextAlign.center),
                                                          ),
                                                          onPressed: () {
                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                            if (
                                                            !sharedController.isOrderStatusUpdating.value) {
                                                              showConfirmDialogue(context,
                                                                  sharedController.myOrdersToShow[i].id, true,
                                                                  sharedController.commentsTextEditingController.value.text);

                                                            }
                                                          })),
                                                ),
                                              ),
                                              addHorizontalSpace(APPSTYLE_SpaceSmall),
                                              Visibility(
                                                visible:sharedController.myOrdersToShow[i].status == "pending",
                                                child: Expanded(
                                                  child: SizedBox(
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                          style: ButtonStyle(
                                                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                                  EdgeInsets.symmetric(
                                                                      horizontal: APPSTYLE_SpaceSmall,
                                                                      vertical:APPSTYLE_SpaceExtraSmall)),
                                                              backgroundColor: MaterialStateProperty.all<Color>(APPSTYLE_GuideRed)
                                                          ),
                                                          child:sharedController.isOrderStatusUpdating.value && sharedController.orderStatus=='not_delivered'
                                                              ? LoadingAnimationWidget.staggeredDotsWave(
                                                            color: APPSTYLE_BackgroundWhite,
                                                            size: 24,
                                                          ):  FittedBox(
                                                            fit: BoxFit.scaleDown,
                                                            child: Text('mark_as_not_delivered'.tr,
                                                                style: getHeadlineMediumStyle(context).copyWith(
                                                                    color: APPSTYLE_BackgroundWhite,fontWeight: APPSTYLE_FontWeightBold),
                                                                textAlign: TextAlign.center),
                                                          ),
                                                          onPressed: () {
                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                            if (!sharedController.isOrderStatusUpdating.value) {
                                                              showConfirmDialogue(context,
                                                                  sharedController.myOrdersToShow[i].id, false,
                                                                  sharedController.commentsTextEditingController.value.text);
                                                            }
                                                          })),
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),

                                ),
                              ),
                          ],
                        ),
                      )),
                ),

                Visibility(
                  visible:  !sharedController.isOrdersFetching.value && sharedController.myOrdersToShow.isEmpty,
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
                  visible: sharedController.isOrdersFetching.value,
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



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: sharedController.selectedDate.value,
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
    if (picked != null && picked != sharedController.selectedDate.value) {
      sharedController.changeDate(picked,true);
    }
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

  String getAddressStringFull(String lan, MyOrder myOrder) {

    String addressString = "";


    if(myOrder.area !=""){
      addressString +='${'area'.tr} : ${lan ==
          'ar'?myOrder.blockArabic: myOrder.area} \n';
    }
    if(myOrder.block !=""){
      addressString +='${'block'.tr} : ${lan ==
          'ar'?myOrder.blockArabic: myOrder.block} \n';
    }
    if(myOrder.street.trim() !=""){
      addressString += "${'street'.tr} : ${myOrder.street} \n";
    }

    if(myOrder.jedha.trim() !=""){
      addressString += "${'jedha'.tr} : ${myOrder.jedha} \n";
    }
    if(myOrder.houseNumber.trim() !=""){
      addressString += "${'house_number'.tr} : ${myOrder.houseNumber} \n";
    }
    if(myOrder.floorNumber.trim() !=""){
      addressString += "${'floor_number'.tr} : ${myOrder.floorNumber} \n";
    }
    return addressString;
  }

  String getAddressString(String lan,MyOrder myOrder) {

    String addressString = "";

    if(myOrder.area !=""){
      addressString += (lan ==
          'ar'?myOrder.areaArabic: myOrder.area);
    }
    if(myOrder.block !=""){
      addressString +=', ${'block'.tr} : ${lan ==
          'ar'?myOrder.blockArabic: myOrder.block}';
    }
    if(myOrder.street.trim() !=""){
      addressString += ", ${'street'.tr} : ${myOrder.street}";
    }

    if(myOrder.jedha.trim() !=""){
      addressString += ", ${'jedha'.tr} : ${myOrder.jedha}";
    }
    if(myOrder.houseNumber.trim() !=""){
      addressString += ", ${'house_number'.tr} : ${myOrder.houseNumber}";
    }
    if(myOrder.floorNumber.trim() !=""){
      addressString += ", ${'floor_number'.tr} : ${myOrder.floorNumber}";
    }
    return addressString;
  }

  void showConfirmDialogue(BuildContext context ,int orderId, bool isDelivered, String comments) async {

    final dialogTitleWidget = Text('confirm'.tr,style: getHeadlineMediumStyle(context).copyWith(
        color: APPSTYLE_Grey80,fontWeight: APPSTYLE_FontWeightBold));
    final dialogTextWidget = Text(  'confirm_message'.tr,style: getBodyMediumStyle(context),
    );

    final updateButtonTextWidget = Text('yes'.tr,style: TextStyle(color: APPSTYLE_PrimaryColor),);
    final updateButtonCancelTextWidget = Text('no'.tr,style: TextStyle(color: APPSTYLE_Black),);

    updateLogoutAction() async {
      sharedController.changeOrderStatus(orderId, isDelivered,comments);
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

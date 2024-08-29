import 'package:doneapp_driver/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/default_values.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/valid_order_status.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/valid_phoneverification_modes.constants.shared.dart';
import 'package:doneapp_driver/shared_module/models/general_item.model.shared.dart';
import 'package:doneapp_driver/shared_module/models/my_order.model.shared.dart';
import 'package:doneapp_driver/shared_module/models/notification.model.shared.dart';
import 'package:doneapp_driver/shared_module/models/sendotp_credential.model.auth.dart';
import 'package:doneapp_driver/shared_module/models/user_data.model.shared.dart';
import 'package:doneapp_driver/shared_module/services/http-services/http.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/app_update_checker.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/local_storage.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedController extends GetxController {
  var selectedLanguage = "".obs;
  var mobile = "".obs;
  var isUserDataFetching = false.obs;
  var isNotificationsFetching = false.obs;
  var isOrdersAllFetching = false.obs;
  var isOrdersCustomFetching = false.obs;
  var isDeviceTokenUpdating = false.obs;
  var selectedDate = DateTime.now().obs;
  var selectedShift = mapGeneralItem({}).obs;
  var userData = mapUserData({}).obs;
  var selectedOrder = mapMyOrder({}).obs;
  var notifications = <AppNotification>[].obs;
  var myOrdersCustom = <MyOrder>[].obs;
  var myOrdersAll = <MyOrder>[].obs;
  var supportNumber = "".obs;
  var selectedStatus = "all".obs;

  //  Mobile Verification
  var isOtpVerifying = false.obs;
  var isPlanActivating = false.obs;
  var isOtpSending = false.obs;
  var isOrderStatusUpdating = false.obs;
  var orderStatus = "".obs;
  var isAppointmentBooking = false.obs;

  Rx<TextEditingController> mobileTextEditingController = TextEditingController().obs;
  Rx<TextEditingController> commentsTextEditingController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> setInitialScreen() async {
    var sharedHttpService = SharedHttpService();
    await sharedHttpService.getAccessToken();
    getSupportNumber();
    selectedLanguage.value = "";
    mobile.value = "";
    AppUpdateChecker appUpdateChecker = AppUpdateChecker();

    bool isUpdateAvailable = await appUpdateChecker.checkStatus();

    if (!isUpdateAvailable) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? tSelectedLanguage = prefs.getString('selectedLanguage');
      final String? tMobile = prefs.getString('mobile');

      if (tSelectedLanguage != null && tSelectedLanguage != '') {
        changeLanguage(tSelectedLanguage, false);
        selectedLanguage.value = tSelectedLanguage;
      }

      if (tMobile != null && tMobile != '') {
        mobile.value = tMobile;
      }

      if (mobile.value.isNotEmpty) {
        isUserDataFetching.value = true;
        userData.value = await sharedHttpService.getProfileData(mobile.value);
        if (userData.value.shifts.isNotEmpty){
          selectedShift.value = userData.value.shifts[0];
        }

        isUserDataFetching.value = false;

        // Decide route based on user data id and subscription status.
        if ( userData.value.code != "") {
          saveDeviceToken();
          Get.offAllNamed(AppRouteNames.homeRoute);
        } else {
          var sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("mobile", "");
          Get.toNamed(AppRouteNames.loginRoute);
        }
      } else {
        Get.toNamed(AppRouteNames.loginRoute);
      }
    }
  }

  Future<void> refetchUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tMobile = prefs.getString('mobile');

    if (tMobile != null && tMobile != '') {
      mobile.value = tMobile;

      try{
        var sharedHttpService = SharedHttpService();
        isUserDataFetching.value = true;
        mobile.value = tMobile;

        userData.value = await sharedHttpService.getProfileData(tMobile);
        if (userData.value.shifts.isNotEmpty){
          selectedShift.value = userData.value.shifts[0];
        }
        isUserDataFetching.value = false;


      }catch(e,st){
         print(e);
        print(st);
        isUserDataFetching.value = false ;
      }

    }
  }
  changeMobile(String mobile){
    mobileTextEditingController.value.text = mobile;
  }
  updateUserData(UserData tUserData) {
    userData.value = tUserData;
    if (userData.value.shifts.isNotEmpty){
      selectedShift.value = userData.value.shifts[0];
    }
  }

  changeOrder(MyOrder myOrder){
    selectedOrder.value = myOrder;
  }

  saveDeviceToken() async {
    var sharedHttpService = SharedHttpService();
    String deviceToken = await getFirebaseMessagingToken();
    bool isSuccess = await sharedHttpService.saveDeviceToken(
        mobile.value, deviceToken);
  }

  fetchUserData(String targetRoute, String tMobile) async {
    try{
      var sharedHttpService = SharedHttpService();
      isUserDataFetching.value = true;
      mobile.value = tMobile;

      userData.value = await sharedHttpService.getProfileData(tMobile);
      if (userData.value.shifts.isNotEmpty){
        selectedShift.value = userData.value.shifts[0];
      }
      isUserDataFetching.value = false;

      userData.value.shifts.forEach((element) {
        print("userData");
        print(element.id);
        print(element.arabicName);
        print(element.name);
      });
      if ( userData.value.code != "") {
        saveDeviceToken();
        if (targetRoute != "") {
          Get.offAllNamed(targetRoute);
        }
      } else {
        if (targetRoute != "") {
          showSnackbar(Get.context!, "something_wrong".tr, "error");
        }
      }
    }catch(e,st){
       print(e);
      print(st);
      Future.delayed(const Duration(milliseconds: 10));
      refetchUserData();
    }

  }

  Future<void> handleLogout() async {
    saveAuthTokenAndMobileToSharedPreference("","");
    userData.value = mapUserData({});
    notifications.value = [];
    Get.offAllNamed(AppRouteNames.loginRoute);
  }

  Future<void> setDeviceToken() async {
    isDeviceTokenUpdating.value = true;
    await Future<void>.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    String firebaseToken = await getFirebaseMessagingToken();
  }

  Future<String> getFirebaseMessagingToken() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      String firebaseMessagingToken =
          await FirebaseMessaging.instance.getToken() ?? "";

      return firebaseMessagingToken;
    } catch (e) {
      return e.toString();
    }
  }

  changeLanguage(String language, bool isNavigation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('selectedLanguage', language);

    selectedLanguage.value = language;
    Get.updateLocale(Locale(selectedLanguage.value));
    if (isNavigation) {
      Get.toNamed(AppRouteNames.loginRoute);
    }
  }

  Future<void> getOrders(bool isNavigationRequired) async {

    if(selectedDate.value.isBefore(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day))){
      selectedDate.value = DateTime.now();
    }

    if(selectedShift.value.id == -1){
      selectedShift.value = userData.value.shifts.isNotEmpty?userData.value.shifts[0]:mapGeneralItem(
          {});
    }

    if(selectedShift.value.id != -1){
      isOrdersCustomFetching.value = true;
      if(isNavigationRequired){
        Get.toNamed(AppRouteNames.ordersList);
      }
      var sharedHttpService = SharedHttpService();
      final f = new DateFormat('yyyy-MM-dd');
      myOrdersCustom.value =
      await sharedHttpService.getMyOrders( mobile.value,f.format(selectedDate.value),selectedShift.value.id.toString());
      selectedStatus.value = VALIDORDER_STATUS.all.name;
      if(selectedOrder.value.id != -1 &&
          myOrdersCustom.indexOf((element) => element.id==selectedOrder.value.id) != -1){
        changeOrder(selectedOrder.value);
      }

      orderStatus.value = "";

      isOrdersCustomFetching.value = false;
    }else{
      print("didnt calle");
    }

  }

  Future<void> getAllMyOrders() async {
    isOrdersAllFetching.value = true;
    var sharedHttpService = SharedHttpService();
    final f = new DateFormat('dd-MM-yyyy');
    myOrdersAll.value =  await sharedHttpService.getAllMyOrders( mobile.value);
    if(selectedOrder.value.id != -1 &&
        myOrdersAll.indexOf((element) => element.id==selectedOrder.value.id) != -1){
      changeOrder(selectedOrder.value);
    }
    selectedStatus.value = VALIDORDER_STATUS.all.name;

    orderStatus.value = "";
    isOrdersAllFetching.value = false;
  }

  Future<void> getNotifications() async {
    isNotificationsFetching.value = true;
    var sharedHttpService = SharedHttpService();
    notifications.value =
    await sharedHttpService.getNotifications( mobile.value);
    isNotificationsFetching.value = false;
  }

  sendOtp(bool isResetPassword, bool isNavigationRequired) async {

    if(mobileTextEditingController.value.text.toString().length<7){
      showSnackbar(Get.context!, "enter_valid_mobile".tr, "error");
    }else{

      isOtpSending.value = true;
      var sharedHttpService = new SharedHttpService();
      bool isSuccess = await sharedHttpService.sendOtp(
          SendOTPCredential(mobile: "+965${mobileTextEditingController.value.text}", isResetPassword: isResetPassword));
      isOtpSending.value = false;

      if(isSuccess){
        showSnackbar(Get.context!, "otp_sent".tr, "info");
        Get.toNamed(AppRouteNames.otpVerificationOtpInputRoute,
            arguments: [
              isResetPassword? VALIDPHONEVERIFICATION_MODES.reset_password:
              VALIDPHONEVERIFICATION_MODES.reset_password]);
      }
    }
  }

  verifyOtp (String otp, bool isResetPassword) async {
    if(otp.length!=6){
      showSnackbar(Get.context!, "enter_valid_otp".tr, "error");
    }else{

      isOtpVerifying.value = true;
      var sharedHttpService = new SharedHttpService();
      bool isVerificationSuccess = await sharedHttpService.verifyOtp( "+965${mobileTextEditingController.value.text}",otp);
      isOtpVerifying.value = false;

      if(isVerificationSuccess){
        showSnackbar(Get.context!, "otp_verified".tr, "info");
        if(isResetPassword){
          Get.offNamed(AppRouteNames.resetPasswordNewpasswordRoute,arguments: [mobileTextEditingController.value.text]);
        }else{
          Get.toNamed(AppRouteNames.otpVerificationSuccessRoute,arguments: [
            ASSETS_SUCCESSMARK,
            "otp_verified".tr,
            "otp_verified_message".tr,
            'continue'.tr,
            true,
            AppRouteNames.addressAuditRoute,
            mobileTextEditingController.value.text
          ]) ;
        }
      }
    }

  }

  getSupportNumber() async {
    var sharedHttpService = SharedHttpService();
    String tSupoortNumber = await sharedHttpService.getSupportNumber( );
    if(tSupoortNumber !=""){
      supportNumber.value = tSupoortNumber;
    }else{
      supportNumber.value = DefaultSupportNumber;
    }
  }

  void changeShif(int newShift, bool shouldFetchOrders) {
    List<GeneralItem> shifts = userData.value.shifts.where((element) => element.id==newShift).toList();
    if(shifts.length>0){
      selectedShift.value = shifts[0];
      if(shouldFetchOrders){
        getOrders(false);
      }
    }

  }

  void changeDate(DateTime picked, bool shouldFetchOrders) {
    selectedDate.value = picked;
    if(shouldFetchOrders){
      getOrders(false);
    }
  }

  changeOrderStatus(int orderId, bool isDelivered, String comments) async {

    if(!isOrderStatusUpdating.value){
      orderStatus.value = isDelivered?"delivered":"not_delivered";
      isOrderStatusUpdating.value = true;
      var sharedHttpService = new SharedHttpService();
      bool isSuccess = await sharedHttpService.updateOrderStatus(orderId,isDelivered,comments);
      isOrderStatusUpdating.value = false;
      orderStatus.value = "";
      if(isSuccess){
        Get.back();
        showSnackbar(Get.context!, "order_status_updated".tr, "info");
        if(selectedDate.value.isBefore(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)) ||
            selectedShift.value.id == -1){
          getAllMyOrders();
        }else{
          getOrders(false);
        }

      }
    }

  }


}

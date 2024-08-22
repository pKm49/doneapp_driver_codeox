
import 'package:doneapp_driver/feature_modules/auth/constants/http_request_endpoints.constant.auth.dart';
import 'package:doneapp_driver/feature_modules/auth/models/login_credential.model.auth.dart';
import 'package:doneapp_driver/shared_module/models/http_response.model.shared.dart';
import 'package:doneapp_driver/shared_module/services/http-services/http_request_handler.service.shared.dart';
import 'package:doneapp_driver/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
 import 'package:get/get.dart';
class AuthHttpService {


  Future<bool> login(LoginCredential loginCredentials) async {
   try{
     Map<String, dynamic> params = {};
     params["mobile"]=loginCredentials.mobile;
     params["password"]=loginCredentials.password;
     AppHttpResponse response = await getRequest(
         AuthHttpRequestEndpoint_Login,params);
     if(response.statusCode != 200){
       showSnackbar(Get.context!, response.message, "error");
     }
     return response.statusCode == 200;
   }catch  (e,st){
     print(e);
     print(st);
     showSnackbar(Get.context!, "something_wrong".tr, "error");
     return false;
   }
  }

  Future<bool> resetPassword(String mobile, String newPassword) async {

    try{
      AppHttpResponse response = await patchRequest(AuthHttpRequestEndpoint_ResetPassword, {
        "mobile": mobile,
        "new_password": newPassword
      });

      showSnackbar(Get.context!, response.message,response.statusCode != 200? "error":"info");

      return response.statusCode == 200;
    }catch  (e,st){
      print(e);
      print(st);
      showSnackbar(Get.context!, "something_wrong".tr, "error");
      return false;
    }
  }


}

import 'dart:convert';
import 'dart:io';
import 'package:doneapp_driver/shared_module/models/http_response.model.shared.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as httpForMultipart;
import 'package:http_interceptor/http_interceptor.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doneapp_driver/env.dart' as env;

import 'http_interceptor.service.shared.dart';

getRequest(endpoint, parameters) async {
  try {

    final http = InterceptedHttp.build(interceptors: [
      AppHttpInterceptor(),
    ]);

    final httpResponse = await http
        .get(Uri.https(env.apiEndPoint, "$endpoint"),params: json.decode(json.encode(parameters)));


    var httpResponseBody = json.decode(httpResponse.body);

    return generateSuccessResponse(httpResponseBody,httpResponse.statusCode);
  } on SocketException {
    return generateErrorResponse('Couldn\'t Connect, Try Again Later');
  } on FormatException catch (e,stack) {
    if (e.toString().contains("Request Not Implemented")) {
      return generateErrorResponse('Request Not Implemented');
    }
    if (e.toString().contains("Already authorised")) {
      return generateErrorResponse('Already authorised');
    }
    if (e.toString().contains("Request Not Authorised")) {
      return generateErrorResponse('Request Not Authorised');
    }
    // print("get FormatException exception");
    // print(e.toString());
    // print(stack.toString());
    return generateErrorResponse('Something went wrong, try again');
  } on Exception catch (e) {
    // print("get exception");
    // print(e.toString());
    return generateErrorResponse('Something went wrong, try again');
  }
}

postRequest(endpoint, body) async {

  try {
    final http = InterceptedHttp.build(interceptors: [
      AppHttpInterceptor(),
    ]);

    late var httpResponse;
    if(endpoint.toString().contains('update_customer_profile')){
      // print("update_customer_profile contains update_customer_profile");

      httpResponse = await http.post(
          Uri.https(env.apiEndPoint, "$endpoint"),
          params:endpoint.toString().contains('update_customer_profile')? json.decode(json.encode(body)) : null
      );
    }else{
      httpResponse = await http.post(
          Uri.https(env.apiEndPoint, "$endpoint"),
          body:endpoint.toString().contains('update_customer_profile')?null: json.encode(body)
      );
    }


    var httpResponseBody = json.decode(httpResponse.body);

    return generateSuccessResponse(httpResponseBody,httpResponse.statusCode);
  } on SocketException {
    // print("post SocketException exception");
    return generateErrorResponse('Couldn\'t Connect, Try Again Later');
  } on FormatException catch (e) {
    // print("post FormatException exception");
    // print(e.toString());
    if (e.toString().contains("Request Not Implemented")) {
      return generateErrorResponse('Request Not Implemented');
    }

    if (e.toString().contains("Already authorised")) {
      return generateErrorResponse('Already authorised');
    }

    if (e.toString().contains("Request Not Authorised")) {
      return generateErrorResponse('Request Not Authorised');
    }

    return generateErrorResponse('Something went wrong, try again');
  } on Exception catch (e) {

    // print("post exception");
    // print(e.toString());
    return generateErrorResponse('Something went wrong, try again');
  }

}

patchRequest(endpoint, body) async {

  try {
    final http = InterceptedHttp.build(interceptors: [
      AppHttpInterceptor(),
    ]);

    late var httpResponse;
    if(endpoint.toString().contains('update_customer_profile') || endpoint.toString().contains('delivered')){
      // print("update_customer_profile contains update_customer_profile");

      httpResponse = await http.patch(
          Uri.https(env.apiEndPoint, "$endpoint"),
          params:(
              endpoint.toString().contains('update_customer_profile') || endpoint.toString().contains('delivered')
          )? json.decode(json.encode(body)) : null
      );
    }else{
      httpResponse = await http.patch(
          Uri.https(env.apiEndPoint, "$endpoint"),
          body:endpoint.toString().contains('update_customer_profile')?null: json.encode(body)
      );
    }


    var httpResponseBody = json.decode(httpResponse.body);

    return generateSuccessResponse(httpResponseBody,httpResponse.statusCode);
  } on SocketException {
    // print("patch. SocketException exception");
    return generateErrorResponse('Couldn\'t Connect, Try Again Later');
  } on FormatException catch (e) {
    // print("patch. FormatException exception");
    // print(e.toString());
    if (e.toString().contains("Request Not Implemented")) {
      return generateErrorResponse('Request Not Implemented');
    }

    if (e.toString().contains("Already authorised")) {
      return generateErrorResponse('Already authorised');
    }

    if (e.toString().contains("Request Not Authorised")) {
      return generateErrorResponse('Request Not Authorised');
    }

    return generateErrorResponse('Something went wrong, try again');
  } on Exception catch (e) {

    // print("patch. exception");
    // print(e.toString());
    return generateErrorResponse('Something went wrong, try again');
  }

}

deleteRequest(endpoint,parameters) async {
  try {
    final http = InterceptedHttp.build(interceptors: [
      AppHttpInterceptor(),
    ]);

    final httpResponse =
    await http.delete(Uri.https(env.apiEndPoint, "$endpoint"),params: json.decode(json.encode(parameters)));

    var httpResponseBody = json.decode(httpResponse.body);


    return generateSuccessResponse(httpResponseBody,httpResponse.statusCode);
  } on SocketException {
    return generateErrorResponse('Couldn\'t Connect, Try Again Later');
  } on FormatException catch (e) {
    if (e.toString().contains("Request Not Implemented")) {
      return generateErrorResponse('Request Not Implemented');
    }
    if (e.toString().contains("Already authorised")) {
      return generateErrorResponse('Already authorised');
    }
    if (e.toString().contains("Request Not Authorised")) {
      return generateErrorResponse('Request Not Authorised');
    }
    return generateErrorResponse('Something went wrong, try again');
  } on Exception {
    return generateErrorResponse('Something went wrong, try again');
  }
}

generateErrorResponse(String errorMessage) {
  AppHttpResponse poundHttpResponse = AppHttpResponse(
      statusCode: 404,  message: errorMessage, data: null);

  return poundHttpResponse;
}

generateSuccessResponse(dynamic httpResponseBody, int requestStatusCode) {

  // print(httpResponseBody);
  var result = httpResponseBody['result'] != null ?httpResponseBody['result']:httpResponseBody  ;
  if(result is String && result.toString().contains('UNAUTHORIZED')){
    return generateErrorResponse('UnAuthorized');
  }
  if(result is String)
  {
    return generateErrorResponse('Something went wrong, try again');
  }
  else{
    num statusCode = (result  != null && result['statusCode']  != null)
        ? result['statusCode']
        :(result  != null && result['statusCode']  != null)
        ? result['statusCode']:result.toString().contains('Error')?500: requestStatusCode;
    String message = (result  != null && result['message']  != null)
        ? result['message']
        :(result  != null && result['error']  != null)
        ? result['error'] is String?result['error']:''
        : '';
    dynamic data = (result  != null && result['data']  != null)
        ? result['data']
        :(result  != null && result['payload']  != null)
        ? result['payload']
        : result;

    AppHttpResponse poundHttpResponse = AppHttpResponse(
        statusCode:(result  != null && result['statusCode']  != null)
            ? result['statusCode']
            :(result  != null && result['statusCode']  != null)
            ? result['statusCode']: result.toString().contains('Error')?500: statusCode,
        message: (result  != null && result['message']  != null && result['message']  != "")
            ? result['message']
            :(result  != null && result['error']  != null && result['error']  != "")
            ? result['error'] is String?result['error']:"something_wrong".tr
            : "something_wrong".tr ,
        data: (result  != null && result['data']  != null)
            ? result['data']
            :(result  != null && result['payload']  != null)
            ? result['payload']
            : result.toString().contains('Error')?null: null);
    return poundHttpResponse;
  }

}

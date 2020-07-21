import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

import 'package:path/path.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/ApiClass.dart';
import 'package:simposi/Utils/Utility/ModelClass.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';

class ApiProvider {
  factory ApiProvider() {
    return _singleton;
  }
  final Connectivity _connectivity = Connectivity();

  static final ApiProvider _singleton = ApiProvider._internal();

  ApiProvider._internal() {
    print("Instance created ApiProvider");
  }

  Future<HttpResponse> getRequest(String apiUrl,
      {Map<String, String> params}) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }

    final response = await Dio().get(apiUrl);

    print("Response Status code:: ${response.statusCode}");
    if (response.statusCode >= 200 && response.statusCode < 299) {
      dynamic jsonResponse = response.data;
      print("response body :: $jsonResponse");
      return HttpResponse(status: true, errMessage: "", json: response.data);
    } else {
      return HttpResponse(
          status: false, errMessage: "some thing wrong", json: null);
    }
  }

  Future<HttpResponse> getRequestWithHeader(
      ApiType url, Map<String, dynamic> params, String token) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }

    final requestFinal = ApiConstant.requestParamsForSyncWithHeader(url,
        params: params, token: token);

    // final requestFinal = ApiConstant.requestGetParamsForSyncWithHeader(url, params, token);//(url, params: params ,token: token);
    final option = Options(headers: requestFinal.header);

    print(requestFinal.url);
    print(option);
    // requestFinal.header =  <String, String>{'Authorization': 'Bearer '+ headertoken};//Headers('Authorization':'Bearer '+ headertoken);
    // final option = Options(headers: requestFinal.header);

    final response = await Dio().get(requestFinal.url, options: option);

    print("Response Status code:: ${response.statusCode}");
    if (response.statusCode >= 200 && response.statusCode < 299) {
      dynamic jsonResponse = response.data;
      print("response body :: $jsonResponse");

      return HttpResponse(status: true, errMessage: "", json: response.data);
    } else {
      return HttpResponse(
          status: false, errMessage: "something went wrong", json: null);
    }
  }
/*
  Future<HttpResponse> getRequest(String apiUrl,
      {Map<String, String> params}) async {

    final response = await Dio().get(apiUrl,);
    print("Response Status code:: ${response.statusCode}");
    if (response.statusCode >= 200 && response.statusCode < 299) {
      dynamic jsonResponse = response.data;
      print("response body :: $jsonResponse");

      return HttpResponse(status: true, errMessage: "", json: response.data);
    } else {
      return HttpResponse(
          status: false, errMessage: "something went wrong", json: null);
    }
  }
*/
  /// POST REQUEST API
  ///
  ///
  ///
  ///
  ///

  Future<HttpResponse> postRequestWithHeaderWithoutParam(
      ApiType url, String token) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }

    final requestFinal =
        ApiConstant.requestParamsForSyncWithHeaderWithoutParam(url, token);
    final option = Options(headers: requestFinal.header);
    print(requestFinal.params);
//
    try {
      final response = await Dio().post(requestFinal.url,
          data: json.encode(requestFinal.params), options: option);

      print("Response Status code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        // UserModel user = loginResponseFromJson(response.json);
        // final jsonData = json.decode(jsonResponse);

        final message = jsonResponse[ResonseKeys.kMessage] ?? '';
        final status = jsonResponse[ResonseKeys.kStatus] ?? false;
        final data = jsonResponse[ResonseKeys.kData];
        return HttpResponse(
            status: status == 200 ? true : false,
            errMessage: message,
            json: response.data);
      } else {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        var errMessage =
            jsonResponse[ResonseKeys.kMessage] ?? "Something went Wrong.";
        return HttpResponse(
            status: false, errMessage: errMessage, json: response.toString());
      }
    } on DioError catch (error) {
      print('Error Details :: ${error.message}');
      return HttpResponse(
          status: false, errMessage: "Something went Wrong.", json: null);
    }
  }

  Future<HttpResponse> postRequestWithHeader(
      ApiType url, Map<String, dynamic> params, String token) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }

    final requestFinal = ApiConstant.requestParamsForSyncWithHeader(url,
        params: params, token: token);
    final option = Options(headers: requestFinal.header);
    print(requestFinal.params);
//
    try {
      final response = await Dio().post(requestFinal.url,
          data: json.encode(requestFinal.params), options: option);

      print("Response Status code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        // UserModel user = loginResponseFromJson(response.json);
        // final jsonData = json.decode(jsonResponse);

        final message = jsonResponse[ResonseKeys.kMessage] ?? '';
        final status = jsonResponse[ResonseKeys.kStatus] ?? false;
        final data = jsonResponse[ResonseKeys.kData];
        return HttpResponse(
            status: status == 200 ? true : false,
            errMessage: message,
            json: response.data);
      } else {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        var errMessage =
            jsonResponse[ResonseKeys.kMessage] ?? "Something went Wrong.";
        return HttpResponse(
            status: false, errMessage: errMessage, json: response.toString());
      }
    } on DioError catch (error) {
      print('Error Details :: ${error.message}');
      return HttpResponse(
          status: false, errMessage: "Something went Wrong.", json: null);
    }
  }

  Future<HttpResponse> deleteRequestWithHeader(
      ApiType url, Map<String, dynamic> params, String token) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }

    final requestFinal = ApiConstant.requestParamsForSyncWithHeader(url,
        params: params, token: token);
    final option = Options(headers: requestFinal.header);
    print(requestFinal.params);
//
    try {
      final response = await Dio().delete(requestFinal.url,
          data: json.encode(requestFinal.params), options: option);

      print("Response Status code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        // UserModel user = loginResponseFromJson(response.json);
        // final jsonData = json.decode(jsonResponse);

        final message = jsonResponse[ResonseKeys.kMessage] ?? '';
        final status = jsonResponse[ResonseKeys.kStatus] ?? false;
        final data = jsonResponse[ResonseKeys.kData];
        return HttpResponse(
            status: status == 200 ? true : false,
            errMessage: message,
            json: response.data);
      } else {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        var errMessage =
            jsonResponse[ResonseKeys.kMessage] ?? "Something went Wrong.";
        return HttpResponse(
            status: false, errMessage: errMessage, json: response.toString());
      }
    } on DioError catch (error) {
      print('Error Details :: ${error.message}');
      return HttpResponse(
          status: false, errMessage: "Something went Wrong.", json: null);
    }
  }

  Future<HttpResponse> postRequestWithHeaderDecode(
      ApiType url, Map<String, dynamic> params, String token) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }

    final requestFinal = ApiConstant.requestParamsForSyncWithHeader(url,
        params: params, token: token);
    final option = Options(headers: requestFinal.header);
    print(requestFinal.params);
//
    try {
      final response = await Dio().post(requestFinal.url,
          data: json.encode(requestFinal.params), options: option);

      print("Response Status code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;

        //   Map<String, dynamic> jsonResponse = response.data;
        print("response body :: $jsonResponse");

        String jsonsDataString = jsonResponse.toString();
        final jsonData = jsonDecode(jsonsDataString);

        var message = "";
        // UserModel user = loginResponseFromJson(response.json);
        if (jsonData[ResonseKeys.kMessage] != null) {
          message = jsonData[ResonseKeys.kMessage] ?? '';
        }
        final status = jsonData[ResonseKeys.kStatus] ?? false;
        return HttpResponse(
            status: status == 200 ? true : false,
            errMessage: message,
            json: jsonData);
      } else {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        var errMessage =
            jsonResponse[ResonseKeys.kMessage] ?? "Something went Wrong.";
        return HttpResponse(
            status: false, errMessage: errMessage, json: response.toString());
      }
    } on DioError catch (error) {
      print('Error Details :: ${error.message}');
      return HttpResponse(
          status: false, errMessage: "Something went Wrong.", json: null);
    }
  }

  Future<HttpResponse> postRequestWithHeaderDecodeWithoutParam(
      ApiType url, String token) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }
    final requestFinal =
        ApiConstant.requestParamsForSyncWithoutParam2(url, token);

    // final requestFinal = ApiConstant.requestParamsForSyncWithHeaderWithoutParam(url,token);
    final option = Options(headers: requestFinal.header);
//
    try {
      final response = await Dio().post(requestFinal.url, options: option);
      //  final response = await Dio().post(requestFinal.url,data: json.encode, options: option);

      print("Response Status code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        // UserModel user = loginResponseFromJson(response.json);
        final jsonData = json.decode(jsonResponse);
        final message = jsonData[ResonseKeys.kMessage] ?? '';
        final status = jsonData[ResonseKeys.kStatus] ?? false;
        final data = jsonData[ResonseKeys.kData];
        return HttpResponse(
            status: status == 200 ? true : false,
            errMessage: message,
            json: response.data);
      } else {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        var errMessage =
            jsonResponse[ResonseKeys.kMessage] ?? "Something went Wrong.";
        return HttpResponse(
            status: false, errMessage: errMessage, json: response.toString());
      }
    } on DioError catch (error) {
      print('Error Details :: ${error.message}');
      return HttpResponse(
          status: false, errMessage: "Something went Wrong.", json: null);
    }
  }

  Future<HttpResponse> postRequest(
      ApiType url, Map<String, dynamic> params) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }

    final requestFinal = ApiConstant.requestParamsForSync(url, params: params);
    final option = Options(headers: requestFinal.header);

    try {
      final response = await Dio().post(requestFinal.url,
          data: json.encode(requestFinal.params), options: option);

      print("Response Status code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;

        final jsonData = json.decode(jsonResponse);

        final message = jsonData[ResonseKeys.kMessage] ?? '';
        final status = jsonData[ResonseKeys.kStatus] ?? false;
        final data = jsonData[ResonseKeys.kData];

        print("response body :: $jsonResponse");
        // if (jsonResponse['status'] == 200){
        // final message = jsonResponse[ResonseKeys.kMessage] ?? '';
        // final status = jsonResponse[ResonseKeys.kStatus] ?? false;
        // final data = jsonResponse.toString();
        return HttpResponse(
            status: status == 200 ? true : false,
            errMessage: message,
            json: response.data);
      } else {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        var errMessage =
            jsonResponse[ResonseKeys.kMessage] ?? "Something went Wrong.";
        return HttpResponse(
            status: false, errMessage: errMessage, json: response.toString());
        // }
      }
    } on DioError catch (error) {
      print('Error Details :: ${error.message}');
      return HttpResponse(
          status: false, errMessage: "Something went Wrong.", json: null);
    }
  }

/*
  Future<HttpResponse> postRequestFormData(
      ApiType url, Map<String, dynamic> params) async {

        ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    
     result = await _connectivity.checkConnectivity();
    
    print(result);
  if (result.index == 2){
            return HttpResponse(
          status: false, errMessage: 'Please check your internet connection.', json: null);
      
    }

    
    final requestFinal = ApiConstant.requestParamsForSync(url, params: params);
    final option = Options(headers: requestFinal.header);

    FormData formData = new FormData.fromMap(requestFinal.params);

    try {
      final response = await Dio().post(requestFinal.url,
          data: formData, options: option);

       print("Response Status code:: ${response.statusCode}");
       if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        final message = jsonResponse[ResonseKeys.kMessage] ?? '';
        final status = jsonResponse[ResonseKeys.kStatus] ?? false;
        final data = jsonResponse[ResonseKeys.kData];
        return HttpResponse(
            status: status, errMessage: message, json: data);
      } else {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        var errMessage =
            jsonResponse[ResonseKeys.kMessage] ?? "Something went Wrong.";
        return HttpResponse(
            status: false, errMessage: errMessage, json: response.toString());
      }
    } on DioError catch (error) {
      print('Error Details :: ${error.message}');
      return HttpResponse(
          status: false, errMessage: "Something went Wrong.", json: null);
    }
  }
*/
  Future<HttpResponse> postRequestWithoutParam(
    ApiType url,
  ) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }

    final requestFinal = ApiConstant.requestParamsForSyncWithoutParam(
      url,
    );
    final option = Options(headers: requestFinal.header);

    try {
      final response = await Dio().post(requestFinal.url,
          data: json.encode(requestFinal.params), options: option);

      print("Response Status code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        final message = jsonResponse[ResonseKeys.kMessage] ?? '';
        final status = jsonResponse[ResonseKeys.kStatus] ?? false;
        final data = jsonResponse[ResonseKeys.kData];
        return HttpResponse(status: status, errMessage: message, json: data);
      } else {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");

        var errMessage =
            jsonResponse[ResonseKeys.kMessage] ?? "Something went Wrong.";
        return HttpResponse(
            status: false, errMessage: errMessage, json: response.toString());
      }
    } on DioError catch (error) {
      print('Error Details :: ${error.message}');
      return HttpResponse(
          status: false, errMessage: "Something went Wrong.", json: null);
    }
  }

  Future<ForgotPasswordResponse> callForgotPassword(
      {ForgotPasswordRequest params}) async {
    final HttpResponse response =
        await this.postRequest(ApiType.forgotPassword, params.toJson());
    if (response.status == true) {
      UserModel user = loginResponseFromJson(response.json);
      return ForgotPasswordResponse(
        status: user.status == 200 ? true : false,
        message: user.message,
      );
    } else {
      return ForgotPasswordResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<CreateEventResponse> callCreateEventApi(
      {CreateEventRequest params, List<AppMultiPartFile> arrFile}) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    final HttpResponse response = await this.imageUploadingApiWithHeader(
        ApiType.event, params.toJson(), arrFile, tokenString);
    // await this.postRequest(, );
    if (response.status) {
      //  EventId eventId = eventIdResponseFromJson(response.json);
      print(response.json);
      EventId eventId = EventId.fromJson(response.json);

      return CreateEventResponse(
          status: response.status,
          message: response.errMessage,
          eventData: eventId); //,user: user);
    } else {
      return CreateEventResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<RegisterResponse> callSignupAPI(
      {RegisterRequestNew params, List<AppMultiPartFile> arrFile}) async {
    final HttpResponse response = await this
        .imageUploadingApi(ApiType.register, params.toJson(), arrFile);
    // await this.postRequest(, );
    UserModel user = UserModel.fromJson(response.json);

    if (response.status) {
      // UserModel user = loginResponseFromJson(response.json);
      return RegisterResponse(
          userModel: user,
          status: response.status,
          message: response.errMessage); //,user: user);
    } else {
      return RegisterResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<UpdateProfileResponse> callUpdateProfileAfterSignUp(
      {NewUpdateProfileRequest params, List<AppMultiPartFile> arrFile}) async {
    final HttpResponse response = await this
        .imageUploadingApiPUT(ApiType.register, params.toJson(), arrFile);
    // await this.postRequest(, );
    if (response.status) {
      UserModel user = UserModel.fromJson(response.json);

      return UpdateProfileResponse(
          status: response.status,
          message: response.errMessage,
          userModel: user); //,user: user);
    } else {
      return UpdateProfileResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<UpdateProfileResponse> callUpdateProfile(
      {UpdateProfileRequest params, List<AppMultiPartFile> arrFile}) async {
    final HttpResponse response = await this
        .imageUploadingApiPUT(ApiType.register, params.toJson(), arrFile);
    // await this.postRequest(, );
    if (response.status) {
      UserModel user = UserModel.fromJson(response.json);

      return UpdateProfileResponse(
          status: response.status,
          message: response.errMessage,
          userModel: user); //,user: user);
    } else {
      return UpdateProfileResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<BadgeResponse> callBadgeDataApi(GetBedgeRequest params) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    final HttpResponse response = await this
        .postRequestWithHeader(ApiType.getBadge, params.toJson(), tokenString);
    if (response.status == true) {
      // final jsonData = json.decode(response.json);
      final data = response.json[ResonseKeys.kData];
      final upcoming_event_count = data['upcoming_event_count'];
      final discover_event_count = data['discover_event_count'];
      final alert_count = data['alert_count'];

      return BadgeResponse(
        //  eventList: eventList,
        status: response.status,
        message: response.errMessage,
        social: upcoming_event_count,
        discover: discover_event_count,
        alert: alert_count,
      );
    } else {
      return BadgeResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<CMSDataResponse> callCMSDataApi() async {
    String _baseDomain = 'http://18.191.236.123:3000/api/v1/';

    final String apiUrl = _baseDomain + ApiConstant.getValue(ApiType.cms);

    final HttpResponse response = await this.getRequest(apiUrl);
    // await this.postRequest(ApiType.login, params.toJson());
    if (response.status == true) {
      final jsonData = json.decode(response.json);
      // final data = response.json[ResonseKeys.kData];
      final data = jsonData[ResonseKeys.kData];

      //  allData = allDataResponseFromJson(response.json);
      List<CMSModel> cmsList;
      cmsList = [];
      data.forEach((v) {
        var model = new CMSModel.fromJson(v);
        cmsList.add(model);
      });

      return CMSDataResponse(
          status: response.status,
          message: '',
          dataModel: cmsList); //, userModel: user);
    } else {
      return CMSDataResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<MainDataResponse> callMainDataApi() async {
    String _baseDomain = 'http://18.191.236.123:3000/api/v1/user/';

    final String apiUrl =
        _baseDomain + ApiConstant.getValue(ApiType.getMasterTableData);

    final HttpResponse response = await this.getRequest(apiUrl);
    // await this.postRequest(ApiType.login, params.toJson());
    if (response.status == true) {
      AllDataModel allData = allDataResponseFromJson(response.json);

      return MainDataResponse(
          status: response.status,
          message: '',
          dataModel: allData); //, userModel: user);
    } else {
      return MainDataResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<InvitationCardDataResponse> callPickupInvitation() async {
    String _baseDomain = 'http://18.191.236.123:3000/api/v1/event/';

    final String apiUrl =
        _baseDomain + ApiConstant.getValue(ApiType.invitationCards);

    final HttpResponse response = await this.getRequest(apiUrl);

    if (response.status == true) {
      // final jsonData = json.decode(response.json);
      final data = response.json[ResonseKeys.kData];

      // List<EventList> eventList;
      //    eventList = [];
      // data.forEach((v) {
      //         var model = new EventList.fromJson(v);
      //         eventList.add(model);
      // });
      List<InvitationCardModel> invitationList;
      invitationList = [];
      data.forEach((v) {
        var model = new InvitationCardModel.fromJson(v);
        invitationList.add(model);
      });

      return InvitationCardDataResponse(
          status: response.status,
          message: '',
          invitationList: invitationList); //, userModel: user);
    } else {
      return InvitationCardDataResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<LoginCheckResponse> callLogin({LoginCheckRequest params}) async {
    final HttpResponse response =
        await this.postRequest(ApiType.login, params.toJson());
    if (response.status == true) {
      UserModel user = loginResponseFromJson(response.json);
      return LoginCheckResponse(
          status: response.status, message: '', userModel: user);
    } else {
      return LoginCheckResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

// Future<LoginCheckResponse> callLogin({LoginCheckRequest params}) async {
//     final HttpResponse response =
//     await this.postRequest(ApiType.login, params.toJson());
//     if (response.status == true) {
//         print(response.json);
//         // var dataJson = response.json['data'];

//       return LoginCheckResponse(
//           status: response.status, message: '',);
//     } else {
//       return LoginCheckResponse(
//           status: response.status,
//           message: response.errMessage,
//         );
//     }
//   }

  Future<LoginCheckResponse> callRegister({LoginCheckRequest params}) async {
    final HttpResponse response = // response
        await this.postRequest(ApiType.login, params.toJson());
    if (response.status == true) {
      return LoginCheckResponse(status: response.status, message: '');
    } else {
      return LoginCheckResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<CancelEventResponse> callCancelEventApi({
    CancelEventRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this.postRequestWithHeaderDecode(
        ApiType.cancelEvent, params.toJson(), tokenString);
    if (response.status == true) {
      final jsonData = json.decode(response.json);
      final data = jsonData[ResonseKeys.kData];

      // List<EventList> eventList;
      //    eventList = [];
      // data.forEach((v) {
      //         var model = new EventList.fromJson(v);
      //         eventList.add(model);
      // });l

      return CancelEventResponse(
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return CancelEventResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<ResetPasswordResponse> callResetPasswordEventApi({
    ResetPasswordRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this.postRequestWithHeaderDecode(
        ApiType.changePassword, params.toJson(), tokenString);
    if (response.status == true) {
      // final jsonData = json.decode(response.json);
      // final data = response.json[ResonseKeys.kData];

      // List<EventList> eventList;
      //    eventList = [];
      // data.forEach((v) {
      //         var model = new EventList.fromJson(v);
      //         eventList.add(model);
      // });l

      return ResetPasswordResponse(
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return ResetPasswordResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<NotificationSettingResponse> callNotificationSettings({
    AlertSettingsRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    final HttpResponse response = await this.postRequestWithHeaderDecode(
        ApiType.notificationSetting, params.toJson(), tokenString);
    if (response.status == true) {
      //  final jsonData = json.decode(response.json);
      final data = response.json[ResonseKeys.kData];

      NotificationSettings model = new NotificationSettings.fromJson(data);

      // NotificationSettings notification =
      // notificationResponseFromJson(response.json);
      return NotificationSettingResponse(
        settingModel: model,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return NotificationSettingResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<AttendNotificationResponse> callCancelSocial({
    CancelSocialRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    final HttpResponse response = await this.postRequestWithHeader(
        ApiType.cancel_social, params.toJson(), tokenString);
    if (response.status == true) {
      //  final jsonData = json.decode(response.json);
      // final data = response.json[ResonseKeys.kData];

      return AttendNotificationResponse(
        //  eventList: eventList,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return AttendNotificationResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<AttendNotificationResponse> callUpdateSuggesionTime({
    UpdateSuggestionRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    final HttpResponse response = await this.postRequestWithHeader(
        ApiType.update_suggested_time, params.toJson(), tokenString);
    if (response.status == true) {
      //  final jsonData = json.decode(response.json);
      // final data = response.json[ResonseKeys.kData];

      return AttendNotificationResponse(
        //  eventList: eventList,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return AttendNotificationResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<AttendNotificationResponse> callDeclineEventNotification({
    CreateEventTimeRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    final HttpResponse response = await this.postRequestWithHeader(
        ApiType.decline_proposed_time, params.toJson(), tokenString);
    if (response.status == true) {
      //  final jsonData = json.decode(response.json);
      // final data = response.json[ResonseKeys.kData];

      return AttendNotificationResponse(
        //  eventList: eventList,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return AttendNotificationResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<AttendNotificationResponse> callInviteduserAprove({
    CreateEventTimeRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    final HttpResponse response = await this.postRequestWithHeader(
        ApiType.event_inviteduser_aprove, params.toJson(), tokenString);
    if (response.status == true) {
      //  final jsonData = json.decode(response.json);
      // final data = response.json[ResonseKeys.kData];

      return AttendNotificationResponse(
        //  eventList: eventList,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return AttendNotificationResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<RatingResponse> callRatingResponse({
    UserRatingRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    final HttpResponse response = await this.postRequestWithHeader(
        ApiType.userrating, params.toJson(), tokenString);
    if (response.status == true) {
      //  final jsonData = json.decode(response.json);
      // final data = response.json[ResonseKeys.kData];

      return RatingResponse(
        //  eventList: eventList,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return RatingResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<CheckInEventListResponse> callCheckEventList({
    CheckInRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    final HttpResponse response = await this.postRequestWithHeader(
        ApiType.eventCheckIn, params.toJson(), tokenString);
    if (response.status == true) {
      //  final jsonData = json.decode(response.json);
      // final data = response.json[ResonseKeys.kData];

      return CheckInEventListResponse(
        //  eventList: eventList,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return CheckInEventListResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<PickupInvitationResponse> callPickupInvitationApi({
    PickupInvitationCardRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this.postRequestWithHeader(
        ApiType.purchaseInvitationCard, params.toJson(), tokenString);
    if (response.status == true) {
      return PickupInvitationResponse(
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return PickupInvitationResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<SendChatResponse> callSendMessageApi({
    SendMessageRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    // String headertoken = preferences.getString('apiAccessToken');
    String headertoken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiaWF0IjoxNTg5MTc0MjY5fQ.zPK7HOnK-0ewn_qB8vPkDewYg5YwuY_MimkDfV1iJlM';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this.postRequestWithHeaderDecode(
        ApiType.sendMessage, params.toJson(), tokenString);
    if (response.status == true) {
      // final jsonData = json.decode(response.json);
      final data = response.json[ResonseKeys.kData];

      // List<ChatMessage> chatList;
      // chatList = [];
      // data.forEach((v) {
      //   var model = new ChatMessage.fromJson(v);
      //   chatList.add(model);
      // });

      return SendChatResponse(
        // chatList: chatList,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return SendChatResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<ChatListResponse> callChatListApi({
    ChatListRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    // String headertoken = preferences.getString('apiAccessToken');
    String headertoken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiaWF0IjoxNTg5MTc0MjY5fQ.zPK7HOnK-0ewn_qB8vPkDewYg5YwuY_MimkDfV1iJlM';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this.postRequestWithHeaderDecode(
        ApiType.allChatMessages, params.toJson(), tokenString);
    if (response.status == true) {
      // final jsonData = json.decode(response.json);
      final data = response.json[ResonseKeys.kData];

      List<ChatMessage> chatList;
      chatList = [];
      data.forEach((v) {
        var model = new ChatMessage.fromJson(v);
        chatList.add(model);
      });

      return ChatListResponse(
        chatList: chatList,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return ChatListResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<EvenDetailResponse> callEvenntDetailsApi({
    EventDetailRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this.postRequestWithHeaderDecode(
        ApiType.eventDetail, params.toJson(), tokenString);
    if (response.status == true) {
      // final jsonData = json.decode(response.json);
      final data = response.json[ResonseKeys.kData];
      var event = EventList.fromJson(data);
      return EvenDetailResponse(
        event: event,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return EvenDetailResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<EventListResponse> callEvenntListApi({
    EventListRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');
    // String headertoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNTg3NDYzNDkxfQ.cINdxhEuN-wjfKCziuaevpnU8PvTCgG_hU_ZG0hqpIw';
    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this.postRequestWithHeaderDecode(
        ApiType.eventList, params.toJson(), tokenString);
    if (response.status == true) {
      // final jsonData = json.decode(response.json);
      final data = response.json[ResonseKeys.kData];

      List<EventList> eventList;
      eventList = [];
      data.forEach((v) {
        var model = new EventList.fromJson(v);
        eventList.add(model);
      });

      return EventListResponse(
        eventList: eventList,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return EventListResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<NotificationListResponse> callNotificationListApi({
    NotificationListRequest params,
  }) async {
    // DiscoverListRequest param = DiscoverListRequest();
    // param.eventDate = "";
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');

    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this.postRequestWithHeaderDecode(
        ApiType.notificationList, params.toJson(), tokenString);

    // final HttpResponse response = await this.postRequestWithHeaderWithoutParam( ApiType.discover, tokenString);
    if (response.status == true) {
      // final jsonData = json.decode(response.json);
      final data = response.json[ResonseKeys.kData];

      List<NotificationList> notificationList;
      notificationList = [];
      data.forEach((v) {
        var model = new NotificationList.fromJson(v);
        notificationList.add(model);
      });

      return NotificationListResponse(
        notifications: notificationList,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return NotificationListResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<DiscoverEventListResponse> callDiscoverEvenntListApi() async {
    // DiscoverListRequest param = DiscoverListRequest();
    // param.eventDate = "";
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');

    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this
        .postRequestWithHeaderDecodeWithoutParam(ApiType.discover, tokenString);

    // final HttpResponse response = await this.postRequestWithHeaderWithoutParam( ApiType.discover, tokenString);
    if (response.status == true) {
      final jsonData = json.decode(response.json);
      final data = jsonData[ResonseKeys.kData];

      List<EventList> eventList;
      eventList = [];
      data.forEach((v) {
        var model = new EventList.fromJson(v);
        eventList.add(model);
      });

      return DiscoverEventListResponse(
        eventList: eventList,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return DiscoverEventListResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

// event_new_proposed_time

  Future<EventProposedNewTimeResponse> callEventProposedTimeApi({
    NewProposedTimeRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');

    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this.postRequestWithHeader(
        ApiType.event_new_proposed_time, params.toJson(), tokenString);
    if (response.status == true) {
      // final jsonData = json.decode(response.json);

      return EventProposedNewTimeResponse(
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return EventProposedNewTimeResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<WeekEventResponse> callEventWeekListApi({
    WeekEventRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');

    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this.postRequestWithHeader(
        ApiType.get_weekly_date_event, params.toJson(), tokenString);
    if (response.status == true) {
      // final jsonData = json.decode(response.json);
      final data = response.json[ResonseKeys.kData];

      List<EventDateList> eventList;
      eventList = [];
      data.forEach((v) {
        var model = new EventDateList.fromJson(v);
        eventList.add(model);
      });

      return WeekEventResponse(
        dateTime: eventList,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return WeekEventResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<DeleteAccoundResponse> callDeleteAccountApi({
    FreeEventRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');

    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this.deleteRequestWithHeader(
        ApiType.register, params.toJson(), tokenString);
    if (response.status == true) {
      // final jsonData = json.decode(response.json);

      return DeleteAccoundResponse(
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return DeleteAccoundResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<FreeEventResponse> callFreeEventCheckApi({
    FreeEventRequest params,
  }) async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');

    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    // final HttpResponse response = await this.getRequestWithHeader(
    //   ApiType.servicesAndCategoryList, params.toJson(), tokenString);

    final HttpResponse response = await this.postRequestWithHeader(
        ApiType.checkmonthlyfreeevent, params.toJson(), tokenString);
    if (response.status == true) {
      // final jsonData = json.decode(response.json);
      final data = response.json[ResonseKeys.kData];
      final isallow = data['allow'];

      return FreeEventResponse(
        isAllow: isallow,
        status: response.status,
        message: response.errMessage,
      );
    } else {
      return FreeEventResponse(
        status: response.status,
        message: response.errMessage,
      );
    }
  }

  Future<HttpResponse> uploadRequest(
    ApiType url,
    Map<String, dynamic> params,
    List<AppMultiPartFile> arrFile,
  ) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }

    final requestFinal =
        ApiConstant.requestParamsForSync(url, params: params, arrFile: arrFile);

    Map<String, dynamic> other = Map<String, dynamic>();
    other.addAll(requestFinal.params);

    var formData = FormData();
    AppMultiPartFile mfile = requestFinal.files[0];

    //  String fileName = mfile.localFile.path.split('/').last;
    // final context = MediaType('image/png');//('image/*', 'image/*');

    formData.files.addAll([
      //  for (AppMultiPartFile mfile in requestFinal.files) {
      MapEntry(
        other[mfile.key],
        MultipartFile.fromFileSync(mfile.localFile.path, filename: 'image'),
        // MultipartFile.fromFileSync(mfile.localFile.path,
        // filename: basename(mfile.localFile.path,),),
      ),
      // }
    ]);

    final option = Options(headers: requestFinal.header);

    try {
      final response = await Dio().post(requestFinal.url,
          data: formData, options: option, onSendProgress: (sent, total) {
        print("uploadFile ${sent / total}");
      });

      print("Response Status code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");
        final message = jsonResponse[ResonseKeys.kMessage] ?? '';
        final status = jsonResponse[ResonseKeys.kStatus] ?? 400;
        final data = jsonResponse[ResonseKeys.kData];
        return HttpResponse(
            status: (status == 200), errMessage: message, json: data);
      } else {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");
        var errMessage =
            jsonResponse[ResonseKeys.kMessage] ?? "Something went wrong.";
        return HttpResponse(
            status: false, errMessage: errMessage, json: jsonResponse);
      }
    } on DioError catch (error) {
      print('Error Details :: ${error.message}');
      return HttpResponse(
          status: false, errMessage: "Something went wrong.", json: null);
    }
  }

  /// UPLOAD REQUEST API (image upload)
  Future<HttpResponse> imageUploadingApi(
    ApiType url,
    Map<String, dynamic> params,
    List<AppMultiPartFile> arrFile,
  ) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }

    final requestFinal =
        ApiConstant.requestParamsForSync(url, params: params, arrFile: arrFile);

    var formData = FormData();

    if (arrFile != null) {
      AppMultiPartFile mfile = requestFinal.files[0];
      final context = ContentType('image/*', 'image/*');

      var file = await MultipartFile.fromFile(mfile.localFile.path,
          filename: basename(mfile.localFile.path));
      formData = new FormData.fromMap(requestFinal.params);
      formData.files.add(MapEntry(mfile.key, file));

      print(basename(mfile.localFile.path));
      print(file.filename);
      print(file.contentType);
    } else {
      formData = new FormData.fromMap(requestFinal.params);
    }
    // FormData formData = new FormData.from(other);
    final option = Options(headers: requestFinal.header);

    try {
      final response = await Dio().post(requestFinal.url,
          data: formData, options: option, onSendProgress: (sent, total) {
        print("uploadFile ${sent / total}");
      });

      print("Response Status code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");
        final message = jsonResponse[ResonseKeys.kMessage] ?? '';
        final status = jsonResponse[ResonseKeys.kStatus] ?? true;
        final data = jsonResponse[ResonseKeys.kData];
        return HttpResponse(status: true, errMessage: message, json: data);
      } else {
        dynamic jsonResponse = response.data;

        print("response body :: $jsonResponse");
        var errMessage =
            jsonResponse[ResonseKeys.kMessage] ?? "Something went wrong.";
        return HttpResponse(
            status: false, errMessage: errMessage, json: jsonResponse);
      }
    } on DioError catch (error) {
      print('Error Details :: ${error.message}');
      print('Error Details :: ${error.response}');

      dynamic jsonResponse = error.response.data;
      print("response body :: $jsonResponse");
      final message = jsonResponse[ResonseKeys.kMessage] ?? '';
      // final status = jsonResponse[ResonseKeys.kStatus] ?? false;
      // final data = jsonResponse[ResonseKeys.kData];

      return HttpResponse(
          status: false,
          errMessage: message ?? "Something went wrong.",
          json: error.response);
    }
  }

  /// UPLOAD REQUEST API (image upload)
  Future<HttpResponse> imageUploadingApiWithHeader(
      ApiType url,
      Map<String, dynamic> params,
      List<AppMultiPartFile> arrFile,
      String token) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }

    final requestFinal = ApiConstant.requestParamsForSyncWithHeader(url,
        params: params, token: token, arrFile: arrFile);

    var formData = FormData();

    if (arrFile != null) {
      AppMultiPartFile mfile = requestFinal.files[0];
      final context = ContentType('image/*', 'image/*');

      var file = await MultipartFile.fromFile(mfile.localFile.path,
          filename: basename(mfile.localFile.path));
      formData = new FormData.fromMap(requestFinal.params);
      formData.files.add(MapEntry(mfile.key, file));

      print(basename(mfile.localFile.path));
      print(file.filename);
      print(file.contentType);
    } else {
      formData = new FormData.fromMap(requestFinal.params);
    }
    // FormData formData = new FormData.from(other);
    final option = Options(headers: requestFinal.header);

    try {
      final response = await Dio().post(requestFinal.url,
          data: formData, options: option, onSendProgress: (sent, total) {
        print("uploadFile ${sent / total}");
      });

      print("Response Status code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");
        final message = jsonResponse[ResonseKeys.kMessage] ?? '';
        final status = jsonResponse[ResonseKeys.kStatus] ?? true;
        final data = jsonResponse[ResonseKeys.kData];
        return HttpResponse(status: true, errMessage: message, json: data);
      } else {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");
        var errMessage =
            jsonResponse[ResonseKeys.kMessage] ?? "Something went wrong.";
        return HttpResponse(
            status: false, errMessage: errMessage, json: jsonResponse);
      }
    } on DioError catch (error) {
      print('Error Details :: ${error.message}');
      print('Error Details :: ${error.response}');

      dynamic jsonResponse = error.response.data;
      print("response body :: $jsonResponse");
      final message = jsonResponse[ResonseKeys.kMessage] ?? '';
      final status = jsonResponse[ResonseKeys.kStatus] ?? false;
      final data = jsonResponse[ResonseKeys.kData];

      return HttpResponse(
          status: false,
          errMessage: message ?? "Something went wrong.",
          json: error.response);
    }
  }

  /// UPLOAD REQUEST API (image upload)
  Future<HttpResponse> imageUploadingApiPUT(
    ApiType url,
    Map<String, dynamic> params,
    List<AppMultiPartFile> arrFile,
  ) async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.

    result = await _connectivity.checkConnectivity();

    print(result);
    if (result.index == 2) {
      return HttpResponse(
          status: false,
          errMessage: 'Please check your internet connection.',
          json: null);
    }
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String headertoken = preferences.getString('apiAccessToken');

    String tokenString = '';
    if (headertoken != null) {
      tokenString = 'Bearer ' + headertoken;
    }

    if (headertoken == null) {
      headertoken = "";
      tokenString = '';
    }

    final requestFinal = ApiConstant.requestParamsForSync2(url, tokenString,
        params: params, arrFile: arrFile);

    var formData = FormData();

    if (arrFile != null) {
      AppMultiPartFile mfile = requestFinal.files[0];
      final context = ContentType('image/*', 'image/*');

      var file = await MultipartFile.fromFile(mfile.localFile.path,
          filename: basename(mfile.localFile.path));
      formData = new FormData.fromMap(requestFinal.params);
      formData.files.add(MapEntry(mfile.key, file));

      print(basename(mfile.localFile.path));
      print(file.filename);
      print(file.contentType);
    } else {
      formData = new FormData.fromMap(requestFinal.params);
    }
    print(requestFinal.params);
    // FormData formData = new FormData.from(other);
    final option = Options(headers: requestFinal.header);

    try {
      final response = await Dio().put(requestFinal.url,
          data: formData, options: option, onSendProgress: (sent, total) {
        print("uploadFile ${sent / total}");
      });
      // final response = await Dio().post(requestFinal.url,
      //     data: formData, options: option, onSendProgress: (sent, total) {
      //   print("uploadFile ${sent / total}");
      // });

      print("Response Status code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");
        final message = jsonResponse[ResonseKeys.kMessage] ?? '';
        final status = jsonResponse[ResonseKeys.kStatus] ?? true;
        final data = jsonResponse[ResonseKeys.kData];
        return HttpResponse(status: true, errMessage: message, json: data);
      } else {
        dynamic jsonResponse = response.data;
        print("response body :: $jsonResponse");
        var errMessage =
            jsonResponse[ResonseKeys.kMessage] ?? "Something went wrong.";
        return HttpResponse(
            status: false, errMessage: errMessage, json: jsonResponse);
      }
    } on DioError catch (error) {
      print('Error Details :: ${error.message}');
      print('Error Details :: ${error.response}');

      dynamic jsonResponse = error.response.data;
      print("response body :: $jsonResponse");
      final message = jsonResponse[ResonseKeys.kMessage] ?? '';
      final status = jsonResponse[ResonseKeys.kStatus] ?? false;
      final data = jsonResponse[ResonseKeys.kData];

      return HttpResponse(
          status: false,
          errMessage: message ?? "Something went wrong.",
          json: error.response);
    }
  }
}

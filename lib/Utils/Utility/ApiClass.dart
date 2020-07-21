import 'dart:io';

enum ApiVersion { v1, v2 }

enum ApiType {
  login,
  register,
  forgotPassword,
  getMasterTableData,
  eventList,
  invitationCards,
  cancelEvent,
  eventCheckIn,
  event,
  getBadge,
  get_weekly_date_event,
  event_new_proposed_time,
  discover,
  purchaseInvitationCard,
  notificationList,
  changePassword,
  cms,
  notificationSetting,
  userrating,
  event_inviteduser_aprove,
  cancel_social,
  decline_proposed_time,
  update_suggested_time,
  postReportByuser,
  update_flag_read_alert,
  notificationConnect,
  allChatMessages,
  sendMessage,
  checkmonthlyfreeevent,

  eventDetail,
}

class ApiConstant {
  static String _baseDomain = 'http://18.191.236.123:3000/api/v1/';

  static String getVersionValue(ApiVersion version) {
    switch (version) {
      case ApiVersion.v1:
        return 'v1/';
      case ApiVersion.v2:
        return 'v2/';
    }
  }

  static String getValue(ApiType type) {
    switch (type) {
      case ApiType.login:
        return 'user/login';

      case ApiType.register:
        return 'user/';

      case ApiType.forgotPassword:
        return 'user/forgotPassword';

      case ApiType.getMasterTableData:
        return 'GetMasterTableData';

      case ApiType.eventList:
        return 'event/eventList';

      case ApiType.invitationCards:
        return 'invitationCards';

      case ApiType.cancelEvent:
        return 'event/cancelEvent';

      case ApiType.eventCheckIn:
        return 'event/event_check_in';

      case ApiType.event:
        return 'event/';

      case ApiType.getBadge:
        return 'event/get_badge';

      case ApiType.get_weekly_date_event:
        return 'event/get_weekly_date_event';
      case ApiType.discover:
        return 'event/discover_event';

      case ApiType.purchaseInvitationCard:
        return 'event/purchaseInvitationCard';

      case ApiType.event_new_proposed_time:
        return 'event/event_new_proposed_time';

      case ApiType.notificationList:
        return 'notification/notificationList';

      case ApiType.changePassword:
        return 'user/changePassword';

      case ApiType.cms:
        return 'cms';

      case ApiType.notificationSetting:
        return 'notification/notificationSetting';

      case ApiType.userrating:
        return 'user/userrating';

      case ApiType.event_inviteduser_aprove:
        return 'event/event_inviteduser_aprove';

      case ApiType.cancel_social:
        return 'event/cancel_social';

      case ApiType.decline_proposed_time:
        return 'event/decline_proposed_time';

      case ApiType.update_suggested_time:
        return 'event/update_suggested_time';

      case ApiType.postReportByuser:
        return 'event/postReportByuser';

      case ApiType.update_flag_read_alert:
        return 'notification/update_flag_read_alert';

      case ApiType.notificationConnect:
        return 'notification/notificationConnect';

      case ApiType.allChatMessages:
        return 'chat/allChatMessages';

      case ApiType.sendMessage:
        return 'chat/sendMessage';

      case ApiType.checkmonthlyfreeevent:
        return 'user/checkmonthlyfreeevent';

      case ApiType.eventDetail:
        return 'event/eventDetail';

      default:
        return "";
    }
  }

  /*
  * Tuple Sequence
  * - Url
  * - Header
  * - params
  * - files
  * */

  static FinalRequest2 requestParamsForSync2(ApiType type, String token,
      {Map<String, dynamic> params,
      List<AppMultiPartFile> arrFile = const []}) {
    final String apiUrl = ApiConstant._baseDomain + ApiConstant.getValue(type);

    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json' //'application/x-www-form-urlencoded'
        ,
        'Authorization': token
      };

      print("Request Url :: $apiUrl");
      print("Request headers :: $headers");

      return FinalRequest2(
          url: apiUrl, params: params, header: headers, files: arrFile);
    } else {
      Map<String, String> headers = {
        'Content-Type': 'application/json' //'application/x-www-form-urlencoded'
      };

      print("Request Url :: $apiUrl");
      print("Request headers :: $headers");

      return FinalRequest2(
          url: apiUrl, params: params, header: headers, files: arrFile);
    }
    // url: apiUrl, params: params, header: headers, files: arrFile);
  }

  static FinalRequest requestParamsForSync(ApiType type,
      {Map<String, dynamic> params,
      List<AppMultiPartFile> arrFile = const []}) {
    final String apiUrl = ApiConstant._baseDomain + ApiConstant.getValue(type);
    Map<String, String> headers = {
      'Content-Type': 'application/json', //'application/x-www-form-urlencoded'
    };

    print("Request Url :: $apiUrl");
    print("Request Params :: $params");
    print("Request headers :: $headers");

    return FinalRequest(
        url: apiUrl, params: params, header: headers, files: arrFile);
  }

  static FinalRequest requestParamsForSyncWithoutParam(ApiType type,
      {List<AppMultiPartFile> arrFile = const []}) {
    final String apiUrl = ApiConstant._baseDomain + ApiConstant.getValue(type);
    Map<String, String> headers = {
      'Content-Type': 'application/json', //'application/x-www-form-urlencoded'
    };

    print("Request Url :: $apiUrl");
    print("Request headers :: $headers");

    return FinalRequest(url: apiUrl, header: headers, files: arrFile);
  }

  static FinalRequest requestParamsForSyncWithoutParam2(
      ApiType type, String token,
      {List<AppMultiPartFile> arrFile = const []}) {
    final String apiUrl = ApiConstant._baseDomain + ApiConstant.getValue(type);
    Map<String, String> headers = {
      'Content-Type': 'application/json', //'application/x-www-form-urlencoded'
    };

    print("Request Url :: $apiUrl");
    print("Request headers :: $headers");

    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json' //'application/x-www-form-urlencoded'
        ,
        'Authorization': token
      };

      print("Request Url :: $apiUrl");
      print("Request headers :: $headers");

      return FinalRequest(url: apiUrl, header: headers, files: arrFile);
    } else {
      Map<String, String> headers = {
        'Content-Type': 'application/json' //'application/x-www-form-urlencoded'
      };

      print("Request Url :: $apiUrl");
      print("Request headers :: $headers");

      return FinalRequest(url: apiUrl, header: headers, files: arrFile);
    }
    // return FinalRequest(
    //     url: apiUrl,header: headers, files: arrFile);
  }

  static FinalRequest2 requestParamsForSyncWithHeader(ApiType type,
      {Map<String, dynamic> params,
      String token,
      List<AppMultiPartFile> arrFile = const []}) {
    final String apiUrl = ApiConstant._baseDomain + ApiConstant.getValue(type);

    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json' //'application/x-www-form-urlencoded'
        ,
        'Authorization': token
      };

      print("Request Url :: $apiUrl");
      print("Request Params :: $params");
      print("Request headers :: $headers");

      return FinalRequest2(
          url: apiUrl, params: params, header: headers, files: arrFile);
    } else {
      Map<String, String> headers = {
        'Content-Type': 'application/json' //'application/x-www-form-urlencoded'
      };

      print("Request Url :: $apiUrl");
      print("Request Params :: $params");
      print("Request headers :: $headers");

      return FinalRequest2(
          url: apiUrl, params: params, header: headers, files: arrFile);
    }
  }

  static FinalRequest2 requestGetParamsForSyncWithHeader(
    ApiType type, {
    Map<String, dynamic> params,
    String token,
  }) {
    final String apiUrl = ApiConstant._baseDomain + ApiConstant.getValue(type);

    Map<String, String> headers = {
      'Content-Type': 'application/json' //'application/x-www-form-urlencoded'
      ,
      'Authorization': token
    };

    print("Request Url :: $apiUrl");
    print("Request Params :: $params");
    print("Request headers :: $headers");

    return FinalRequest2(
      url: apiUrl,
      params: params,
      header: headers,
    );
  }

  static FinalRequest3 requestParamsForSyncWithHeaderWithoutParam(
    ApiType type,
    String token,
  ) {
    final String apiUrl = ApiConstant._baseDomain + ApiConstant.getValue(type);

    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json' //'application/x-www-form-urlencoded'
        ,
        'Authorization': token
      };

      print("Request Url :: $apiUrl");
      print("Request headers :: $headers");

      return FinalRequest3(
        url: apiUrl,
        header: headers,
      );
    } else {
      Map<String, String> headers = {
        'Content-Type': 'application/json' //'application/x-www-form-urlencoded'
      };

      print("Request Url :: $apiUrl");
      print("Request headers :: $headers");

      return FinalRequest3(
        url: apiUrl,
        header: headers,
      );
    }
  }
}

class HttpResponse {
  bool status;
  String errMessage;
  dynamic json;

  HttpResponse({this.status, this.errMessage, this.json});
}

class ResonseKeys {
  static String kMessage = 'message';
  static String kStatus = 'status';
  static String kToken = 'id_token';
  static String kId = 'id';
  static String kData = 'data';
}

class AppMultiPartFile {
  File localFile;
  String key;

  AppMultiPartFile({this.localFile, this.key});
}

class FinalRequest {
  String url;
  Map<String, dynamic> params;
  Map<String, String> header;
  List<AppMultiPartFile> files;

  FinalRequest({this.url, this.params, this.header, this.files});
}

class FinalRequest2 {
  String url;
  Map<String, dynamic> params;
  Map<String, String> header;
  List<AppMultiPartFile> files;

  FinalRequest2({this.url, this.params, this.header, this.files});
}

class FinalRequest3 {
  String url;
  Map<String, dynamic> params;
  Map<String, String> header;
  List<AppMultiPartFile> files;

  FinalRequest3({this.url, this.params, this.header, this.files});
}

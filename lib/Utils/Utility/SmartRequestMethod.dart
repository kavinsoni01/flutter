import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

/* Login Request Paramater*/
class LoginRequest {
  String email = '';
  String password = '';
  int deviceType = 0;
  String deviceToken = '';
  // String socialId = '';
  String udid = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.email;
    data['Password'] = this.password;
    data['deviceType'] = this.deviceType;
    data['deviceToken'] = this.deviceToken;
    // data['social_id'] = this.socialId;
    data['udId'] = this.udid;

    return data;
  }
}

class RequestForApproval {
  int userId = 0;
  String deviceToken = '';
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['UserId'] = this.userId;
    data['DeviceToken'] = this.deviceToken;

    return data;
  }
}

class AddChildRequest {
  int childrenId = 0;
  int userId = 0;
  String childName = '';
  int childGender = 0;
  int childAge = 0;
  String deviceToken = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['ChildrenId'] = this.childrenId;
    data['UserId'] = this.userId;
    data['ChildName'] = this.childName;
    data['ChildGender'] = this.childGender;
    data['ChildAge'] = this.childAge;
    data['DeviceToken'] = this.deviceToken;
    return data;
  }
}

class AddBusinessRequest {
  int serviceId = 0;
  int categoryId = 0;
  String title = '';
  String duration = '';
  String fromTime = '';
  String toTime = '';
  double price = 0;
  int numberOfSeat = 0;
  String address = '';
  String latitude = '23.0225';
  String longitude = '72.5714';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['Longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    data['ServiceId'] = this.serviceId;
    data['CategoryId'] = this.categoryId;
    data['Title'] = this.title;
    data['FromTime'] = this.fromTime;
    data['Duration'] = this.duration;
    data['ToTime'] = this.toTime;
    data['Price'] = this.price;
    data['NumberOfSeat'] = this.numberOfSeat;
    data['Address'] = this.address;

    return data;
  }
}

class CardRequest {
  int userId = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    return data;
  }
}

class BookingDateRequest {
  int serviceId = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ServiceId'] = this.serviceId;
    return data;
  }
}

class NotificationRequest {
  int userId = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    return data;
  }
}

class MyJobListRequest {
  int userId = 0;
  int pageNumber = 0;
  int pageSize = 0;
  String deviceToken = '';
  int serviceStatus = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['PageNumber'] = this.pageNumber;
    data['PageSize'] = this.pageSize;
    data['DeviceToken'] = this.deviceToken;
    data['ServiceStatus'] = this.serviceStatus;
    return data;
  }
}

class CancelEventRequest {
  int eventId = 0;
  String cancelReason = "";
  int language_id = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventId'] = this.eventId;
    data['CancelReason'] = this.cancelReason;
    data['language_id'] = this.language_id;
    return data;
  }
}

class ResetPasswordRequest {
  String newPassword = "";
  String currentPassword = "";
  int language_id = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new_password'] = this.newPassword;
    data['old_password'] = this.currentPassword;
    data['language_id'] = this.language_id;

    return data;
  }
}

class AlertSettingsRequest {
  int user_generate_event = 0;
  int machine_generate_event = 0;
  int isRSVPs = 0;
  int check_in_notifications = 0;
  int chats_notifications = 0;
  int new_time_proposed = 0;
  int event_change_notifications = 0;
  int event_feedback = 0;
  int language_id = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_generate_event'] = this.user_generate_event;
    data['machine_generate_event'] = this.machine_generate_event;
    data['RSVPs'] = this.isRSVPs;
    data['check_in_notifications'] = this.check_in_notifications;
    data['new_time_proposed'] = this.new_time_proposed;
    data['chats_notifications'] = this.chats_notifications;
    data['event_change_notifications'] = this.event_change_notifications;
    data['event_feedback'] = this.event_feedback;
    data['language_id'] = this.language_id;

    return data;
  }
}

class CheckInRequest {
  int eventId = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventId'] = this.eventId;

    return data;
  }
}

class UserRatingRequest {
  String opponent_user_id = "";
  String rating = "";
  String language_id = "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['opponent_user_id'] = this.opponent_user_id;
    data['language_id'] = this.language_id;
    return data;
  }
}

class CancelSocialRequest {
  String eventId = "";
  String notificationId = "";

//event/event_inviteduser_aprove
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventId'] = this.eventId;
    data['NotificationId'] = this.notificationId;
    return data;
  }
}

class UpdateSuggestionRequest {
  String eventId = "";
  String suggestedTime = "";

//event/event_inviteduser_aprove
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventId'] = this.eventId;
    data['SuggestedTime'] = this.suggestedTime;
    return data;
  }
}

class CreateEventTimeRequest {
  String eventId = "";
  String notificationId = "";

//event/event_inviteduser_aprove
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventId'] = this.eventId;
    data['NotificationId'] = this.notificationId;
    return data;
  }
}

class NewProposedTimeRequest {
  String eventDateTime = "";
  String eventId = "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SuggestedTime'] = this.eventDateTime;
    data['EventId'] = this.eventId;

    return data;
  }
}

class WeekEventRequest {
  String eventDate = "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.eventDate;
    return data;
  }
}

class FreeEventRequest {
  String language_id = "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.language_id;
    return data;
  }
}

class DiscoverListRequest {
  // String eventDate = "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['date'] = this.eventDate;

    return data;
  }
}

class EventListRequest {
  String searchKeyWord = "";
  String eventDate = "";
  String isMyEvents = '';
  int languageId = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search_key_word'] = this.searchKeyWord;
    data['event_date'] = this.eventDate;
    data['is_my_events'] = this.isMyEvents;
    data['language_id'] = this.languageId;

    return data;
  }
}

class EventDetailRequest {
  String event_id = "";

  int languageId = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.event_id;
    data['language_id'] = this.languageId;
    return data;
  }
}

// "event_id": "14",
// "sender_id": "9",
//   "receiver_id": "2",
//   "message": "hello all msg",
//   "language_id": 1

class SendMessageRequest {
  int languageId = 0;
  String event_id = "";
  String sender_id = '';
  String receiver_id = '';
  String message = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['event_id'] = this.event_id;
    data['sender_id'] = this.sender_id;
    data['receiver_id'] = this.receiver_id;
    data['message'] = this.message;
    data['language_id'] = this.languageId;

    return data;
  }
}

class ChatListRequest {
  int languageId = 0;
  String event_id = "";
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['event_id'] = this.event_id;
    data['language_id'] = this.languageId;

    return data;
  }
}

class NotificationListRequest {
  int languageId = 1;
  int duration = 1;
  String start_date = "";
  String end_date = "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['language_id'] = this.languageId;
    data['duration'] = this.duration;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;

    return data;
  }
}

class PickupInvitationCardRequest {
  String eventId = "";
  String inappPurchaseId = "";
  String amount = '';
  bool isFree = false;
  String periodStart = "";
  String periodEnd = "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventId'] = this.eventId;
    data['InappPurchaseId'] = this.inappPurchaseId;
    data['Amount'] = this.amount;
    data['IsFree'] = this.isFree;
    data['PeriodStart'] = this.periodStart;
    data['PeriodEnd'] = this.periodEnd;

//    DATA
    return data;
  }
}

class AddedBusinessRequest {
  int userId = 0;
  int pageNumber = 0;
  int pageSize = 0;
  String deviceToken = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['PageNumber'] = this.pageNumber;
    data['PageSize'] = this.pageSize;
    data['DeviceToken'] = this.deviceToken;

    return data;
  }
}

class AcceptAllRequest {
  int UserId = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.UserId;

    return data;
  }
}

class ChildListRequest {
  int userId = 0;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;

    return data;
  }
}

class PaymentModeRequest {
  int userId = 0;
  int serviceId = 0;
  List<int> childs = [];
  //String childs = '';
  //  int childs = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['ServiceId'] = this.serviceId;
    data['Childs'] = this.childs;

    return data;
  }
}

class SubmitBookingRequest {
  int userId = 0;
  int serviceId = 0;
  List<int> childs = [];
  int userPaymentCardId = 0;
  int noOfChild = 0;
  String dateOfJoin = '';
  String classTime = '';

  //String childs = '';
  //  int childs = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['ServiceId'] = this.serviceId;
    data['Childs'] = this.childs;

    return data;
  }
}

class SPPaymentListRequest {
  int userId = 0;
  int reportType = 0;
  String startDate = '';
  String endDate = '';
  int month = 0;
  int year = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['ReportType'] = this.reportType;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['Month'] = this.month;
    data['Year'] = this.year;

    return data;
  }
}

class MyBookingListRequest {
  int userId = 0;
  int serviceStatus = 0;
  int pageSize = 50;
  int pageNumber = 0;
  String deviceToken = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['ServiceStatus'] = this.serviceStatus;
    data['PageNumber'] = this.pageNumber;
    data['PageSize'] = this.pageSize;
    data['DeviceToken'] = this.deviceToken;

    return data;
  }
}

class BusinessListRequest {
  int categoryid = 0;
  String searchText = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoryId'] = this.categoryid;
    data['SearchText'] = this.searchText;

    return data;
  }
}

class ServiceProviderDetailRequest {
  int serviceId = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ServiceId'] = this.serviceId;

    return data;
  }
}

/* Login Request Paramater*/
class LoginCheckRequest {
  String email = '';
  String password = '';
  String language_id = "1";
  String device_type = "1";
  String device_token = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['device_token'] = this.device_token;
    data['language_id'] = this.language_id;
    data['device_type'] = this.device_type;

    return data;
  }
}

class ForgotPasswordRequest {
  String email = '';
  String languageId = "1";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['language_id'] = this.languageId;

    return data;
  }
}

class CreateEventRequest {
  String title = '';
  String description = '';
  String date = '';
  String activityTagIDs = '';
  String invitedUserIDs = '';
  String age = "";
  String devicetype = '0';
  String longititude;
  String latitude;
  String gendars = '';
  String location = '';
  String joinUserLimit = '';
  // List<int> profession = [];
  // List<int> generation = [];
  String income;

  // List<int> earning = [];
  // List<int> likes = [];
  String cardId = '3';
  String languageId = '1';
  String eventType = '2';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Date'] = this.date;
    data['Lat'] = this.latitude;
    data['Long'] = this.longititude;
    data['ActivityTagIDs'] = this.activityTagIDs;
    data['InvitedUserIDs'] = this.invitedUserIDs;
    data['Age'] = this.age;
    data['Gendars'] = this.gendars;
    // data['ProfileImage'] = this.profileimage;
    data['Income'] = this.income;
    data['language_id'] = languageId;
    data['CardId'] = this.cardId;
    data['EventType'] = eventType;
    data['Location'] = location;
    data['JoinUserLimit'] = joinUserLimit;

    return data;
  }
}

// class UpdateProfileRequest {

// }
class GetBedgeRequest {
  int eventId = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['event_id'] = this.eventId;
    return data;
  }
}

class UpdateProfileRequest {
  String email = '';
  String name = '';
  String city = '';
  // String password = '';
  String postalCode = '';
  String deviceToken = "";
  String udid = "9A331063-329F-4E08-AFC2-D12EF4C88E99";
  String devicetype = '0';
  String longititude;
  String latitude;
  String distance = '0';
  String gender = '';
  // Map<String, String> dictSocial;
  String facebookLink = '';
  String linkedinLink = '';
  String instagramLink = '';
  int is_new;
  // List<int> profession = [];
  // List<int> generation = [];
  String generation;
  String profession;
  String earning;
  String likes;

  // List<int> earning = [];
  // List<int> likes = [];
  String meet = '';
  String languageId = '0';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['City'] = this.city;
    data['Name'] = this.name;
    data['Email'] = this.email;
    // data['Password'] = this.password;
    data['DeviceToken'] = this.deviceToken;
    data['PostalCode'] = this.postalCode;
    data['udId'] = this.udid;
    data['DeviceType'] = this.devicetype;
    data['Latitude'] = this.latitude;
    data['Longititude'] = this.longititude;
    data['Distance'] = this.distance;
    data['Gender'] = this.gender;
    // data['ProfileImage'] = this.profileimage;
    data['Profession'] = this.profession;
    data['Generation'] = this.generation;
    data['Earning'] = this.earning;
    data['likes'] = this.likes;
    data['Meet'] = this.meet;
    data['language_id'] = this.languageId;
    data['facebook_url'] = this.facebookLink;
    data['instagram__url'] = this.instagramLink;
    data['linkedln__url'] = this.linkedinLink;
    data['is_new'] = this.is_new;

    return data;
  }
}

class NewUpdateProfileRequest {
  String email = '';
  String name = '';
  String city = '';
  // String password = '';
  String postalCode = '';
  String deviceToken = "";
  // String udid = "9A331063-329F-4E08-AFC2-D12EF4C88E99";
  // String devicetype = '0';
  // String longititude;
  // String latitude;
  String distance = '0';
  String gender = '';
  // Map<String, String> dictSocial;
  // String facebookLink = '';
  // String linkedinLink = '';
  // String instagramLink = '';
  int is_new;
  // List<int> profession = [];
  // List<int> generation = [];
  String generation;
  String profession;
  String earning;
  String likes;

  // List<int> earning = [];
  // List<int> likes = [];
  String meet = '';
  String languageId = '0';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['City'] = this.city;
    data['Name'] = this.name;
    data['Email'] = this.email;
    // data['Password'] = this.password;
    data['DeviceToken'] = this.deviceToken;
    data['PostalCode'] = this.postalCode;
    //  data['udId'] = this.udid;
    // data['DeviceType'] = this.devicetype;
    // data['Latitude'] = this.latitude;
    // data['Longititude'] = this.longititude;
    data['Distance'] = this.distance;
    data['Gender'] = this.gender;
    // data['ProfileImage'] = this.profileimage;
    data['Profession'] = this.profession;
    data['Generation'] = this.generation;
    data['Earning'] = this.earning;
    data['likes'] = this.likes;
    data['Meet'] = this.meet;
    data['language_id'] = this.languageId;
    // data['facebook_url'] = this.facebookLink;
    // data['instagram__url'] = this.instagramLink;
    // data['linkedln__url'] = this.linkedinLink;
    data['is_new'] = this.is_new;

    return data;
  }
}

class RegisterRequestNew {
  String email = '';
  String name = '';
  String city = '';
  String password = '';
  String postalCode = '';
  String deviceToken = "";
  String udid = "9A331063-329F-4E08-AFC2-D12EF4C88E99";
  String devicetype = '0';
  String longititude;
  String latitude;
  String languageId = '0';
  int is_new = 1;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['City'] = this.city;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['DeviceToken'] = this.deviceToken;
    data['PostalCode'] = this.postalCode;
    // data['udId'] = this.udid;
    data['DeviceType'] = this.devicetype;
    data['Latitude'] = this.latitude;
    data['Longititude'] = this.longititude;
    data['language_id'] = this.languageId;
    data['is_new'] = this.is_new;

    return data;
  }
}

class SendOTPRequest {
  String userName = '';
  String deviceToken = '';
  int deviceType = 0;
  String udId = '';
  int userType = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['deviceToken'] = this.deviceToken;
    data['deviceType'] = this.deviceType;
    data['udId'] = this.udId;
    data['UserType'] = this.userType;

    return data;
  }
}

class VarifyOTPRequest {
  String userName = '';
  String deviceToken = '';
  int deviceType = 0;
  String udId = '';
  String otp = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['deviceToken'] = this.deviceToken;
    data['deviceType'] = this.deviceType;
    data['udId'] = this.udId;
    data['otp'] = this.otp;
    return data;
  }
}

class ForgotpasswordRequest {
  String email = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmailAddress'] = this.email;
    return data;
  }
}

class DashboardRequest {
  String api_access_token = '';
  String type = '';
  String longitude = '';
  String distance = '';
  String event_type = '';
  String page_number = '';
  String pagesize = '';
  String search_keyword = '';
  String search_preferences = '';
  String event_date = '';
  String latitude = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_access_token'] = this.api_access_token;
    data['type'] = this.type;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['distance'] = this.distance;
    data['event_type'] = this.event_type;
    data['page_number'] = this.page_number;
    data['pagesize'] = this.pagesize;
    data['search_keyword'] = this.search_keyword;
    data['search_preferences'] = this.search_preferences;
    data['event_date'] = this.event_date;
    return data;
  }
}

class FavouriteRequest {
  String api_access_token = '';
  String type = '';
  String page_number = '';
  String pagesize = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_access_token'] = this.api_access_token;
    data['type'] = this.type;
    data['page_number'] = this.page_number;
    data['pagesize'] = this.pagesize;
    return data;
  }
}

class AddRemoveFavouriteRequest {
  String api_access_token = '';
  String type = '';
  String event_or_club_id = '';
  String is_favourite = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_access_token'] = this.api_access_token;
    data['type'] = this.type;
    data['event_or_club_id'] = this.event_or_club_id;
    data['is_favourite'] = this.is_favourite;
    return data;
  }
}

class BuzzRequest {
  String api_access_token = '';
  String type = '';
  String page_number = '';
  String pagesize = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_access_token'] = this.api_access_token;
    data['type'] = this.type;
    data['page_number'] = this.page_number;
    data['pagesize'] = this.pagesize;
    return data;
  }
}

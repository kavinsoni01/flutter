//region SignUpResponse + Login Response

import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/ModelClass.dart';

class UserAuthenticationResponse {
  bool status;
  String message;
/*  User user;
  UserAuthenticationResponse({this.status, this.message, this.user});*/
}

class LoginCheckResponse {
  bool status;
  String message;
  UserModel userModel;

  LoginCheckResponse({this.status, this.message, this.userModel}); //
}

class MainDataResponse {
  bool status;
  String message;
  AllDataModel dataModel;

  MainDataResponse(
      {this.status, this.message, this.dataModel}); //, this.userModel}); //
}

class CMSDataResponse {
  bool status;
  String message;
  List<CMSModel> dataModel;

  CMSDataResponse(
      {this.status, this.message, this.dataModel}); //, this.userModel}); //
}

class BadgeResponse {
  bool status;
  String message;
  String social;
  int alert;
  int discover;

  BadgeResponse(
      {this.status,
      this.message,
      this.social,
      this.discover,
      this.alert}); //, this.userModel}); //
}

class ForgotPasswordResponse {
  bool status;
  String message;

  ForgotPasswordResponse({
    this.status,
    this.message,
  }); //
}

class RegisterResponse {
  bool status;
  String message;
  UserModel userModel;

  RegisterResponse({
    this.status,
    this.message,
    this.userModel,
  }); //
}

class UpdateProfileResponse {
  bool status;
  String message;
  UserModel userModel;
  UpdateProfileResponse({this.status, this.message, this.userModel}); //
}

class PickupInvitationResponse {
  bool status;
  String message;

  PickupInvitationResponse({this.status, this.message}); //
}

class CreateEventResponse {
  bool status;
  String message;
  EventId eventData;
  CreateEventResponse({this.status, this.message, this.eventData}); //
}

class DiscoverEventListResponse {
  bool status;
  String message;
  List<EventList> eventList;

  DiscoverEventListResponse({this.status, this.message, this.eventList}); //
}

class NotificationListResponse {
  bool status;
  String message;
  List<NotificationList> notifications;

  NotificationListResponse({this.status, this.message, this.notifications}); //
}

class EvenDetailResponse {
  bool status;
  String message;
  EventList event;

  EvenDetailResponse({this.status, this.message, this.event}); //
}

class EventListResponse {
  bool status;
  String message;
  List<EventList> eventList;

  EventListResponse({this.status, this.message, this.eventList}); //
}

class ChatListResponse {
  bool status;
  String message;
  List<ChatMessage> chatList;

  ChatListResponse({this.status, this.message, this.chatList}); //
}

class SendChatResponse {
  bool status;
  String message;

  SendChatResponse({
    this.status,
    this.message,
  }); //
}

class WeekEventResponse {
  bool status;
  String message;
  List<EventDateList> dateTime;

  WeekEventResponse({this.status, this.message, this.dateTime}); //
}

class FreeEventResponse {
  bool status;
  String message;
  int isAllow;
  FreeEventResponse({this.status, this.message, this.isAllow}); //
}

class DeleteAccoundResponse {
  bool status;
  String message;

  DeleteAccoundResponse({this.status, this.message}); //
}

class EventProposedNewTimeResponse {
  bool status;
  String message;

  EventProposedNewTimeResponse({this.status, this.message}); //
}

class CheckInEventListResponse {
  bool status;
  String message;
  // List<EventList> eventList;

  CheckInEventListResponse({this.status, this.message}); //
}

class RatingResponse {
  bool status;
  String message;
  // List<EventList> eventList;

  RatingResponse({this.status, this.message}); //
}

class AttendNotificationResponse {
  bool status;
  String message;
  // List<EventList> eventList;

  AttendNotificationResponse({this.status, this.message}); //

}

class NotificationSettingResponse {
  bool status;
  String message;
  NotificationSettings settingModel;

  NotificationSettingResponse(
      {this.status, this.message, this.settingModel}); //
}

class CancelEventResponse {
  bool status;
  String message;

  CancelEventResponse({this.status, this.message}); //
}

class ResetPasswordResponse {
  bool status;
  String message;

  ResetPasswordResponse({this.status, this.message}); //
}

class InvitationCardDataResponse {
  bool status;
  String message;
  // dataModel;
  List<InvitationCardModel> invitationList;

  InvitationCardDataResponse({
    this.status,
    this.message,
    this.invitationList,
  }); //, this.userModel}); //
}
// class DashboardResponse {
//   bool status;
//   String message;
//   Dashboard dashboard;

//   DashboardResponse({this.status, this.message, this.dashboard});
// }

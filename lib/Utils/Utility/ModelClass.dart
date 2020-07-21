import 'dart:convert';

import 'package:simposi/Utils/Models/AppDataModel.dart';

UserModel loginResponseFromJson(dynamic str) {
  final jsonData = json.decode(str);
  return UserModel.fromJson(jsonData);
}

NotificationSettings notificationResponseFromJson(dynamic str) {
  // final jsonData = json.decode(str);
  return NotificationSettings.fromJson(str);
}

EventId eventIdResponseFromJson(dynamic str) {
  final jsonData = json.decode(str);
  return EventId.fromJson(jsonData);
}

AllDataModel allDataResponseFromJson(dynamic str) {
  // final jsonData = json.decode(str);
  return AllDataModel.fromJson(str);
}

InvitationCardModel invitationCardResponseFromJson(dynamic str) {
  // final jsonData = json.decode(str);
  return InvitationCardModel.fromJson(str);
}

class UserModel {
  int status;
  // Data data;
  String message;
  String email;
  int userId;
  int userRoleId;
  String userName;
  String phone;
  String profilePhoto;
  String city;
  String postalcode;
  String gender;
  int distance;
  String latitude;
  String longitude;
  String apiAccessToken;
  int active;
  int deviceType;
  String deviceToken;
  String meet;
  int is_registration_incompleted;
  String facebookUrl;
  String instagramUrl;
  String linkedinUrl;

  String location;
  // List<Profession> profession = [];
  List<String> profession = [];
  List<String> generationIdentify = [];
  List<String> wantToMeet = [];
  List<String> interest = [];
  List<String> whoEarn = [];

  List<String> professionTitle = [];
  List<String> generationIdentifyTitle = [];
  List<String> wantToMeetTitle = [];
  List<String> interestTitle = [];
  List<String> whoEarnTitle = [];

  // List<GenerationIdentify> generationIdentify = [];
  // List<WantToMeet> wantToMeet = [];
  // List<WhoEarn> whoEarn;
  // List<Interest> interest = [];

  // Map<String, dynamic> profession;

  int member = 0;

  UserModel({this.status, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // var data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    Map<String, dynamic>
        user; //  user = json['user'] != null ? new Data.fromJson(json['user']) : null;

    if (json['data'] != null) {
      user = json['data'];
    }
    if (json['location'] != null) {
      location = json['location'];
    }
    if (user != null) {
      if (user['email'] != null) {
        email = user['email'];
      }
      if (user['user_id'] != null) {
        userId = user['user_id'];
      }
      if (user['user_role_id'] != null) {
        userRoleId = user['user_role_id'];
      }

      if (user['is_registration_incompleted'] != null) {
        is_registration_incompleted = user['is_registration_incompleted'];
      }

      if (user['user_name'] != null) {
        userName = user['user_name'];
      }

      if (user['phone'] != null) {
        phone = user['phone'];
      }

      if (user['profile_photo'] != null) {
        profilePhoto = user['profile_photo'];
      }

      if (user['city'] != null) {
        city = user['city'];
      }

      if (user['postal_code'] != null) {
        postalcode = user['postal_code'];
      }

      if (user['gender'] != null) {
        gender = user['gender'];
      }

      if (user['distance'] != null) {
        distance = user['distance'];
      }

      if (user['latitude'] != null) {
        latitude = user['latitude'];
      }
      if (user['longitude'] != null) {
        longitude = user['longitude'];
      }

      if (user['apiAccessToken'] != null) {
        apiAccessToken = user['apiAccessToken'];
      }

      if (user['active'] != null) {
        active = user['active'];
      }

      if (user['device_type'] != null) {
        deviceType = user['device_type'];
      }

      if (user['device_token'] != null) {
        deviceToken = user['device_token'];
      }

      if (user['meet'] != null) {
        meet = user['meet'];
      }

      if (user['member'] != null) {
        member = user['member'];
      }

      if (user['facebook_url'] != null) {
        facebookUrl = user['facebook_url'];
      }

      if (user['instagram__url'] != null) {
        instagramUrl = user['instagram__url'];
      }

      if (user['linkedln__url'] != null) {
        linkedinUrl = user['linkedln__url'];
      }

      if (user['profession'] != null) {
        List arr = user['profession'];
        arr.forEach((element) {
          var model = new Profession.fromJson(element);
          profession.add(model.professionId.toString());
          professionTitle.add(model.title);
        });
      }

      if (user['what_you_like'] != null) {
        // user['profession'];
        // profession = json.encode(user['profession']);

        List arr = user['what_you_like'];
        arr.forEach((element) {
          var model = new Interest.fromJson(element);
          interest.add(model.whatYouLikeId.toString());
          interestTitle.add(model.title);
        });
      }

      if (user['whoEarn'] != null) {
        // user['profession'];
        // profession = json.encode(user['profession']);

        List arr = user['whoEarn'];
        arr.forEach((element) {
          var model = new WhoEarn.fromJson(element);
          whoEarn.add(model.whoEarnsId.toString());
          whoEarnTitle.add(model.title);
        });
      }

      if (user['generations'] != null) {
        List arr = user['generations'];
        arr.forEach((element) {
          var model = new GenerationIdentify.fromJson(element);
          generationIdentify.add(model.generationsIdentifyId.toString());
          generationIdentifyTitle.add(model.title);
        });
      }
    } else {
      if (json != null) {
        if (json['email'] != null) {
          email = json['email'];
        }
        if (json['user_id'] != null) {
          userId = json['user_id'];
        }
        if (json['user_role_id'] != null) {
          userRoleId = json['user_role_id'];
        }

        if (json['is_registration_incompleted'] != null) {
          is_registration_incompleted = json['is_registration_incompleted'];
        }

        if (json['user_name'] != null) {
          userName = json['user_name'];
        }

        if (json['phone'] != null) {
          phone = json['phone'];
        }

        if (json['profile_photo'] != null) {
          profilePhoto = json['profile_photo'];
        }

        if (json['city'] != null) {
          city = json['city'];
        }

        if (json['postal_code'] != null) {
          postalcode = json['postal_code'];
        }

        if (json['gender'] != null) {
          gender = json['gender'];
        }

        if (json['distance'] != null) {
          distance = json['distance'];
        }

        if (json['latitude'] != null) {
          latitude = json['latitude'];
        }
        if (json['longitude'] != null) {
          longitude = json['longitude'];
        }

        if (json['apiAccessToken'] != null) {
          apiAccessToken = json['apiAccessToken'];
        }

        if (json['active'] != null) {
          active = json['active'];
        }

        if (json['device_type'] != null) {
          deviceType = json['device_type'];
        }

        if (json['device_token'] != null) {
          deviceToken = json['device_token'];
        }

        if (json['meet'] != null) {
          meet = json['meet'];
        }

        if (json['member'] != null) {
          member = json['member'];
        }

        if (json['facebook_url'] != null) {
          facebookUrl = json['facebook_url'];
        }

        if (json['instagram__url'] != null) {
          instagramUrl = json['instagram__url'];
        }

        if (json['linkedln__url'] != null) {
          linkedinUrl = json['linkedln__url'];
        }

        if (json['profession'] != null) {
          List arr = json['profession'];
          arr.forEach((element) {
            var model = new Profession.fromJson(element);
            profession.add(model.professionId.toString());
            professionTitle.add(model.title);
          });
        }

        if (json['what_you_like'] != null) {
          // json['profession'];
          // profession = json.encode(json['profession']);

          List arr = json['what_you_like'];
          arr.forEach((element) {
            var model = new Interest.fromJson(element);
            interest.add(model.whatYouLikeId.toString());
            interestTitle.add(model.title);
          });
        }
        if (json['whoEarn'] != null) {
          // user['profession'];
          // profession = json.encode(user['profession']);

          List arr = json['whoEarn'];
          arr.forEach((element) {
            var model = new WhoEarn.fromJson(element);
            whoEarn.add(model.whoEarnsId.toString());
            whoEarnTitle.add(model.title);
          });
        }
        if (json['generations'] != null) {
          List arr = json['generations'];
          arr.forEach((element) {
            var model = new GenerationIdentify.fromJson(element);
            generationIdentify.add(model.generationsIdentifyId.toString());
            generationIdentifyTitle.add(model.title);
          });
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    // if (this.data != null) {
    //   data['data'] = this.data.toJson();
    // }
    data['message'] = this.message;
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['user_role_id'] = this.userRoleId;
    data['user_name'] = this.userName;
    data['phone'] = this.phone;
    data['profile_photo'] = this.profilePhoto;
    data['city'] = this.city;
    data['postal_code'] = this.postalcode;
    data['gender'] = this.gender;
    data['distance'] = this.distance;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['apiAccessToken'] = this.apiAccessToken;
    data['active'] = this.active;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['meet'] = this.meet;

    return data;
  }
}

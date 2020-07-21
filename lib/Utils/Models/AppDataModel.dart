import 'package:intl/intl.dart';

class InvitationCardModel {
  int invitation_card_id = 0;
  String title = "";
  String backgroundimage = "";
  int font_size = 0;
  String font_colour = "";
  int width = 0;
  int height = 0;
  int price = 0;
  int active = 0;
  bool isSelected = false;

  // InvitationCardModel({this.generationIdentify,});

  InvitationCardModel.fromJson(Map<String, dynamic> newData) {
    if (newData['invitation_card_id'] != null) {
      invitation_card_id = newData['invitation_card_id'];
    }

    if (newData['title'] != null) {
      title = newData['title'];
    }

    if (newData['backgroundimage'] != null) {
      backgroundimage = newData['backgroundimage'];
    }

    if (newData['font_size'] != null) {
      font_size = newData['font_size'];
    }

    if (newData['font_colour'] != null) {
      font_colour = newData['font_colour'];
    }

    if (newData['height'] != null) {
      height = newData['height'];
    }

    if (newData['width'] != null) {
      width = newData['width'];
    }

    if (newData['price'] != null) {
      price = newData['price'];
    }

    if (newData['active'] != null) {
      active = newData['active'];
    }
  }
}

class NotificationSettings {
  var setting_id;
  var user_id;
  var user_generate_event;
  var machine_generate_event;
  var isRSVPs;
  var check_in_notifications;
  var chats_notifications;
  var new_time_proposed;
  var event_change_notifications;
  var event_feedback;

  NotificationSettings.fromJson(Map<String, dynamic> newData) {
    if (newData['setting_id'] != null) {
      setting_id = newData['setting_id'];
    }

    if (newData['user_id'] != null) {
      user_id = newData['user_id'];
    }

    if (newData['user_generate_event'] != null) {
      user_generate_event = newData['user_generate_event'];
    }

    if (newData['machine_generate_event'] != null) {
      machine_generate_event = newData['machine_generate_event'];
    }
    if (newData['RSVPs'] != null) {
      isRSVPs = newData['RSVPs'];
    }
    if (newData['check_in_notifications'] != null) {
      check_in_notifications = newData['check_in_notifications'];
    }

    if (newData['chats_notifications'] != null) {
      chats_notifications = newData['chats_notifications'];
    }

    if (newData['new_time_proposed'] != null) {
      new_time_proposed = newData['new_time_proposed'];
    }

    if (newData['event_change_notifications'] != null) {
      event_change_notifications = newData['event_change_notifications'];
    }

    if (newData['event_feedback'] != null) {
      event_feedback = newData['event_feedback'];
    }
  }
}

class EventId {
  var eventId;

  EventId.fromJson(Map<String, dynamic> newData) {
    if (newData['EventId'] != null) {
      eventId = newData['EventId'];
    }
  }
}

class GenderModel {
  int isLGBTQ = 0;
  int isMale = -1;

  GenderModel({this.isMale, this.isLGBTQ});
}

class AllDataModel {
  List<GenerationIdentify> generationIdentify;
  List<Profession> profession;
  List<WantToMeet> wantToMeet;
  List<WhoEarn> whoEarn;
  List<Interest> interest;

  AllDataModel({
    this.generationIdentify,
    this.profession,
    this.wantToMeet,
  });

  AllDataModel.fromJson(Map<String, dynamic> newData) {
    Map<String, dynamic>
        json; //  user = json['user'] != null ? new Data.fromJson(json['user']) : null;

    if (newData['data'] != null) {
      json = newData['data'];

      if (json['whoEarn'] != null) {
        whoEarn = new List<WhoEarn>();
        json['whoEarn'].forEach((v) {
          whoEarn.add(new WhoEarn.fromJson(v));
        });
      }

      if (json['interest'] != null) {
        interest = new List<Interest>();
        json['interest'].forEach((v) {
          interest.add(new Interest.fromJson(v));
        });
      }

      if (json['generationIdentify'] != null) {
        generationIdentify = new List<GenerationIdentify>();
        json['generationIdentify'].forEach((v) {
          generationIdentify.add(new GenerationIdentify.fromJson(v));
        });
      }

      if (json['profession'] != null) {
        profession = new List<Profession>();
        json['profession'].forEach((v) {
          profession.add(new Profession.fromJson(v));
        });
      }

      if (json['wantToMeet'] != null) {
        wantToMeet = new List<WantToMeet>();
        json['wantToMeet'].forEach((v) {
          wantToMeet.add(new WantToMeet.fromJson(v));
        });
      }
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.generationIdentify != null) {
  //     data['generationIdentify'] =
  //         this.generationIdentify.map((v) => v.toJson()).toList();
  //   }
  //   if (this.notSubscribeClub != null) {
  //     data['not_subscribe_club'] =
  //         this.notSubscribeClub.map((v) => v.toJson()).toList();
  //   }
  //   data['total_count'] = this.totalCount;
  //   return data;
  // }
}

// class CMSDataModel {

//   List<CMSModel> arrCMS;

//   CMSDataModel({this.arrCMS,});

//   CMSDataModel.fromJson(Map<String, dynamic> newData) {

//     Map<String, dynamic> json; //  user = json['user'] != null ? new Data.fromJson(json['user']) : null;

//   //  if (newData['data'] != null){
//   //       json = newData['data'];

//   //     if (json['whoEarn'] != null) {
//   //       whoEarn = new List<WhoEarn>();
//   //     json['whoEarn'].forEach((v) {
//   //       whoEarn.add(new WhoEarn.fromJson(v));
//   //     });
//   //   }

//   if (json['interest'] != null) {
//         interest = new List<Interest>();
//       json['interest'].forEach((v) {
//         interest.add(new Interest.fromJson(v));
//       });
//     }

//   }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   if (this.generationIdentify != null) {
//     data['generationIdentify'] =
//         this.generationIdentify.map((v) => v.toJson()).toList();
//   }
//   if (this.notSubscribeClub != null) {
//     data['not_subscribe_club'] =
//         this.notSubscribeClub.map((v) => v.toJson()).toList();
//   }
//   data['total_count'] = this.totalCount;
//   return data;
// }
// }

class CMSModel {
  int cms_id = 0;
  String cms_title = '';
  String cms_description = '';
  int cms_status = 0;
  String created_date = '';

  CMSModel.fromJson(Map<String, dynamic> json) {
    if (json['cms_id'] != null) {
      cms_id = json['cms_id'];
    }

    if (json['cms_title'] != null) {
      cms_title = json['cms_title'];
    }
    if (json['cms_status'] != null) {
      cms_status = json['cms_status'];
    }
    if (json['cms_description'] != null) {
      cms_description = json['cms_description'];
    }

    if (json['created_date'] != null) {
      created_date = json['created_date'];
    }
  }
}

class GenerationIdentify {
  int generationsIdentifyId = 0;
  String title = '';
  int status = 0;
  bool isSelected = false;

  GenerationIdentify.fromJson(Map<String, dynamic> json) {
    if (json['generations_identify_id'] != null) {
      generationsIdentifyId = json['generations_identify_id'];
    }

    if (json['title'] != null) {
      title = json['title'];
    }

    if (json['status'] != null) {
      status = json['status'];
    }
  }
}

class Profession {
  int professionId = 0;
  String title = '';
  int status = 0;
  bool isSelected = false;

  Profession.fromJson(Map<String, dynamic> json) {
    if (json['profession_id'] != null) {
      professionId = json['profession_id'];
    }

    if (json['title'] != null) {
      title = json['title'];
    }

    if (json['status'] != null) {
      status = json['status'];
    }
  }
}

class WantToMeet {
  int iWantToMeetId = 0;
  String title = '';
  int status = 0;
  bool isSelected = false;

  WantToMeet.fromJson(Map<String, dynamic> json) {
    if (json['i_want_to_meet_id'] != null) {
      iWantToMeetId = json['i_want_to_meet_id'];
    }

    if (json['title'] != null) {
      title = json['title'];
    }

    if (json['status'] != null) {
      status = json['status'];
    }
  }
}

class OtherTime {
  String date = '';

  OtherTime.fromJson(Map<String, dynamic> json) {
    if (json['date'] != null) {
      date = json['date'];
    }
  }
}

class WhoIsGoingTo {
  int user_count = 0;
  String gender = '';

  WhoIsGoingTo.fromJson(Map<String, dynamic> json) {
    if (json['gender'] != null) {
      gender = json['gender'];
    }

    if (json['user_count'] != null) {
      user_count = json['user_count'];
    }
  }
}

class WhoEarn {
  int whoEarnsId = 0;
  String title = '';
  int status = 0;
  bool isSelected = false;

  WhoEarn.fromJson(Map<String, dynamic> json) {
    if (json['who_earns_id'] != null) {
      whoEarnsId = json['who_earns_id'];
    }

    if (json['title'] != null) {
      title = json['title'];
    }

    if (json['status'] != null) {
      status = json['status'];
    }
  }
}

class ImagesModel {
  int event_image_id = 0;
  int event_id = 0;
  String image = "";

  ImagesModel.fromJson(Map<String, dynamic> json) {
    if (json['event_image_id'] != null) {
      event_image_id = json['event_image_id'];
    }

    if (json['event_id'] != null) {
      event_id = json['event_id'];
    }

    if (json['image'] != null) {
      image = json['image'];
    }
  }
}

class Interest {
  int whatYouLikeId = 0;
  String title = '';
  int status = 0;
  bool isSelected = false;
  Interest.fromJson(Map<String, dynamic> json) {
    if (json['what_you_like_id'] != null) {
      whatYouLikeId = json['what_you_like_id'];
    }

    if (json['title'] != null) {
      title = json['title'];
    }

    if (json['status'] != null) {
      status = json['status'];
    }
  }
}

class EventDateList {
  String date = '';

  EventDateList.fromJson(Map<String, dynamic> json) {
    if (json['event_date'] != null) {
      date = json['event_date'];
    }
  }
}

class EventList {
  String eventTime = '';
  String eventDate = '';
  String eventMonth = '';
  String eventDay = '';

  String title = '';
  int event_id = 0;
  int user_id = 0;
  String description = '';
  bool isSelected = false;
  bool is_my_event = false;
  String location = '';
  double latitude = 00;
  double longitude = 00;
  String event_date = '';
  String social_name = '';
  String gender_and_income = '';
  String age = '';
  int status = 1;
  String cancel_reason = '';
  int card_id = 1;
  int event_type = 1;
  String user_name = '';
  String email = '';
  String phone = '';
  String profile_photo = '';
  String gender = '';
  int member = 0;
  int distance = 0;

  List<GenerationIdentify> generationIdentify;
  List<Profession> profession;
  List<WantToMeet> wantToMeet;
  List<WhoEarn> whoEarn;
  List<Interest> interest;
  List<ImagesModel> imagesModel;

  String generationIdentifyString = '';
  String wantToMeetString = '';
  String professionString = '';
  String interestString = '';

  String totalUnacceptedEventCount = '';
  List<OtherTime> event_suggested_times;
  List<WhoIsGoingTo> whoIsGointTo;
  String whoIsGointToString = '';
  String otherTime1 = '';
  String otherTime2 = '';

  EventList(
      {this.generationIdentify,
      this.profession,
      this.wantToMeet,
      this.imagesModel});

  EventList.fromJson(Map<String, dynamic> json) {
    // Map<String, dynamic> json; //  user = json['user'] != null ? new Data.fromJson(json['user']) : null;

    //  if (newData['data'] != null){
    // json = newData['data'];
    if (json['event_suggested_times'] != null) {
      event_suggested_times = new List<OtherTime>();
      json['event_suggested_times'].forEach((v) {
        event_suggested_times.add(new OtherTime.fromJson(v));
      });
    }

    if (json['who_is_going_to'] != null) {
      whoIsGointTo = new List<WhoIsGoingTo>();
      whoIsGointToString = "";

      json['who_is_going_to'].forEach((v) {
        var going = new WhoIsGoingTo.fromJson(v);
        whoIsGointTo.add(going);
        whoIsGointToString = whoIsGointToString +
            going.user_count.toString() +
            ' ' +
            going.gender +
            ' ';
      });
    }

    if (json['whoEarn'] != null) {
      whoEarn = new List<WhoEarn>();
      json['whoEarn'].forEach((v) {
        whoEarn.add(new WhoEarn.fromJson(v));
      });
    }

    if (json['eventimages'] != null) {
      imagesModel = new List<ImagesModel>();
      json['eventimages'].forEach((v) {
        imagesModel.add(new ImagesModel.fromJson(v));
      });
    }

    if (json['what_you_like'] != null) {
      interest = new List<Interest>();
      interestString = '';
      json['what_you_like'].forEach((v) {
        var intrestArr = new Interest.fromJson(v);
        interest.add(intrestArr);
        interestString = interestString + intrestArr.title + ', ';
      });
    }

    if (json['generations_identify'] != null) {
      generationIdentify = new List<GenerationIdentify>();

      generationIdentifyString = '';

      json['generations_identify'].forEach((v) {
        var generation = new GenerationIdentify.fromJson(v);
        generationIdentify.add(generation);
        generationIdentifyString =
            generationIdentifyString + generation.title + ', ';
      });
    }

    if (json['profession'] != null) {
      profession = new List<Profession>();
      professionString = '';
      json['profession'].forEach((v) {
        var proffesion = new Profession.fromJson(v);
        profession.add(proffesion);
        professionString = professionString + proffesion.title + ', ';
      });
    }

    if (json['wantToMeet'] != null) {
      wantToMeet = new List<WantToMeet>();
      wantToMeetString = '';
      json['wantToMeet'].forEach((v) {
        var wantToMeetObj = new WantToMeet.fromJson(v);
        wantToMeet.add(wantToMeetObj);
        wantToMeetString = wantToMeetString + wantToMeetObj.title + ', ';
      });
    }

    if (json['title'] != null) {
      title = json['title'];
    }
    if (json['event_id'] != null) {
      event_id = json['event_id'];
    }
    if (json['user_id'] != null) {
      user_id = json['user_id'];
    }
    if (json['description'] != null) {
      description = json['description'];
    }
    if (json['isSelected'] != null) {
      isSelected = json['isSelected'];
    }

    if (json['location'] != null) {
      location = json['location'];
    }
    if (json['latitude'] != null) {
      var lat = json['latitude'];
      if (lat == '') {
        latitude = 00;
      } else {
        latitude = double.parse(lat);
      }
    }

    if (json['longitude'] != null) {
      var lat = json['longitude'];
      if (lat == '') {
        longitude = 00;
      } else {
        longitude = double.parse(lat);
      }
    }
    // if (json['longitude'] != null) {
    //   longitude = json['longitude'];
    // }
    if (json['event_date'] != null) {
      var dateformate = json['event_date'];
      var newDateTimeObj2 =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(dateformate);
      var formatter = new DateFormat("MMM dd hh:mm a");
      event_date = formatter.format(newDateTimeObj2);

      var formatterMonth = new DateFormat("MMMM");
      eventMonth = formatterMonth.format(newDateTimeObj2);

      var formatterDay = new DateFormat("EEEE");
      eventDay = formatterDay.format(newDateTimeObj2);

      var formatterTime = new DateFormat("hh:mm a");
      eventTime = formatterTime.format(newDateTimeObj2);

      var formatterDate = new DateFormat("dd");
      eventDate = formatterDate.format(newDateTimeObj2);
    }
    if (json['social_name'] != null) {
      social_name = json['social_name'];
    }
    if (json['gender_and_income'] != null) {
      gender_and_income = json['gender_and_incometitle'];
    }
    if (json['age'] != null) {
      age = json['age'];
    }
    if (json['status'] != null) {
      status = json['status'];
    }
    if (json['cancel_reason'] != null) {
      cancel_reason = json['cancel_reason'];
    }
    if (json['card_id'] != null) {
      card_id = json['card_id'];
    }
    if (json['event_type'] != null) {
      event_type = json['event_type'];
    }
    if (json['user_name'] != null) {
      user_name = json['user_name'];
    }
    if (json['email'] != null) {
      email = json['email'];
    }

    if (json['phone'] != null) {
      phone = json['phone'];
    }

    if (json['is_my_event'] != null) {
      if (json['is_my_event'] == 0) {
        is_my_event = false;
      } else {
        is_my_event = true;
      }
    }

    if (json['profile_photo'] != null) {
      profile_photo = json['profile_photo'];
    }
    if (json['gender'] != null) {
      gender = json['gender'];
    }

    if (json['member'] != null) {
      member = json['member'];
    }

    if (json['distance'] != null) {
      distance = json['distance'];
    }

    // }
  }
}

class NotificationList {
  int alert_id = 0;
  int user_id = 0;
  String title = '';
  String description = '';
  int alert_type_id = 0;
  int is_read = 0;
  String type = '';
  String user_name = '';
  String email = '';
  String location = '';
  String profile_photo = '';
  String latitude = '';
  String longitude = '';
  String postal_code = '';
  String city = '';
  String created_at = '';
  // String created_at = '';
  String facebook_url = '';
  String linkedin_url = '';
  String instagram_url = '';
  // NotificationList();

  NotificationList.fromJson(Map<String, dynamic> json) {
    // Map<String, dynamic> json; //  user = json['user'] != null ? new Data.fromJson(json['user']) : null;

    if (json['alert_id'] != null) {
      alert_id = json['alert_id'];
    }

    if (json['created_at'] != null) {
      created_at = json['created_at'];
    }

    if (json['user_id'] != null) {
      user_id = json['user_id'];
    }

    if (json['title'] != null) {
      title = json['title'];
    }

    if (json['description'] != null) {
      description = json['description'];
    }

    if (json['alert_type_id'] != null) {
      alert_type_id = json['alert_type_id'];
    }

    if (json['is_read'] != null) {
      is_read = json['is_read'];
    }

    if (json['type'] != null) {
      type = json['type'];
    }

    if (json['user_name'] != null) {
      user_name = json['user_name'];
    }

    if (json['email'] != null) {
      email = json['email'];
    }

    if (json['location'] != null) {
      location = json['location'];
    }

    if (json['profile_photo'] != null) {
      profile_photo = json['profile_photo'];
    }

    if (json['latitude'] != null) {
      latitude = json['latitude'];
    }

    if (json['longitude'] != null) {
      longitude = json['longitude'];
    }
    if (json['postal_code'] != null) {
      postal_code = json['postal_code'];
    }
    if (json['city'] != null) {
      city = json['city'];
    }

    if (json['facebook_url'] != null) {
      facebook_url = json['facebook_url'];
    }

    if (json['linkedin_url'] != null) {
      linkedin_url = json['linkedin_url'];
    }

    if (json['instagram_url'] != null) {
      instagram_url = json['instagram_url'];
    }
  }
}

class DiscoverEventList {
  String eventTime = '';
  String eventDate = '';
  String eventMonth = '';
  String eventDay = '';

  String title = '';
  int event_id = 0;
  int user_id = 0;
  String description = '';
  bool isSelected = false;
  bool is_my_event = false;
  String location = '';
  String latitude = '';
  String longitude = '';
  String event_date = '';
  String social_name = '';
  String gender_and_income = '';
  String age = '';
  int status = 1;
  String cancel_reason = '';
  int card_id = 1;
  int event_type = 1;
  String user_name = '';
  String email = '';
  String phone = '';
  String profile_photo = '';
  String gender = '';
  int member = 0;
  int distance = 0;

  List<GenerationIdentify> generationIdentify;
  List<Profession> profession;
  List<WantToMeet> wantToMeet;
  List<WhoEarn> whoEarn;
  List<Interest> interest;
  List<ImagesModel> imagesModel;

  String generationIdentifyString = '';
  String wantToMeetString = '';
  String professionString = '';
  String interestString = '';

  String totalUnacceptedEventCount = '';
  List<OtherTime> event_suggested_times;
  List<WhoIsGoingTo> whoIsGointTo;
  String whoIsGointToString = '';
  String otherTime1 = '';
  String otherTime2 = '';

  DiscoverEventList(
      {this.generationIdentify,
      this.profession,
      this.wantToMeet,
      this.imagesModel});

  DiscoverEventList.fromJson(Map<String, dynamic> json) {
    // Map<String, dynamic> json; //  user = json['user'] != null ? new Data.fromJson(json['user']) : null;

    //  if (newData['data'] != null){
    // json = newData['data'];
    if (json['event_suggested_times'] != null) {
      event_suggested_times = new List<OtherTime>();
      json['event_suggested_times'].forEach((v) {
        event_suggested_times.add(new OtherTime.fromJson(v));
      });
    }

    if (json['who_is_going_to'] != null) {
      whoIsGointTo = new List<WhoIsGoingTo>();
      whoIsGointToString = "";

      json['who_is_going_to'].forEach((v) {
        var going = new WhoIsGoingTo.fromJson(v);
        whoIsGointTo.add(going);
        whoIsGointToString = whoIsGointToString +
            going.user_count.toString() +
            ' ' +
            going.gender +
            ' ';
      });
    }

    if (json['whoEarn'] != null) {
      whoEarn = new List<WhoEarn>();
      json['whoEarn'].forEach((v) {
        whoEarn.add(new WhoEarn.fromJson(v));
      });
    }

    if (json['eventimages'] != null) {
      imagesModel = new List<ImagesModel>();
      json['eventimages'].forEach((v) {
        imagesModel.add(new ImagesModel.fromJson(v));
      });
    }

    if (json['what_you_like'] != null) {
      interest = new List<Interest>();
      interestString = '';
      json['what_you_like'].forEach((v) {
        var intrestArr = new Interest.fromJson(v);
        interest.add(intrestArr);
        interestString = interestString + intrestArr.title + ', ';
      });
    }

    if (json['generations_identify'] != null) {
      generationIdentify = new List<GenerationIdentify>();

      generationIdentifyString = '';

      json['generations_identify'].forEach((v) {
        var generation = new GenerationIdentify.fromJson(v);
        generationIdentify.add(generation);
        generationIdentifyString =
            generationIdentifyString + generation.title + ', ';
      });
    }

    if (json['profession'] != null) {
      profession = new List<Profession>();
      professionString = '';
      json['profession'].forEach((v) {
        var proffesion = new Profession.fromJson(v);
        profession.add(proffesion);
        professionString = professionString + proffesion.title + ', ';
      });
    }

    if (json['wantToMeet'] != null) {
      wantToMeet = new List<WantToMeet>();
      wantToMeetString = '';
      json['wantToMeet'].forEach((v) {
        var wantToMeetObj = new WantToMeet.fromJson(v);
        wantToMeet.add(wantToMeetObj);
        wantToMeetString = wantToMeetString + wantToMeetObj.title + ', ';
      });
    }

    if (json['title'] != null) {
      title = json['title'];
    }
    if (json['event_id'] != null) {
      event_id = json['event_id'];
    }
    if (json['user_id'] != null) {
      user_id = json['user_id'];
    }
    if (json['description'] != null) {
      description = json['description'];
    }
    if (json['isSelected'] != null) {
      isSelected = json['isSelected'];
    }

    if (json['location'] != null) {
      location = json['location'];
    }
    if (json['latitude'] != null) {
      latitude = json['latitude'];
    }
    if (json['longitude'] != null) {
      longitude = json['longitude'];
    }
    if (json['event_date'] != null) {
      var dateformate = json['event_date'];
      var newDateTimeObj2 =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(dateformate);
      var formatter = new DateFormat("MMM dd hh:mm a");
      event_date = formatter.format(newDateTimeObj2);

      var formatterMonth = new DateFormat("MMMM");
      eventMonth = formatterMonth.format(newDateTimeObj2);

      var formatterDay = new DateFormat("EEEE");
      eventDay = formatterDay.format(newDateTimeObj2);

      var formatterTime = new DateFormat("hh:mm a");
      eventTime = formatterTime.format(newDateTimeObj2);

      var formatterDate = new DateFormat("dd");
      eventDate = formatterDate.format(newDateTimeObj2);
    }
    if (json['social_name'] != null) {
      social_name = json['social_name'];
    }
    if (json['gender_and_income'] != null) {
      gender_and_income = json['gender_and_incometitle'];
    }
    if (json['age'] != null) {
      age = json['age'];
    }
    if (json['status'] != null) {
      status = json['status'];
    }
    if (json['cancel_reason'] != null) {
      cancel_reason = json['cancel_reason'];
    }
    if (json['card_id'] != null) {
      card_id = json['card_id'];
    }
    if (json['event_type'] != null) {
      event_type = json['event_type'];
    }
    if (json['user_name'] != null) {
      user_name = json['user_name'];
    }
    if (json['email'] != null) {
      email = json['email'];
    }

    if (json['phone'] != null) {
      phone = json['phone'];
    }

    if (json['is_my_event'] != null) {
      if (json['is_my_event'] == 0) {
        is_my_event = false;
      } else {
        is_my_event = true;
      }
    }

    if (json['profile_photo'] != null) {
      profile_photo = json['profile_photo'];
    }
    if (json['gender'] != null) {
      gender = json['gender'];
    }

    if (json['member'] != null) {
      member = json['member'];
    }

    if (json['distance'] != null) {
      distance = json['distance'];
    }

    // }
  }
}

class ChatMessage {
  int chat_id = 0;
  int event_id = 0;
  int receiver_id = 0;
  int sender_id = 0;
  String message = "";
  String sender_name = "";

  String sender_email = '';
  String sender_profile_image = '';

  ChatMessage(
      {this.chat_id,
      this.event_id,
      this.receiver_id,
      this.sender_id,
      this.message,
      this.sender_name,
      this.sender_email,
      this.sender_profile_image});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    if (json['chat_id'] != null) {
      chat_id = json['chat_id'];
    }
    if (json['event_id'] != null) {
      event_id = json['event_id'];
    }

    if (json['receiver_id'] != null) {
      receiver_id = json['receiver_id'];
    }

    if (json['sender_id'] != null) {
      sender_id = json['sender_id'];
    }

    if (json['message'] != null) {
      message = json['message'];
    }

    if (json['sender_name'] != null) {
      sender_name = json['sender_name'];
    }

    if (json['sender_email'] != null) {
      sender_email = json['sender_email'];
    }

    if (json['sender_profile_image'] != null) {
      sender_profile_image = json['sender_profile_image'];
    }
  }
}

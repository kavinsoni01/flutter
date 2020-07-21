


import 'dart:io';

import 'package:simposi/Utils/Models/AppDataModel.dart';

class CreateEventModel {

  var title = '';
  var description = "";
  var date = "";
  var location = "";

  double lat = 0;
  double long = 0;

  var language_id = '1';
  var cardID = "";
  var eventType = "";

  
  double distance = 0;
  File selectImage;

  String gendersId = ""; 
  String intrestId = "";
  String earningId = "";
  String ageId = "";

  // GenerationIdentify selectedGeneration;
  // Profession profession;
  // WantToMeet wantToMeet;
  // WhoEarn whoEarn;
  // Interest interest;

  String profestionId = "";

}
import 'dart:io';
import 'package:simposi/Utils/Models/AppDataModel.dart';

class SignupModel {
  String name = '';
  String city;
  String email;
  int userId;
  int userRoleId;
  String password;
  String postalCode;
  bool lgbqt;
  int gender;
  String meet;
  int is_new = 0;
  String latitude;
  String longitude;

  double distance = 0;
  File selectImage;

  GenerationIdentify selectedGeneration;
}

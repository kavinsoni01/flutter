
import 'package:shared_preferences/shared_preferences.dart';

class AppManager {
  static final String kOnBoardingStatus = 'onBoardingStatus';
  static final String IS_CUSTOMER = "is_customer";
  static final String IS_LOGGED_IN = "is_logged_in";
  static final String LAT = 'latitude';
  static final String LONG = 'longitude';


  SharedPreferences preferences;

  static bool getIsCustomerOrServiceProvider(SharedPreferences prefs) {
      return prefs.containsKey(IS_CUSTOMER)
          ? prefs.getBool(IS_CUSTOMER ?? false)
          : false;
    }
  
    static Future<bool> setIsCustomerOrServiceProvider(bool value, SharedPreferences prefs) {
      return prefs.setBool(IS_CUSTOMER, value);
    }
  
    static Future<bool> setIsLoggedIn(bool value, SharedPreferences prefs) {
      return prefs.setBool(IS_LOGGED_IN, value);
    }   
  
    static bool getIsLoggedIn(SharedPreferences prefs) {
      return prefs.containsKey(IS_LOGGED_IN)
          ? prefs.getBool(IS_LOGGED_IN ?? false)
          : false;
    }
  
  
    ///Logout
    static Future<bool> logout(SharedPreferences prefs) {
      return prefs.clear();
    }
  
  static void setCurrentLatitude(String value, SharedPreferences prefs) {
      prefs.setString(LAT, value);
    }
  
    static void setCurrentLongitude(String value, SharedPreferences prefs) {
      prefs.setString(LONG, value);
    }
  
    static String getCurrentLatitude(SharedPreferences prefs) {
      return prefs.getString(LAT);
    }
  
    static String getCurrentLongitude(SharedPreferences prefs) {
      return prefs.getString(LAT);
    }
  
    // static String getUser(SharedPreferences prefs) {
    //   return prefs.containsKey(kUser) ? prefs.getString(kUser ?? '') : '';
    // }
  
    // static Future<bool> setUser(String value, SharedPreferences prefs) {
    //   return prefs.setString(kUser, value);
    // }
  
  
  }

library dropbox_integration;

import 'package:dropbox_client/dropbox_client.dart' as dbx;
import 'Classes/ALL.dart';


class Dropbox {

  ///From this instance you can call the methods referring to the logged in user
  ///
  ///If user is not logged in and until token is not provided, this returns `null`
  ///So, this instance begin a DropboxInstance when you call `getAccessToken()` or `loginWithAccessToken()`
  static DropboxInstance instance;


  ///Initialize the dropbox plugin.
  ///Call this method only once!
  static Future<void> initDropbox(String nameApp, String key, String secret) async 
    => await dbx.Dropbox.init(nameApp, key, secret);


  ///Login user to Dropbox account
  ///
  ///This method opens an internet page on the device to log in.
  ///After this, you mast call `getAccessToken()` to get the user token and to use the `DropboxInstance` 
  static Future<void> login() async => await dbx.Dropbox.authorize();
  


  ///Get user's access token
  ///
  ///This return `null` if user is not log into.
  ///So call this method after `login()` function
  static Future<String> getAccessToken() async {
    String _token = await dbx.Dropbox.getAccessToken();

    if(_token != null){
      instance = DropboxInstance(_token);
    }

    return _token;
  }

  
  ///Authorize with an AccessToken
  ///
  ///Use `getAccessToken()` to get accessToken String after successful `login()`.
  ///
  ///`loginWithAccessToken()` will authorize without user interaction (only if access token is valid.)
  ///
  ///EXAMPLE: the first time you log in (with the `login()` method) you save the token locally with SharedPreferences.
  ///From that moment on, when starting the app we will use the `loginWithAccessToken()` function, with the argument being the previously saved token
  static Future<void> loginWithAccessToken(String accessToken) async {
    await dbx.Dropbox.authorizeWithAccessToken(accessToken);

    if(accessToken != null){
      instance = DropboxInstance(accessToken);
    }
  }


  ///Logout user from the app and remove authorization
  static Future<void> logout() async {
    await dbx.Dropbox.unlink();

    instance = null;
  }
  
}

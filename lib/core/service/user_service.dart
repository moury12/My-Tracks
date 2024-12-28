import 'dart:convert';
import 'dart:developer';

import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:track_trek/core/utils/helper_function.dart';
class UserService{
static Future<UserModel> getUserData()async{
  UserModel user = UserModel();
  try{
    final url = Uri.parse(ApiClient.userProfileUrl);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',

    };

    final response = await http.get(
      url,
      headers: headers,
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    log('-----------------user profile call--------------------');
    log(responseData.toString());
    if (responseData['success'] != null &&
        responseData['success'] == true) {
      user =UserModel.fromJson(responseData['data']);
      return user;
    } else {
      showCustomSnackbar(title: AppStaticString.failed,
          message: responseData['message'], type: SnackBarType.failed);
      return user;
    }
  }catch(e){
    showCustomSnackbar(title: AppStaticString.failed,
        message: e.toString(), type: SnackBarType.failed);
  }
  return user;
}

}
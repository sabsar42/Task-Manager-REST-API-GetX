import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import 'auth_controllers.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  String _failedMessage = '';

  bool get loginInProgress => _loginInProgress;

  String get failureMessage => _failedMessage;

  Future<bool> login(String email, String password) async {
    _loginInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller().postRequest(Urls.login,
        body: {
          'email': email,
          'password': password,
        },
        isLogin: true);
    _loginInProgress = false;

    update();
    if (response.isSuccess) {
      await Get.find<AuthController>().saveUserInformation(
          response.jsonResponse['token'],
          UserModel.fromJson(response.jsonResponse['data']));
      return true;
    } else {
      if (response.statusCode == 401) {
        _failedMessage = 'Please check email/password';
      } else {
        _failedMessage = 'Login failed. Try again';
      }
    }
    return false;
  }
}

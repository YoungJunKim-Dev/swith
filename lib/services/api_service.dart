import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://100.21.156.51:5001";

  static Future<bool> getAuthentication(jwt) async {
    final uri = Uri.parse('$baseUrl/api/users/authentication');

    try {
      var response = await http.get(uri, headers: {'Authorization': jwt});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> deleteUser(jwt, userEmail, userPassword) async {
    final uri = Uri.parse('$baseUrl/api/users/');

    try {
      var response = await http.delete(uri, headers: {
        'Authorization': jwt
      }, body: {
        'user_email': userEmail,
        'user_password': userPassword,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return "회원탈퇴에 실패하였습니다. 나중에 다시 시도해주세요.";
    }
  }

  // static Future<http.Response> postSignUp(
  static Future<dynamic> postSignUp(userEmail, userPassword, userName) async {
    final uri = Uri.parse('$baseUrl/api/users/signup');

    try {
      return await http.post(uri, body: {
        'user_email': userEmail,
        'user_password': userPassword,
        'user_name': userName
      });
    } catch (e) {
      return "회원가입이 실패하였습니다. 나중에 다시 시도해주세요.";
    }
  }

  // static Future<http.Response> postLogIn(userEmail, userPassword) async {
  static Future<dynamic> postLogIn(userEmail, userPassword) async {
    try {
      final uri = Uri.parse('$baseUrl/api/users/login');

      return await http.post(uri,
          body: {'user_email': userEmail, 'user_password': userPassword});
    } catch (e) {
      return "로그인에 실패하였습니다. 나중에 다시 시도해주세요.";
    }
  }
}

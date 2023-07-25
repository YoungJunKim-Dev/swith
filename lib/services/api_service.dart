import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://100.21.156.51:5001";

  static Future<bool> getAuthentication(jwt) async {
    final uri = Uri.parse('$baseUrl/api/users/authentication');

    var response = await http.get(uri, headers: {'Authorization': jwt});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<http.Response> postSignUp(
      userEmail, userPassword, userName) async {
    final uri = Uri.parse('$baseUrl/api/users/signup');

    return await http.post(uri, body: {
      'user_email': userEmail,
      'user_password': userPassword,
      'user_name': userName
    });
  }

  static Future<http.Response> postLogIn(userEmail, userPassword) async {
    final uri = Uri.parse('$baseUrl/api/users/login');

    return await http.post(uri,
        body: {'user_email': userEmail, 'user_password': userPassword});
  }
}

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://100.21.156.51:5001";

  static Future postSignUp(userEmail, userPassword, userName) async {
    final uri = Uri.parse('$baseUrl/api/users/signup');
    try {
      final response = await http.post(uri, body: {
        'user_email': userEmail,
        'user_password': userPassword,
        'user_name': userName
      });

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  // static void postLogIn() async {
  //   final url = Uri.parse('$baseUrl/api/users/login');
  //   final response = await http.post(url,
  //       body: {'user_email': "son7@tot.com", 'user_password': "1q2w3e4r"});
  //   if (response.statusCode == 200) {
  //   } else {
  //     throw Error();
  //   }
  // }

  static Future postLogIn(userEmail, userPassword) async {
    final uri = Uri.parse('$baseUrl/api/users/login');
    try {
      final response = await http.post(uri,
          body: {'user_email': userEmail, 'user_password': userPassword});
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }
}

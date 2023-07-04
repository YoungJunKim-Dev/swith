import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://100.21.156.51:5001";

  static void postSignUp(user) async {
    final url = Uri.parse('$baseUrl/api/users/signup');
    final response = await http.post(url);

    if (response.statusCode == 200) {
    } else {
      throw Error();
    }
  }

  static void postLogIn() async {
    final url = Uri.parse('$baseUrl/api/users/login');
    final response = await http.post(url,
        body: {'user_email': "son7@tot.com", 'user_password': "1q2w3e4r"});
    if (response.statusCode == 200) {
    } else {
      throw Error();
    }
  }
}

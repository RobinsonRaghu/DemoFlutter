import 'dart:convert';

import 'package:http/http.dart' as http;
class ListApi{

  static String host = 'http://172.20.10.2';

  static Future<http.Response> getFriendList() async {
    return await http.get(Uri.parse("$host:8080/"));
  }

  static Future<http.Response> post(String url, {Map<dynamic,dynamic>? body}) async {

    String endpoint = '$host:8080/';

    String reqBody = body == null ? '' : jsonEncode(body);

    http.Response response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: reqBody
    );

    if(response.statusCode >= 300) {
      throw Exception((response.body));
    }

    return response;
  }

}
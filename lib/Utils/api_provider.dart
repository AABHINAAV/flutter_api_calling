import 'dart:convert';
import 'dart:io';

import 'package:b_api_calling/Exceptions/custom_exception.dart';
import 'package:b_api_calling/Models/posts.dart';
import 'package:http/http.dart' as httpObj;

class ApiProvider {
  static Future<List<Post>> getPosts() async {
    dynamic posts;
    print("start");
    try {
      String apiUrl = "https://jsonplaceholder.typicode.com/posts";
      final response =
          await httpObj.get(Uri.parse(Uri.encodeFull(apiUrl)), headers: {
        'content-type': 'application/json',
      });
      print(response);

      posts = extractResponse(response);
      print(posts);
    } on SocketException catch (e) {
      print("Error in calling API : " + e.message);
    }

    print("end");
    return posts;
  }

  static dynamic extractResponse(httpObj.Response response) {
    List<Post> posts = [];

    switch (response.statusCode) {
      case 200:
        {
          final dynamic rawData = json.decode(response.body.toString());

          posts.clear();
          for (Map<String, dynamic> singleData in rawData) {
            posts.add(Post.fromMap(singleData));
          }

          return posts as dynamic;
        }
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            "Error in communication with server:-\nStatus Code : " +
                response.statusCode.toString());
    }
  }
}

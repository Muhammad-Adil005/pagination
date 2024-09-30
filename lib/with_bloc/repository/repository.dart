import 'package:dio/dio.dart';
import 'package:pagination_app/with_bloc/model/user_model.dart';

class Repository {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  final Dio _dio = Dio(); // create an instance of the Dio

  Future<List<UserModel>> fetchPost(int page, int limit) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          '_page': page,
          '_limit': limit,
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data;
        return jsonResponse.map((data) => UserModel.fromJson(data)).toList();
      } else {
        throw Exception('Failed to Load Posts');
      }
    } catch (e) {
      throw Exception('Failed to Load Posts : $e');
    }
  }
}

/*
// Using HTTP Package

class PostRepository {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostModel>> fetchPosts(int page, int limit) async {
    final response = await http.get(Uri.parse('$_baseUrl?_page=$page&_limit=$limit'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => PostModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}

 */

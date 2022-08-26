import 'package:dio/dio.dart';
import 'package:pet_perfect/posts/model/post_model.dart';

class PostsRepo {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final response = await _dio.get(_baseUrl);
    return [
      for (final item in response.data as List) Post.fromJson(item),
    ];
  }
}

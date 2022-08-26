import 'package:pet_perfect/posts/model/post_model.dart';

class PostsState {
  List<Post> posts;
  bool error;

  PostsState({required this.posts, this.error = false});
}

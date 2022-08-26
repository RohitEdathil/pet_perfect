import 'package:pet_perfect/posts/model/posts_repo.dart';

abstract class PostEvent {}

class PostLoad extends PostEvent {
  final PostsRepo repo;
  PostLoad(this.repo);
}

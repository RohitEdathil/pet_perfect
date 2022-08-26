import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect/posts/model/post_events.dart';
import 'package:pet_perfect/posts/model/post_state.dart';

class PostsBloc extends Bloc<PostEvent, PostsState> {
  PostsBloc() : super(PostsState(posts: [])) {
    on<PostLoad>(_fetchPosts);
  }

  /// Fetches the posts from the repository and updates the state
  void _fetchPosts(PostLoad event, Emitter<PostsState> emit) async {
    await event.repo.fetchPosts().then((value) {
      emit(PostsState(posts: value));
    }).onError((error, stackTrace) {
      emit(PostsState(error: true, posts: []));
    });
  }
}

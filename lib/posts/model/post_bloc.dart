import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect/posts/model/post_events.dart';
import 'package:pet_perfect/posts/model/post_state.dart';

class PostsBloc extends Bloc<PostEvent, PostsState> {
  PostsBloc() : super(PostsState(posts: [])) {
    on<PostLoad>(_fetchPosts);
  }

  void _fetchPosts(PostLoad event, Emitter<PostsState> emit) async {
    emit(PostsState(posts: await event.repo.fetchPosts()));
  }
}

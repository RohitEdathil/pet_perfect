import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect/posts/model/post_bloc.dart';
import 'package:pet_perfect/posts/model/post_events.dart';
import 'package:pet_perfect/posts/model/post_state.dart';
import 'package:pet_perfect/posts/model/posts_repo.dart';

class PostsView extends StatelessWidget {
  const PostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PostsBloc>().add(PostLoad(context.read<PostsRepo>()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state.posts.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: [
              for (final post in state.posts)
                ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                )
            ],
          );
        },
      ),
    );
  }
}

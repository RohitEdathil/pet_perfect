import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect/components/error.dart';
import 'package:pet_perfect/posts/components/saved_list.dart';
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SavedList(),
                  ),
                );
              },
              icon: Icon(Icons.save_alt))
        ],
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state.error) {
            return const ErrorMessage();
          }
          if (state.posts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                for (final post in state.posts)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(post.title),
                        subtitle: Text(post.body),
                      ),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}

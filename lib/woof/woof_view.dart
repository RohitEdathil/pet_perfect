import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect/components/error.dart';
import 'package:pet_perfect/posts/posts_view.dart';
import 'package:pet_perfect/woof/components/dynamic_display.dart';
import 'package:pet_perfect/woof/components/placeholder.dart';
import 'package:pet_perfect/woof/model/woof_bloc.dart';
import 'package:pet_perfect/woof/model/woof_events.dart';
import 'package:pet_perfect/woof/model/woof_repo.dart';
import 'package:pet_perfect/woof/model/woof_state.dart';

class WoofView extends StatelessWidget {
  const WoofView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WoofBloc>().add(NewWoofEvent(repo: context.read<WoofRepo>()));

    return BlocBuilder<WoofBloc, WoofState>(
      builder: (context, state) {
        if (state.readyState == WoofReadyState.error) {
          return const Scaffold(
            body: ErrorMessage(),
          );
        }

        if (state.content == null) {
          return const Scaffold(
            body: Center(
              child: PlaceholderLoading(),
            ),
          );
        }
        return Scaffold(
          // Only show if readyState is ready
          floatingActionButton: state.readyState == WoofReadyState.ready
              ? FloatingActionButton(
                  onPressed: () async {
                    // Triggers save and navigation to posts view
                    context.read<WoofBloc>().add(SaveWoofEVent());
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PostsView(),
                      ),
                    );
                  },
                  child: const Icon(Icons.save),
                )
              : null,
          body: Center(
            child: GestureDetector(
                onTap: () {
                  // Loads a random woof again
                  context.read<WoofBloc>().add(WoofUpdatedEvent(loading: true));
                  context
                      .read<WoofBloc>()
                      .add(NewWoofEvent(repo: context.read<WoofRepo>()));
                },
                child: DynamicDisplay(woof: state.content!)),
          ),
        );
      },
    );
  }
}

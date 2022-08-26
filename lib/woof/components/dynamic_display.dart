import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect/woof/components/placeholder.dart';
import 'package:pet_perfect/woof/model/woof_bloc.dart';
import 'package:pet_perfect/woof/model/woof_events.dart';
import 'package:pet_perfect/woof/model/woof_model.dart';
import 'package:pet_perfect/woof/model/woof_state.dart';
import 'package:video_player/video_player.dart';

class DynamicDisplay extends StatefulWidget {
  final Woof woof;
  const DynamicDisplay({Key? key, required this.woof}) : super(key: key);

  @override
  State<DynamicDisplay> createState() => _DynamicDisplayState();
}

class _DynamicDisplayState extends State<DynamicDisplay> {
  bool playing = false;
  String url = '';

  late VideoPlayerController _controller;

  Widget _dynamicDisplay(BuildContext context) {
    if (playing && url == widget.woof.url) {
      final bloc = context.read<WoofBloc>();

      if (bloc.state.readyState != WoofReadyState.ready) {
        bloc.add(WoofUpdatedEvent());
      }

      return VideoPlayer(_controller);
    }

    if (widget.woof.type == WoofType.image) {
      return Image.network(
        widget.woof.url,
        fit: BoxFit.cover,
        frameBuilder: ((context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            context.read<WoofBloc>().add(WoofUpdatedEvent());

            return child;
          }

          if (frame == null) {
            return const Center(
              child: PlaceholderLoadingMini(),
            );
          }

          final bloc = context.read<WoofBloc>();

          if (bloc.state.readyState != WoofReadyState.ready) {
            bloc.add(WoofUpdatedEvent());
          }

          return child;
        }),
      );
    } else {
      _controller = VideoPlayerController.network(widget.woof.url);
      _controller.setLooping(true);
      _controller.setVolume(0);
      _controller.initialize().then((_) async {
        _controller.play();
        setState(() {
          playing = true;
          url = widget.woof.url;
        });
      });
      return const PlaceholderLoadingMini();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.black.withOpacity(0.1),
          height: MediaQuery.of(context).size.height / 2,
          width: double.infinity,
          child: _dynamicDisplay(context),
        ),
      ),
    );
  }
}

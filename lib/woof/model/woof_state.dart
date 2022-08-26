import 'package:pet_perfect/woof/model/woof_model.dart';

class WoofState {
  Woof? content;
  WoofReadyState readyState;
  WoofState({this.content, required this.readyState});

  WoofState copyWith(
    WoofReadyState readyState,
  ) {
    return WoofState(
      content: content,
      readyState: readyState,
    );
  }
}

enum WoofReadyState {
  loading,
  ready,
  error,
}

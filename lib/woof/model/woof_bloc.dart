import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pet_perfect/woof/model/woof_events.dart';
import 'package:pet_perfect/woof/model/woof_state.dart';

class WoofBloc extends Bloc<WoofEvent, WoofState> {
  Box? _db;
  List? saved;

  WoofBloc() : super(WoofState(readyState: WoofReadyState.loading)) {
    on<NewWoofEvent>(_fetchNewWoof);
    on<WoofUpdatedEvent>(_updateWoof);
    on<SaveWoofEVent>(_saveWoof);
  }

  void _fetchNewWoof(NewWoofEvent event, Emitter<WoofState> emit) async {
    _db ??= await Hive.openBox('woof');
    if (saved == null) {
      final _saved = await _db!.get('saved');
      if (_saved == null) {
        saved = [];
        await _db!.put("saved", <String>[]);
      } else {
        saved = _saved;
      }
    }

    await event.repo.fetchWoof().then((value) {
      emit(WoofState(content: value, readyState: WoofReadyState.loading));
    }).onError((error, stackTrace) {
      emit(WoofState(readyState: WoofReadyState.error));
    });
  }

  void _updateWoof(WoofUpdatedEvent event, Emitter<WoofState> emit) {
    if (event.loading) {
      emit(state.copyWith(WoofReadyState.loading));
      return;
    }
    emit(state.copyWith(WoofReadyState.ready));
  }

  void _saveWoof(SaveWoofEVent event, Emitter<WoofState> emit) async {
    saved!.add(state.content!.url);
    print(saved);
    await _db?.put('saved', saved);
  }
}

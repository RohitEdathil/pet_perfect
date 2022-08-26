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
    on<DeleteWoofEvent>(_deleteWoof);
  }

  /// Fetches a new woof from the repo and updates the state
  void _fetchNewWoof(NewWoofEvent event, Emitter<WoofState> emit) async {
    // Initialize the hive box
    _db ??= await Hive.openBox('woof');
    if (saved == null) {
      final savedTemp = await _db!.get('saved');
      if (savedTemp == null) {
        saved = [];
        await _db!.put("saved", <String>[]);
      } else {
        saved = savedTemp;
      }
    }

    // Actual fetch logic
    await event.repo.fetchWoof().then((value) {
      emit(WoofState(content: value, readyState: WoofReadyState.loading));
    }).onError((error, stackTrace) {
      emit(WoofState(readyState: WoofReadyState.error));
    });
  }

  /// Updates the state with a new woof state
  void _updateWoof(WoofUpdatedEvent event, Emitter<WoofState> emit) {
    if (event.loading) {
      emit(state.copyWith(WoofReadyState.loading));
      return;
    }
    emit(state.copyWith(WoofReadyState.ready));
  }

  /// Delete the woof from the saved list and the database
  void _deleteWoof(DeleteWoofEvent event, Emitter<WoofState> emit) async {
    saved!.remove(event.url);
    await _db?.put('saved', saved);
  }

  /// Save the woof to the saved list and the database
  void _saveWoof(SaveWoofEVent event, Emitter<WoofState> emit) async {
    saved!.add(state.content!.url);
    await _db?.put('saved', saved);
  }
}

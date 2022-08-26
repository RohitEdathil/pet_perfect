import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_perfect/woof/model/woof_bloc.dart';
import 'package:pet_perfect/woof/model/woof_events.dart';
import 'package:pet_perfect/woof/model/woof_repo.dart';
import 'package:pet_perfect/woof/model/woof_state.dart';

void main() {
  group("WoofBloc", () {
    late WoofBloc woofBloc;
    late WoofRepo woofRepo;

    setUp(() {
      woofBloc = WoofBloc();
      woofRepo = WoofRepo();
    });

    test("initially bloc is in loading state", () {
      expect(woofBloc.state.readyState, WoofReadyState.loading);
    });
  });
}

import 'package:pet_perfect/woof/model/woof_repo.dart';

abstract class WoofEvent {}

class NewWoofEvent extends WoofEvent {
  WoofRepo repo;
  NewWoofEvent({required this.repo});
}

class WoofUpdatedEvent extends WoofEvent {
  bool loading;
  WoofUpdatedEvent({this.loading = false});
}

class SaveWoofEVent extends WoofEvent {}

class DeleteWoofEvent extends WoofEvent {
  String url;
  DeleteWoofEvent({required this.url});
}

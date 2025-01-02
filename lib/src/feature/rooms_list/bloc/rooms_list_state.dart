import 'package:coworking_mobile/src/feature/rooms_list/model/rooms_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rooms_list_state.freezed.dart';

@freezed
class RoomsListState with _$RoomsListState {
  const factory RoomsListState.loading({
    @Default(<Rooms>[]) List<Rooms> roomsList,
  }) = _Loading;

  const factory RoomsListState.loaded({
    @Default(<Rooms>[]) List<Rooms> roomsList,
  }) = _Loaded;

  const factory RoomsListState.idle({
    @Default(<Rooms>[]) List<Rooms> roomsList,
  }) = _Idle;
}

import 'package:coworking_mobile/src/feature/rooms_details/model/rooms_details_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rooms_details_state.freezed.dart';

@freezed
class RoomsDetailsState with _$RoomsDetailsState {
  const factory RoomsDetailsState.loading() = _Loading;

  const factory RoomsDetailsState.loaded({
    required RoomsDetails roomsDetails,
  }) = _Loaded;

  const factory RoomsDetailsState.idle() = _Idle;
}

import 'package:coworking_mobile/src/feature/acselerator/model/acselerator_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'acselerator_list_state.freezed.dart';

@freezed
class AcseleratorListState with _$AcseleratorListState {
  const factory AcseleratorListState.loading({
    @Default(<Acselerator>[]) List<Acselerator> roomsList,
  }) = _Loading;

  const factory AcseleratorListState.loaded({
    @Default(<Acselerator>[]) List<Acselerator> roomsList,
  }) = _Loaded;

  const factory AcseleratorListState.idle({
    @Default(<Acselerator>[]) List<Acselerator> roomsList,
  }) = _Idle;
}

import 'package:coworking_mobile/src/feature/acselerator_details/model/acselector_details_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'acselerator_details_state.freezed.dart';

@freezed
class AcseleratorDetailsState with _$AcseleratorDetailsState {
  const factory AcseleratorDetailsState.loading() = _Loading;

  const factory AcseleratorDetailsState.loaded({
    required AcseleratorDetails acselectorDetails,
  }) = _Loaded;

  const factory AcseleratorDetailsState.idle() = _Idle;
}

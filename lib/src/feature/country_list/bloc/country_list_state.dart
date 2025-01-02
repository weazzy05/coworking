import 'package:coworking_mobile/src/feature/country_list/model/country_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_list_state.freezed.dart';

@freezed
class CountryListState with _$CountryListState {
  const factory CountryListState.loading({
    @Default(<CountryDto>[]) List<CountryDto> countriesList,
  }) = _Loading;

  const factory CountryListState.loaded({
    @Default(<CountryDto>[]) List<CountryDto> countriesList,
  }) = _Loaded;

  const factory CountryListState.idle({
    @Default(<CountryDto>[]) List<CountryDto> countriesList,
  }) = _Idle;
}

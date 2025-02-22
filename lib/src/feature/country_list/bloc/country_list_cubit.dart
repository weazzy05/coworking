import 'package:coworking_mobile/src/feature/country_list/data/country_list_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'country_list_state.dart';

class CountryListCubit extends Cubit<CountryListState> {
  final CountryListRepository _countryListRepository;

  CountryListCubit(
    this._countryListRepository,
  ) : super(const CountryListState.idle());

  Future<void> load() async {
    try {
      emit(CountryListState.loading(countriesList: state.countriesList));
      final countriesList = await _countryListRepository.getCountries();
      await Future<void>.delayed(Duration(seconds: 3));
      emit(CountryListState.loaded(countriesList: countriesList));
    } on Object catch (e, st) {
      onError(e, st);
    }
  }
}

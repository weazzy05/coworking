import 'package:coworking_mobile/src/feature/country_list/data/country_list_data_source.dart';
import 'package:coworking_mobile/src/feature/country_list/model/country_dto.dart';

/// {@template rooms_repository}
/// CountryListRepository repository.
/// {@endtemplate}
abstract interface class CountryListRepository {
  /// Get the list of countries
  Future<List<CountryDto>> getCountries();
}

/// {@macro country_list_repository}
final class CountryListRepositoryImpl implements CountryListRepository {
  final CountryListDataSource _dataSource;

  /// {@macro country_list_repository}
  const CountryListRepositoryImpl(this._dataSource);

  @override
  Future<List<CountryDto>> getCountries() => _dataSource.getCountriesList();
}

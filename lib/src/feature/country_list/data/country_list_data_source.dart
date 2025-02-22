import 'dart:convert';

import 'package:coworking_mobile/src/core/constant/mock_data.dart';
import 'package:coworking_mobile/src/feature/country_list/model/country_dto.dart';
import 'package:http/http.dart';

/// {@template pokemon_data_source}
/// RoomList data source.
/// {@endtemplate}
abstract interface class CountryListDataSource {
  /// Get the list of rooms
  Future<List<CountryDto>> getCountriesList();
}

/// {@macro rooms_list_data_source}
final class CountryListDataSourceNetwork implements CountryListDataSource {
  final Client _client;

  /// {@macro rooms_list_data_source}
  const CountryListDataSourceNetwork(this._client);

  @override
  Future<List<CountryDto>> getCountriesList() async {
    final response = await _client.get(Uri.parse('/countries'));
    final json = jsonDecode(response.body) as List<Object?>;

    final rooms = json.map((e) {
      return CountryDto.fromJson(e as Map<String, dynamic>);
    }).toList();

    return rooms;
  }
}

/// {@macro rooms_list_data_source}
final class CountryListDataSourceLocal implements CountryListDataSource {
  /// {@macro rooms_list_data_source}
  const CountryListDataSourceLocal();

  @override
  Future<List<CountryDto>> getCountriesList() async => MockData.getCountries();
}

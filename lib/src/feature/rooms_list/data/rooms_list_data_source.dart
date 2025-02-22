import 'dart:convert';

import 'package:coworking_mobile/src/core/constant/mock_data.dart';
import 'package:coworking_mobile/src/feature/rooms_list/model/rooms_dto.dart';
import 'package:http/http.dart';

/// {@template pokemon_data_source}
/// RoomList data source.
/// {@endtemplate}
abstract interface class RoomsListDataSource {
  /// Get the list of rooms
  Future<List<Rooms>> getRoomsList(String cityId);
}

/// {@macro rooms_list_data_source}
final class RoomsListDataSourceNetwork implements RoomsListDataSource {
  final Client _client;

  /// {@macro rooms_list_data_source}
  const RoomsListDataSourceNetwork(this._client);

  @override
  Future<List<Rooms>> getRoomsList(String cityId) async {
    final response = await _client.get(Uri.parse('/rooms'));
    final json = jsonDecode(response.body) as List<Object?>;

    final rooms = json.map((e) {
      if (e
          case {
            'id': final String id,
            'city_id': final String cityId,
            'square': final int square,
            'city': final String city,
            'imagesPath': final List<String> imagesPath,
          }) {
        return Rooms(
          id: id,
          square: square,
          cityId: cityId,
          city: city,
          imagesPath: imagesPath,
        );
      }

      throw FormatException('Invalid response $e');
    }).toList();

    return rooms;
  }
}

/// {@macro rooms_list_data_source}
final class RoomsListDataSourceLocal implements RoomsListDataSource {
  /// {@macro rooms_list_data_source}
  const RoomsListDataSourceLocal();

  @override
  Future<List<Rooms>> getRoomsList(String cityId) async =>
      MockData.getRooms(cityId: cityId);
}

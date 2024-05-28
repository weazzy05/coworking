import 'dart:convert';

import 'package:coworking_mobile/src/core/constant/assets_path.dart';
import 'package:coworking_mobile/src/core/constant/mock_data.dart';
import 'package:coworking_mobile/src/feature/rooms_details/model/rooms_details_dto.dart';
import 'package:http/http.dart';

/// {@template pokemon_data_source}
/// RoomList data source.
/// {@endtemplate}
abstract interface class RoomsDetailsDataSource {
  /// Get the list of rooms
  Future<RoomsDetails> getRoomsDetails(String id);
}

/// {@macro rooms_list_data_source}
final class RoomsDetailsDataSourceNetwork implements RoomsDetailsDataSource {
  final Client _client;

  /// {@macro rooms_list_data_source}
  const RoomsDetailsDataSourceNetwork(this._client);

  @override
  Future<RoomsDetails> getRoomsDetails(String id) async {
    final response = await _client.get(Uri.parse('/rooms/details/${id}'));
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    final roomDetails = RoomsDetails.fromJson(json);

    return roomDetails;
  }
}

/// {@macro rooms_list_data_source}
final class RoomsDetailsDataSourceLocal implements RoomsDetailsDataSource {
  /// {@macro rooms_list_data_source}
  const RoomsDetailsDataSourceLocal();

  @override
  Future<RoomsDetails> getRoomsDetails(String id) async {
    final rooms = MockData.getRooms();
    final roomWithSameId = rooms.firstWhere((element) => element.id == id);
    return RoomsDetails(
      id: roomWithSameId.id,
      city: roomWithSameId.city,
      titleImage: PngAssetPath.titleFakeRoom,
      rooms: [
        RoomDetailEntity(
          title: '',
          description: MockData.getDescriptionForRoomFromId(id),
          includedAdvantages: MockData.getIncludedAdvantagesForRoomFromId(id),
          imagesPath: [MockData.getImageForRoomFromId(id)],
        ),
      ],
    );
  }
}

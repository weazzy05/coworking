import 'package:coworking_mobile/src/feature/rooms_list/data/rooms_list_data_source.dart';
import 'package:coworking_mobile/src/feature/rooms_list/model/rooms_dto.dart';

/// {@template rooms_repository}
/// RoomsList repository.
/// {@endtemplate}
abstract interface class RoomsListRepository {
  /// Get the list of pokemons
  Future<List<Rooms>> getRooms(String cityId);
}

/// {@macro rooms_repository}
final class RoomsListRepositoryImpl implements RoomsListRepository {
  final RoomsListDataSource _dataSource;

  /// {@macro rooms_repository}
  const RoomsListRepositoryImpl(this._dataSource);

  @override
  Future<List<Rooms>> getRooms(String cityId) =>
      _dataSource.getRoomsList(cityId);
}

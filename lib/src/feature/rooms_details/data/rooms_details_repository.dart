import 'package:coworking_mobile/src/feature/rooms_details/data/rooms_details_data_source.dart';
import 'package:coworking_mobile/src/feature/rooms_details/model/rooms_details_dto.dart';

/// {@template rooms_repository}
/// RoomsDetails repository.
/// {@endtemplate}
abstract interface class RoomsDetailsRepository {
  /// Get the list of pokemons
  Future<RoomsDetails> getRoomsDetails(String id);
}

/// {@macro rooms_repository}
final class RoomsDetailsRepositoryImpl implements RoomsDetailsRepository {
  final RoomsDetailsDataSource _dataSource;

  /// {@macro rooms_repository}
  const RoomsDetailsRepositoryImpl(this._dataSource);

  @override
  Future<RoomsDetails> getRoomsDetails(String id) =>
      _dataSource.getRoomsDetails(id);
}

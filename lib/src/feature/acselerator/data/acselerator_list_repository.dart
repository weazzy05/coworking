import 'package:coworking_mobile/src/feature/acselerator/data/acselerator_list_data_source.dart';
import 'package:coworking_mobile/src/feature/acselerator/model/acselerator_dto.dart';

/// {@template rooms_repository}
/// RoomsList repository.
/// {@endtemplate}
abstract interface class AcseleratorListRepository {
  /// Get the list of pokemons
  Future<List<Acselerator>> getAcseleratorList();
}

/// {@macro rooms_repository}
final class AcseleratorListRepositoryImpl implements AcseleratorListRepository {
  final AcseleratorListDataSource _dataSource;

  /// {@macro rooms_repository}
  const AcseleratorListRepositoryImpl(this._dataSource);

  @override
  Future<List<Acselerator>> getAcseleratorList() =>
      _dataSource.getAcseleratorList();
}

import 'package:coworking_mobile/src/feature/acselerator_details/data/acselerator_details_data_source.dart';
import 'package:coworking_mobile/src/feature/acselerator_details/model/acselector_details_dto.dart';

/// {@template rooms_repository}
/// RoomsDetails repository.
/// {@endtemplate}
abstract interface class AcseleratorDetailsRepository {
  /// Get the list of pokemons
  Future<AcseleratorDetails> getAcselectorDetails(String id);
}

/// {@macro rooms_repository}
final class AcseleratorDetailsRepositoryImpl
    implements AcseleratorDetailsRepository {
  final AcseleratorDetailsDataSource _dataSource;

  /// {@macro rooms_repository}
  const AcseleratorDetailsRepositoryImpl(this._dataSource);

  @override
  Future<AcseleratorDetails> getAcselectorDetails(String id) =>
      _dataSource.getAcselectorDetails(id);
}

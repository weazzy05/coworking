import 'package:coworking_mobile/src/core/constant/mock_data.dart';
import 'package:coworking_mobile/src/feature/acselerator/model/acselerator_dto.dart';

/// {@template pokemon_data_source}
/// RoomList data source.
/// {@endtemplate}
abstract interface class AcseleratorListDataSource {
  /// Get the list of rooms
  Future<List<Acselerator>> getAcseleratorList();
}

/// {@macro rooms_list_data_source}
final class AcseleratorListDataSourceLocal
    implements AcseleratorListDataSource {
  /// {@macro rooms_list_data_source}
  const AcseleratorListDataSourceLocal();

  @override
  Future<List<Acselerator>> getAcseleratorList() async =>
      MockData.getAcselerators();
}

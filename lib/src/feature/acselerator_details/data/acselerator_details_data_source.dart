import 'package:coworking_mobile/src/core/constant/mock_data.dart';
import 'package:coworking_mobile/src/feature/acselerator_details/model/acselector_details_dto.dart';

/// {@template pokemon_data_source}
/// RoomList data source.
/// {@endtemplate}
abstract interface class AcseleratorDetailsDataSource {
  /// Get the list of rooms
  Future<AcseleratorDetails> getAcselectorDetails(String id);
}

/// {@macro rooms_list_data_source}
final class AcseleratorDetailsDataSourceLocal
    implements AcseleratorDetailsDataSource {
  /// {@macro rooms_list_data_source}
  const AcseleratorDetailsDataSourceLocal();

  @override
  Future<AcseleratorDetails> getAcselectorDetails(String id) async {
    final acselector = MockData.getAcselectorById(id);
    final description = MockData.getDescriptionForAcselectorFromId(id);
    return AcseleratorDetails(
      id: acselector.id,
      pdfPath: acselector.pdfPath,
      description: description,
    );
  }
}

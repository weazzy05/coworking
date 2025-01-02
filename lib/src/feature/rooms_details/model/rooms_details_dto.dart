import 'package:freezed_annotation/freezed_annotation.dart';

part 'rooms_details_dto.freezed.dart';
part 'rooms_details_dto.g.dart';

@freezed
class RoomsDetails with _$RoomsDetails {
  factory RoomsDetails({
    required String id,
    required String city,
    required String titleImage,
    required List<RoomDetailEntity> rooms,
  }) = _RoomsDetails;

  factory RoomsDetails.fromJson(Map<String, dynamic> json) =>
      _$RoomsDetailsFromJson(json);
}

@freezed
class RoomDetailEntity with _$RoomDetailEntity {
  factory RoomDetailEntity({
    required String title,
    required String description,
    required List<String> includedAdvantages,
    required String tourUrl,
    required List<String> imagesPath,
  }) = _RoomDetailEntity;

  factory RoomDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$RoomDetailEntityFromJson(json);
}

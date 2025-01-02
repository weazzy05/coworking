import 'package:freezed_annotation/freezed_annotation.dart';

part 'rooms_dto.freezed.dart';
part 'rooms_dto.g.dart';

/// Rooms model
///
@freezed
class Rooms with _$Rooms {
  /// Rooms create
  factory Rooms({
    required String id,
    required String cityId,
    required int square,
    required String city,
    required List<String> imagesPath,
  }) = _Rooms;

  factory Rooms.fromJson(Map<String, dynamic> json) => _$RoomsFromJson(json);
}

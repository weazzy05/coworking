import 'package:freezed_annotation/freezed_annotation.dart';

part 'acselerator_dto.freezed.dart';
part 'acselerator_dto.g.dart';

/// Rooms model
///
@freezed
class Acselerator with _$Acselerator {
  /// Rooms create
  factory Acselerator({
    required String id,
    required String imagePath,
    required String pdfPath,
  }) = _Acselerator;

  factory Acselerator.fromJson(Map<String, dynamic> json) =>
      _$AcseleratorFromJson(json);
}

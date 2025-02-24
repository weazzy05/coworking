import 'package:freezed_annotation/freezed_annotation.dart';

part 'acselector_details_dto.freezed.dart';
part 'acselector_details_dto.g.dart';

@freezed
class AcseleratorDetails with _$AcseleratorDetails {
  factory AcseleratorDetails({
    required String id,
    required String description,
    // required String author,
    required String pdfPath,
  }) = _AcseleratorDetails;

  factory AcseleratorDetails.fromJson(Map<String, dynamic> json) =>
      _$AcseleratorDetailsFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';

part 'verify_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class VerifyDTO {
  final String tokenType;
  final int userId;
  final String googleId;

  const VerifyDTO({
    required this.tokenType,
    required this.userId,
    required this.googleId,
  });

  factory VerifyDTO.fromJson(Map<String, dynamic> json) => _$VerifyDTOFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyDTOToJson(this);
}

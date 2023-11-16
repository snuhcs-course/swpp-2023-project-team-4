import 'package:json_annotation/json_annotation.dart';

part 'token_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class TokenDTO {
  final String accessToken;
  final String refreshToken;

  const TokenDTO({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenDTO.fromJson(Map<String, dynamic> json) => _$TokenDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TokenDTOToJson(this);
}

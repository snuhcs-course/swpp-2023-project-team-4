import 'package:json_annotation/json_annotation.dart';

part 'emotion_return_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class EmotionReturnDTO {
  final int emotion;
  final int netPrice;
  final int totalPrice;
  final double returnRate;

  EmotionReturnDTO({
    required this.emotion,
    required this.netPrice,
    required this.totalPrice,
    required this.returnRate,
  });

  factory EmotionReturnDTO.fromJson(Map<String, dynamic> json) => _$EmotionReturnDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EmotionReturnDTOToJson(this);
}

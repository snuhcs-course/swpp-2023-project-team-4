import 'package:json_annotation/json_annotation.dart';

part 'day_record_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class DayRecordDTO {
  final int date;
  final int emotion;
  final String text;

  const DayRecordDTO({
    required this.date,
    required this.emotion,
    required this.text,
  });

  factory DayRecordDTO.fromJson(Map<String, dynamic> json) => _$DayRecordDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DayRecordDTOToJson(this);
}

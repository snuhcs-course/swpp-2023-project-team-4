import 'package:json_annotation/json_annotation.dart';

part 'day_record_dto_2.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class DayRecordDTO2 {
  final int id;
  final String date;
  final int value;

  const DayRecordDTO2({
    required this.id,
    required this.date,
    required this.value,
  });

  factory DayRecordDTO2.fromJson(Map<String, dynamic> json) => _$DayRecordDTO2FromJson(json);

  Map<String, dynamic> toJson() => _$DayRecordDTO2ToJson(this);
}

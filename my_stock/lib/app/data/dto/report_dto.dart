import 'package:json_annotation/json_annotation.dart';

part 'report_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class ReportDTO {
  final String title;
  final String body;

  const ReportDTO({
    required this.title,
    required this.body,
  });

  factory ReportDTO.fromJson(Map<String, dynamic> json) => _$ReportDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDTOToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'balance_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class BalanceDTO {
  final String ticker;
  final int quantity;
  final int balance;
  @JsonKey(name: "return")
  final int returnAmount;

  const BalanceDTO({
    required this.ticker,
    required this.quantity,
    required this.balance,
    required this.returnAmount,
  });

  factory BalanceDTO.fromJson(Map<String, dynamic> json) => _$BalanceDTOFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceDTOToJson(this);
}

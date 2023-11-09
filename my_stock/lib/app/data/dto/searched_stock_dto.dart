import 'package:json_annotation/json_annotation.dart';

part 'searched_stock_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class SearchedStockDTO {
  final String ticker;
  final String name;
  final int currentPrice;
  final int closingPrice;
  final double fluctuationRate;
  final String marketType;

  const SearchedStockDTO({
    required this.ticker,
    required this.name,
    required this.currentPrice,
    required this.closingPrice,
    required this.fluctuationRate,
    required this.marketType,
  });

  factory SearchedStockDTO.fromJson(Map<String, dynamic> json) => _$SearchedStockDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SearchedStockDTOToJson(this);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_state.freezed.dart';

@freezed
class MarketState with _$MarketState {
  const factory MarketState({
    @Default(false) bool loading,
    @Default([]) List<String> categories,
  }) = _MarketState;
}
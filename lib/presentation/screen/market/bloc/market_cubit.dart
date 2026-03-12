import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  MarketCubit() : super(const MarketState());

  void loadMarket() async {
    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(seconds: 1));

    emit(
      state.copyWith(
        loading: false,
        categories: [
          "Thiết bị đóng cắt",
          "Đồng hồ đo",
          "IoT Gateway",
          "Sensors",
          "Năng lượng",
          "Camera",
        ],
      ),
    );
  }
}
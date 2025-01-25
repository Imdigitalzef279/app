import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.dart';

part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void showLoading() {
    emit(state.copyWith(isShowLoading: true));
  }

  void hideShowLoading() {
    emit(state.copyWith(isShowLoading: false));
  }
}

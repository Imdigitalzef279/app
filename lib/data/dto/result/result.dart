import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/application/enums/load_status.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const Result._();

  const factory Result(
      {T? data,
      @Default(LoadStatus.initial) LoadStatus status,
      @Default('') String error}) = _Result;

  bool get isSuccess => status == LoadStatus.success;

  Result<T> get isLoading => copyWith(status: LoadStatus.loading);

  Widget buildWhen(
      {Widget Function()? loading,
      required Widget Function(T? data) success,
      required Widget Function(String error) error}) {
    switch (status) {
      case LoadStatus.loading:
        return loading?.call() ??
            const Center(child: CircularProgressIndicator());
      case LoadStatus.failure:
        return error.call(this.error);
      case LoadStatus.success:
        return success.call(data);
      default:
        return const SizedBox();
    }
  }

  void when(
      {void Function()? loading,
      void Function(T? data)? success,
      void Function(String error)? error}) {
    switch (status) {
      case LoadStatus.loading:
        loading?.call();
        break;
      case LoadStatus.failure:
        error?.call(this.error);
        break;
      case LoadStatus.success:
        success?.call(data);
        break;
      default:
    }
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success;

  const factory Result.error(String message) = Error;

  const factory Result.loading({T? data}) = Loading;

  const factory Result.empty() = Empty;

}

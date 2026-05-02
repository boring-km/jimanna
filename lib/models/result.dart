import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;

  const factory Result.error(String message) = Error<T>;

  const factory Result.loading({T? data}) = Loading<T>;

  const factory Result.empty() = Empty<T>;
}

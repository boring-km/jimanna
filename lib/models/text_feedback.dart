import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_feedback.g.dart';

@JsonSerializable()
class TextFeedback {
  TextFeedback(this.content, this.timeText);

  factory TextFeedback.fromJson(Map<String, dynamic> json) => _$TextFeedbackFromJson(json);
  final String content;
  final String timeText;

  Map<String, dynamic> toJson() => _$TextFeedbackToJson(this);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_feedback.g.dart';

@JsonSerializable()
class TextFeedback {
  TextFeedback({
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.answer5,
    required this.answer6,
    required this.timeText,
  });

  factory TextFeedback.fromJson(Map<String, dynamic> json) =>
      _$TextFeedbackFromJson(json);
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String answer5;
  final String answer6;
  final String timeText;

  Map<String, dynamic> toJson() => _$TextFeedbackToJson(this);
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/text_feedback.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final adminFeedbackProvider =
    NotifierProvider<AdminFeedbackNotifier, List<TextFeedback>>(
  AdminFeedbackNotifier.new,
);

class AdminFeedbackNotifier extends Notifier<List<TextFeedback>> {
  late final _feedbackRef = FireStoreFactory.feedbackRef();

  @override
  List<TextFeedback> build() {
    final sub = _feedbackRef.snapshots().listen((value) {
      state = value.docs.map((e) => e.data()).toList();
    });
    ref.onDispose(sub.cancel);
    return [];
  }
}

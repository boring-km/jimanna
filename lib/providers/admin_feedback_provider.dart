import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/text_feedback.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final adminFeedbackProvider =
    StateNotifierProvider<AdminFeedbackNotifier, List<TextFeedback>>(
  (ref) => AdminFeedbackNotifier(),
);

class AdminFeedbackNotifier extends StateNotifier<List<TextFeedback>> {
  AdminFeedbackNotifier() : super([]) {
    loadFeedback();
  }

  final _feedbackRef = FireStoreFactory.feedbackRef();

  void loadFeedback() {
    _feedbackRef.snapshots().listen((value) {
      state = value.docs.map((e) => e.data()).toList();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/admin_feedback_provider.dart';

class AdminFeedbackResultPage extends ConsumerWidget {
  const AdminFeedbackResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(adminFeedbackProvider);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('처음으로'),
              ),
              const SizedBox(height: 40),
              const Text('피드백 결과', style: TextStyle(fontSize: 30)),
              const SizedBox(height: 40),
              for (final feedback in list)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(feedback.content),
                        const SizedBox(height: 20),
                        Text(feedback.timeText),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

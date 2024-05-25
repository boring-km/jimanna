import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/admin_feedback_provider.dart';

const questions = '''
1. 귀하의 소속을 알려주세요(파카드/아바드)

2. 평소에 청년부내에서 연합의 중요성을 많이 느끼셨나요?

3. 연합지만나가 연합을 위해 큰 역할이 됐다고 생각되시나요? 아니라면 더 좋은 연합의 방법이 있을까요?

4. 다음번에도 연합지만나가 열린다면 참여할 의향이 있으신가요? 만약 어려우시다면 이유를 말씀해 주실 수 있을까요?

5. 청년부내에서 하시고 싶은 행사나 원하시는 방향성이 있으실까요?

6. 마지막으로 전도사님께 한 말씀 부탁드리겠습니다. 
              ''';

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
              const Text(questions),
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
                        Text('1: 소속 ${feedback.answer1}'),
                        const SizedBox(height: 20),
                        Text('2: ${feedback.answer2}'),
                        const SizedBox(height: 20),
                        Text('3: ${feedback.answer3}'),
                        const SizedBox(height: 20),
                        Text('4: ${feedback.answer4}'),
                        const SizedBox(height: 20),
                        Text('5: ${feedback.answer5}'),
                        const SizedBox(height: 20),
                        Text('6: ${feedback.answer6}'),
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
